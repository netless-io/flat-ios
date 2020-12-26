//
//  WhiteRoom.h
//  dsBridge
//
//  Created by leavesster on 2018/8/11.
//

#import <Foundation/Foundation.h>
#import "WhiteGlobalState.h"
#import "WhiteMemberState.h"
#import "WhiteImageInformation.h"
#import "WhitePptPage.h"
#import "WhiteRoomMember.h"
#import "WhiteBroadcastState.h"
#import "WhiteRoomCallbacks.h"
#import "WhiteRoomState.h"
#import "WhiteEvent.h"
#import "WhiteScene.h"
#import "WhiteSceneState.h"
#import "WhitePanEvent.h"
#import "WhiteDisplayer.h"
#import "WhiteSDK+Room.h"

@class WhiteBoardView;

NS_ASSUME_NONNULL_BEGIN

@interface WhiteRoom : WhiteDisplayer

#pragma mark - 同步 API
/** 当前用户在白板上的序号 id。
 从 0 开始，与该用户在 RoomMember 中的 memberId 相同。
 */
@property (nonatomic, strong, readonly) NSNumber *observerId;
/** 房间 uuid */
@property (nonatomic, copy, readonly) NSString *uuid;
/** 全局状态，由于遗留问题，目前该 API，不支持 customGlobalState，如需获取 customGlobalState，请使用 room.state.globalState */
@property (nonatomic, strong, readonly) WhiteGlobalState *globalState;
/** 教具信息 */
@property (nonatomic, strong, readonly) WhiteReadonlyMemberState *memberState;
/** 白板在线成员信息 */
@property (nonatomic, strong, readonly) NSArray<WhiteRoomMember *> *roomMembers;
/** 视角状态信息，用户当前场景状态，主播信息 */
@property (nonatomic, strong, readonly) WhiteBroadcastState *broadcastState;
/** 缩放比例 */
@property (nonatomic, assign, readonly) CGFloat scale;
/** 房间状态信息，继承自 WhiteDisplayerState（Room 与 Player 共同状态）*/
@property (nonatomic, strong, readonly) WhiteRoomState *state;
/** 白板页面（场景）状态，属于房间状态之一 */
@property (nonatomic, strong, readonly) WhiteSceneState *sceneState;
/** 连接状态 */
@property (nonatomic, assign, readonly) WhiteRoomPhase phase;

#pragma mark - Set API

/**
 白板所有人共享的全局状态
 1.0 迁移用户，请阅读文档站中 [页面（场景）管理] ，使用setScencePath API 进行翻页。
 */
- (void)setGlobalState:(WhiteGlobalState * )globalState;

/** 目前主要用来切换教具 */
- (void)setMemberState:(WhiteMemberState *)modifyState;

/** 切换用户视角模式 */
- (void)setViewMode:(WhiteViewMode)viewMode;


#pragma mark - Action API

/** 白板 debug 用的一些信息 */
- (void)debugInfo:(void (^ _Nullable)(NSDictionary * _Nullable dict))completionHandler;

/**
 如果白板窗口大小改变，需要重新调用该方法刷新尺寸。
 查看父类 WhiteDisplayer 类中方法
 */
//- (void)refreshViewSize;

/** 主动断开连接，仍会触发 phaseChange API */
- (void)disconnect:(void (^ _Nullable) (void))completeHandler;

/** 在调用主动断连时，该值会被立即赋值为 YES，可以用于在 phaseChange 中区分 disconnect 原因 */
@property (nonatomic, assign, readonly) BOOL disconnectedBySelf;

/**
 读写模式切换。传入 false，进入只读模式，此时无法执行任何可以影响他人的 API 操作，当前用户也不会在房间用户列表。
 在加入房间前，就可以在 WhiteRoomConfig 中设置 isWritable ，来决定该模式。
 */
- (void)setWritable:(BOOL)writable completionHandler:(void (^ _Nullable)(BOOL isWritable, NSError * _Nullable error))completionHandler;
/** 读写模式查询 API */
@property (nonatomic, assign, readonly, getter=isWritable) BOOL writable;


/**
 禁止视野移动，视角为 follower + disableCameraTransform true 时，可以保证观众永远处于观众模式，永远跟随主播。
 @param disableCameraTransform 是否禁止移动，true 为禁止。
 */
- (void)disableCameraTransform:(BOOL)disableCameraTransform;

/**
 禁止用户的教具操作
 @param disable 是否禁止教具操作，true 为禁止。
 */
- (void)disableDeviceInputs:(BOOL)disable;

/**
 发送自定义事件，详细内容，可以查看文档，或者单元测试代码，
 注册，移除自定义事件 API，在 WhiteDisplayer 父类中
 */
