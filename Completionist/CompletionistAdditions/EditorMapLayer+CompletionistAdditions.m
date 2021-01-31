//
//  EditorMapLayer+CompletionistAdditions.m
//  Go Map!!
//
//  Created by Wolfgang Timme on 31.01.21.
//  Copyright © 2021 Bryce. All rights reserved.
//

#import "EditorMapLayer+CompletionistAdditions.h"

@interface EditorMapLayer()

@property (nonatomic, readonly) id<MapViewQuestAnnotationManaging> questAnnotationManager;

@end

@implementation EditorMapLayer (CompletionistAdditions)

- (id<MapViewQuestAnnotationManaging>)questAnnotationManager {
    return MapViewQuestAnnotationManager.shared;
}

- (void)observeQuestChanges {
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(didReceiveActiveQuestsChangedNotification:)
                                               name:@"QuestManagerDidUpdateActiveQuests"
                                             object:nil];
}

- (void)didReceiveActiveQuestsChangedNotification:(NSNotification *)note {
    [self resetDisplayLayers];
}

/**
 Determines the `CALayer` to render in order to visually indicate that the given `OsmNode` is part of a quest.

 @param node The node to determine the `CALayer` for.
 @return The layer that should be rendered in order to indicate a quest for the given node.
 */
- (CALayerWithProperties *)questAnnotationLayerWithNode:(OsmNode *)node {
    if (![self.questAnnotationManager shouldShowQuestAnnotationFor:node]) {
        return nil;
    }

    CGFloat diameter = MinIconSizeInPixels + 10;

    CALayerWithProperties *layer = [CALayerWithProperties new];
    layer.bounds = CGRectMake(0, 0, diameter, diameter);

    layer.cornerRadius = diameter / 2;
    layer.masksToBounds = YES;

    layer.borderColor = [UIColor colorWithRed:0 green:0.19921875 blue:0.99609375 alpha:0.7].CGColor;
    layer.borderWidth = 2;

    layer.backgroundColor = [UIColor colorWithRed:0.99609375 green:0.796875 blue:0 alpha:0.3].CGColor;

    layer.zPosition = Z_NODE;

    LayerProperties * props = [LayerProperties new];
    props->position = MapPointForLatitudeLongitude( node.lat, node.lon );
    [layer setValue:props forKey:@"properties"];

    return layer;
}

/**
 Determines the `CALayer` to render in order to visually indicate that the given `OsmWay` is part of a quest.

 @param way The way to determine the `CALayer` for.
 @return The layer that should be rendered in order to indicate a quest for the given way.
 */
- (CALayer *)questAnnotationLayerWithWay:(OsmWay *)way {
    if (![self.questAnnotationManager shouldShowQuestAnnotationFor:way]) {
        return nil;
    }

    OSMPoint refPoint = { 0, 0 };
    CGPathRef path = [way linePathForObjectWithRefPoint:&refPoint];

    CGFloat lineWidth = MAX(way.renderInfo.lineWidth * _highwayScale, 1);

    /// Since the layer will be drawn on top of the streets, make a bit wider so that the underlying way is visible.
    lineWidth += 3 * _highwayScale;

    CAShapeLayerWithProperties *layer = [CAShapeLayerWithProperties new];
    layer.anchorPoint = CGPointMake(0, 0);
    CGRect bbox = CGPathGetPathBoundingBox(path);
    layer.bounds = CGRectMake(0, 0, bbox.size.width, bbox.size.height);
    layer.position = CGPointFromOSMPoint( refPoint );
    layer.path = path;
    layer.strokeColor = [UIColor colorWithRed:0/255 green:51/255 blue:255/255 alpha:0.6].CGColor;
    layer.fillColor = nil;
    layer.lineWidth = lineWidth;
    layer.lineCap = DEFAULT_LINECAP;
    layer.lineJoin = DEFAULT_LINEJOIN;
    layer.zPosition = Z_LINE + 1;

    LayerProperties *props = [LayerProperties new];
    [layer setValue:props forKey:@"properties"];
    props->position = refPoint;
    props->lineWidth = layer.lineWidth;

    CGPathRelease(path);

    return layer;
}

@end
