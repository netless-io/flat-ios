//
//  WhiteSceneState.h
//  WhiteSDK
//
//  Created by yleaf on 2019/2/25.
//

#import "WhiteObject.h"
#import "WhiteScene.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhiteSceneState : WhiteObject

/** 当前场景目录下的所有场景 */
@property (nonatomic, nonnull, strong, readonly) NSArray<WhiteScene *> *scenes;
/** 当前场景的场景路径（场景目录+当前场景名） */
@property (nonatomic, nonnull, strong, readonly) NSString *scenePath;
/** 当前场景，在 scenes property 中的顺序索引 */
@property (nonatomic, assign, readonly) NSInteger index;

@end

NS_ASSUME_NONNULL_END
