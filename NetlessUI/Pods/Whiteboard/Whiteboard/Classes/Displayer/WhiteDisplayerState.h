//
//  WhiteDisplayerState.h
//  WhiteSDK
//
//  Created by yleaf on 2019/7/22.
//

#import "WhiteObject.h"
#import "WhiteGlobalState.h"
#import "WhiteRoomMember.h"
#import "WhiteSceneState.h"
#import <YYModel/YYModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface WhiteDisplayerState : WhiteObject<YYModel>

/**
 配置自定义全局状态类

 @param clazz 自定义全局状态类，必须是 WhiteGlobalState 子类，否则会清空该配置。
 Swift 用户，在配置 WhiteGlobalState 子类属性时，需要对属性添加 @objc 修饰符。
 @return 全局自定义类配置成功与否；返回 YES 则成功配置子类；返回 NO 则恢复为 WhiteGlobalState 类。
 */
+ (BOOL)setCustomGlobalStateClass:(Class)clazz;

/** 全局状态参数，所有成员都可以修改 */
@property (nonatomic, strong, readonly, nullable) WhiteGlobalState *globalState;

/** 白板在线用户列表 */
@property (nonatomic, strong, readonly, nullable) NSArray<WhiteRoomMember *> *roomMembers;

/** 场景页面状态 */
@property (nonatomic, strong, readonly, nullable) WhiteSceneState *sceneState;

@end

NS_ASSUME_NONNULL_END
