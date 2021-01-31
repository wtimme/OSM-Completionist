//
//  EditorMapLayer+CompletionistAdditions.m
//  Go Map!!
//
//  Created by Wolfgang Timme on 31.01.21.
//  Copyright © 2021 Bryce. All rights reserved.
//

#import "EditorMapLayer+CompletionistAdditions.h"

@implementation EditorMapLayer (CompletionistAdditions)

- (void)observeQuestChanges {}

- (CALayer *)questAnnotationLayerWithWay:(OsmWay *)way {
    return nil;
}
- (CALayerWithProperties *)questAnnotationLayerWithNode:(OsmNode *)node {
    return nil;
}

@end