- (void)dispatchMagixEvent:(NSString *)eventName payload:(NSDictionary *)payload;

#pragma mark - PPT

/**
 * 动态 ppt 下一步动画 API
 * 如果当前页面，ppt 步骤动画，已经全部执行完，执行该 API 会进入（同一个目录）下一页；没有则不动。
 * 如果当前页面，没有动态 ppt，会进入（同一个目录）下一页；没有则不动。
 */
- (void)pptNextStep;

/**
 * 动态 ppy 上一步动画 API
 * 如果当前页面，ppt 步骤动画，已经是初始状态，执行该 API 会进入（同一个目录）上一页，并保持为上一页最后一个动画状态；没有则不动。
 * 如果当前页面，没有动态 ppt，会退回（同一页面）上一页；没有则不动。
 */
- (void)pptPreviousStep;

#pragma mark - Image API

/**
 * 插入网络图片 API
 * 一次传入图片坐标，大小信息，以及图片地址。是 insertImage: 和 completeImageUploadWithUuid:src: 的封装。
 * */
- (void)insertImage:(WhiteImageInformation *)imageInfo src:(NSString *)src;

/**
 图片占位，会立即在白板上显示一个占位图
 */
- (void)insertImage:(WhiteImageInformation *)imageInfo;

/**
 替换占位图中的内容，如不需要占位符显示，可以直接使用 insertImage:src: API

 @param uuid insertImage API 中，imageInfo 传入的图片 uuid
 @param src 图片的网络地址
 */
- (void)completeImageUploadWithUuid:(NSString *)uuid src:(NSString *)src;

/**
 * 切换橡皮教具配置，true 为禁止擦除图片，false 为可以擦除。
 */
- (void)disableEraseImage:(BOOL)disable;

#pragma mark - 延时

/** 白板延时 API
 配合 rtmp 等有延迟的视频推流，人为延迟白板内容。
 白板内所有内容（包括自定义事件，GlobalState，RoomState 变化），都会被延时，只有当前用户自己的输入行为，不会有延时
 */
- (void)setTimeDelay:(NSTimeInterval)delay;
@property (nonatomic, assign, readonly) NSTimeInterval delay;

@end


#pragma mark - 页面（场景）管理 API
/** 白板场景（多页面）API，为了更好理解本部分 API，请先阅读 [文档站](https://developer.neltess.link/) 中 [场景管理] 部分概念介绍 */
@interface WhiteRoom (Scene)

/** 获取场景 State，具体信息可以查看 WhiteSceneState 类 */
- (void)getSceneStateWithResult:(void (^) (WhiteSceneState *state))result;

/** 获取当前目录下，所有页面的信息 */
- (void)getScenesWithResult:(void (^) (NSArray<WhiteScene *> *scenes))result;

/**
 切换至具体页面
 
 @param path 具体的页面路径
 
 当传入的页面路径有以下情况时，会导致调用该方法失败
 
 1. 路径不合法。请通过之前的章节确保页面路径符合规范。
 2. 路径对应的页面不存在。
 3. 路径对应的是页面组。注意页面组和页面是不一样的。
 */
- (void)setScenePath:(NSString *)path;
/** 多一个回调，如果失败，会返回具体错误内容 */
- (void)setScenePath:(NSString *)dirOrPath completionHandler:(void (^ _Nullable)(BOOL success, NSError * _Nullable error))completionHandler;

/**
 切换上下页
 
 @param index 目标场景 index。当前页面 index，可以通过 getSceneStateWithResult 获取
 @param completionHandler 完成回调，如果失败，会在 error 中的 userInfo 显示错误信息，一般为数组越界
 单纯切换上下页，可以使用 PPT API，见 ppt API 注释
 */
- (void)setSceneIndex:(NSUInteger)index completionHandler:(void (^ _Nullable)(BOOL success, NSError * _Nullable error))completionHandler;

/**
 插入，或许新建多个页面
 
 @param dir scene 页面组名称，相当于目录。
 @param scenes WhiteScence 实例；在生成 WhiteScence 时，可以同时配置 ppt。
 @param index 选择在页面组，插入的位置。index 即为新 scence 的 index 位置。如果想要放在最末尾，可以传入 NSUIntegerMax。
 
 注意：
 1. scenes 实际上只是白板页面的配置项，即使每次传入相同的 scenes，白板也会生成新页面。
 2. putScenes 调用后，并不会立即切换到对应页面，需要再调用 setScene 系列 API。
 3. putScenes 插入的白板页面，如果是当前目录下，也不能理解使用 room.sceneState 获取，需要通过对应的异步 API getRoomStateWithResult: 获取
 */
- (void)putScenes:(NSString *)dir scenes:(NSArray<WhiteScene *> *)scenes index:(NSUInteger)index;

