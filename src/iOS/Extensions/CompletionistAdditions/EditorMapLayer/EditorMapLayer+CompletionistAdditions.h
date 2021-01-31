//
//  EditorMapLayer+CompletionistAdditions.h
//  Go Map!!
//
//  Created by Wolfgang Timme on 31.01.21.
//  Copyright © 2021 Bryce. All rights reserved.
//

#import "EditorMapLayer.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Extension that adds additional behaviour to a class that is originally part of GoMap.
 
 The implementation differs depends on where this extension is used:
 - In GoMap, the implementation of these methods is just empty.
 - In Completionist, the methods are implemented and have functionality.
 
 The header only exists one time, but has two implementation files (`.m`), depending on the target.
 When changing something about this header, make sure to update both implementation files!
 */
@interface EditorMapLayer (CompletionistAdditions)

- (void)observeQuestChanges;

- (nullable CALayer *)questAnnotationLayerWithWay:(OsmWay *)way;

- (nullable CALayerWithProperties *)questAnnotationLayerWithNode:(OsmNode *)node;

@end

NS_ASSUME_NONNULL_END