/**
 清除当前屏幕内容
 
 @param retainPPT 是否保留 ppt
 */
- (void)cleanScene:(BOOL)retainPPT;

/**
 
 当有
 /ppt/page0
 /ppt/page1
 传入 "/ppt/page0" 时，则只删除对应页面。
 传入 "/ppt" 时，会将两个页面一起移除。
 
 @param dirOrPath 页面具体路径，或者为页面组路径
 */
- (void)removeScenes:(NSString *)dirOrPath;

/**
 移动/重命名页面
 
 @param source 想要移动的页面的绝对路径
 @param target 目标路径。如果是文件夹，则将 source 移入；否则，移动的同时重命名。
 */
- (void)moveScene:(NSString *)source target:(NSString *)target;


/**
 * 以下 API，可以对使用【选择框】教具进行操作
 */
#pragma mark - 执行操作 API

/**
 * 复制选中内容，不会粘贴，而是存储在内存中
 */
- (void)copy;

/**
 * 将 copy API 的复制内容，粘贴到白板中间（用户当前视野的中间）。多次粘贴，会有随机偏移
 */
- (void)paste;

/**
 * copy paste 组合 API
 */
- (void)duplicate;

/**
 * 删除选中内容
 */
- (void)deleteOpertion;

/**
 * 不兼容改动
 * 禁用本地序列化
 * 默认 true，即禁止启动本地序列化；
 * false 时，则打开序列化，可以对本地操作进行解析，可以执行 该 pragma mark 下的 redo undo 操作
 * 调用了该 API 的房间，将导致 web sdk 2.9.2 以下（不包含），native 端 2.9.3 以下（不包含）的客户端，崩溃。请确认使用 sdk 版本再进行开启。
 */
- (void)disableSerialization:(BOOL)disable;

/**
 * 回退 undo 的效果，需要 disableSerialization 为 false
 */
- (void)redo;

/**
 * 撤销上一步操作，需要 disableSerialization 为 false
 */
- (void)undo;

@end

#pragma mark - 异步 API
/**
 * 异步 API
 * 目前 SDK 会在状态变化时，自动更新所有对应的属性。
 * 只有在同一个代码块，立即调用了 Set API，又立刻需要看到更新内容时，才需要调用异步 API
 */
@interface WhiteRoom (Asynchronous)

/**
 获取当前房间 GlobalState， 该 API不支持自定义 GlobalState。
 通过 + (BOOL)setCustomGlobalStateClass:(Class)clazz 设置自定义状态后，如需异步获取，可以通过 getRoomStateWithResult 获取 自定义 GlobalState。
 */
- (void)getGlobalStateWithResult:(void (^) (WhiteGlobalState *state))result;
/** 获取当前房间 WhiteMemberState:教具 */
- (void)getMemberStateWithResult:(void (^) (WhiteMemberState *state))result;
/** 获取当前房间 WhiteRoomMember：房间成员信息 */
- (void)getRoomMembersWithResult:(void (^) (NSArray<WhiteRoomMember *> *roomMembers))result;
/** 获取当前视角状态 */
- (void)getBroadcastStateWithResult:(void (^) (WhiteBroadcastState *state))result;
/** 获取当前房间连接状态 */
- (void)getRoomPhaseWithResult:(void (^) (WhiteRoomPhase phase))result;
/** 获取当前缩放比例 */
- (void)getZoomScaleWithResult:(void (^) (CGFloat scale))result;
/** 获取当前房间状态，包含 globalState，教具，房间成员信息，缩放，SceneState，用户视角状态 */
- (void)getRoomStateWithResult:(void (^) (WhiteRoomState *state))result;

@end

#pragma mark - 弃用方法
@interface WhiteRoom (Deprecated)

/**
 禁止操作，不响应用户的所有操作操作，是 disableDeviceInputs: disableCameraTransform: 方法的集合。
 @param disable 是否禁止操作，true 为禁止。
 */
- (void)disableOperations:(BOOL)disable DEPRECATED_MSG_ATTRIBUTE("use disableDeviceInputs and disableCameraTransform");

/**
 缩小放大白板
 @param scale 相对于原始大小的比例，而不是相对当前的缩放比例
 */
- (void)zoomChange:(CGFloat)scale DEPRECATED_MSG_ATTRIBUTE("use moveCamera:");

/**
 获取所有 ppt 图片，回调内容为所有 ppt 图片的地址。
 @param result 如果当前页面，没有插入过 PPT，则该页面会返回一个空字符串
 */
- (void)getPptImagesWithResult:(void (^) (NSArray<NSString *> *pptPages))result DEPRECATED_MSG_ATTRIBUTE("use getScenesWithResult:");

@end

NS_ASSUME_NONNULL_END
