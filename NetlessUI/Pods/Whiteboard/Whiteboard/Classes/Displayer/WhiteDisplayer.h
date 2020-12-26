//
//  WhiteDisplayer.h
//  WhiteSDK
//
//  Created by yleaf on 2019/7/1.
//

#import <Foundation/Foundation.h>
#import "WhiteCameraConfig.h"
#import "WhiteRectangleConfig.h"
#import "WhiteCameraBound.h"
#import "WhitePanEvent.h"


typedef NS_ENUM(NSInteger, WhiteScenePathType) {
    /** 路径对应的内容为空 */
    WhiteScenePathTypeEmpty,
    /** 路径对应的内容，是一个白板页面 */
    WhiteScenePathTypePage,
    /** 路径对应的内容，是一个目录，该目录下存在目录，或者多个页面 */
    WhiteScenePathTypeDir
};

NS_ASSUME_NONNULL_BEGIN

@class WhiteScene;

@interface WhiteDisplayer : NSObject

/**
 修改白板背景色 API
 如需在显示 WhiteBoardView，未加入房间时，就改变颜色，请通过以下步骤：
 
 1. 先将 whiteboardView 实例属性 opaque 为 NO
 2. 再设置 WhiteboardView backgroundColor
 3. 在成功初始化 实时房间 / 回放房间 后，通过该 API 再次设置 backgroundColor
 4. 将 WhiteBoardView opaque 属性，恢复为 YES。（由于 ddisplayer 的 background API 实际上是异步的，所以建议延迟恢复 opaque 属性）
 
 之所以最后又把 opaque 设置为 NO，是因为 iOS 系统会进行颜色合成计算。保持为 YES，比较影响性能。
 */
@property (nonatomic, strong) UIColor *backgroundColor;

#pragma mark - 页面（场景）管理 API

/**
 * 查询路径对应的内容，还是页面（场景），或者是页面（场景）目录，或者不存在任何内容。
 */
- (void)getScenePathType:(NSString *)pathOrDir result:(void (^) (WhiteScenePathType pathType))result;

/**
 * 获取房间内所有场景列表，返回格式：
 * 场景目录路径: 对应场景目录下，所有的页面数组
 * key 为 scenepath，value 为 WhiteScene 数组。
 * 只存在 /init 的房间，返回结构为：
 * {"/": @[init WhiteScene]}
 */
- (void)getEntireScenes:(void (^) (NSDictionary<NSString *, NSArray<WhiteScene *>*> *dict))result;

#pragma mark - 自定义事件
/** 自定义事件注册 */
- (void)addMagixEventListener:(NSString *)eventName;
/**
 * 高频自定义事件注册
 * @param eventName 自定义事件名称
 * @param millseconds 间隔回调频率，毫秒。最低 500ms，低于该值都会被强制设置为 500ms
*/
- (void)addHighFrequencyEventListener:(NSString *)eventName fireInterval:(NSUInteger)millseconds;
- (void)removeMagixEventListener:(NSString *)eventName;

#pragma mark - 视野坐标类 API

/**
 如果白板View大小改变，需要主动重新调用该方法，告知 sdk 界面发生变化
 注意：使用 autolayout 修改白板布局时，白板界面并没有立即刷新，可以使用延时操作，或在相应大小修改回调时，再调用。
 */
- (void)refreshViewSize;

/** 返回当前坐标点，在白板内部的坐标位置 */
- (void)convertToPointInWorld:(WhitePanEvent *)point result:(void (^) (WhitePanEvent *convertPoint))result;

/**
 设置视野范围

 @param cameraBound 视野范围描述类
 */
- (void)setCameraBound:(WhiteCameraBound *)cameraBound;

/**
 移动视角中心

 @param camera 视角描述类
 */
- (void)moveCamera:(WhiteCameraConfig *)camera;

/**
 移动到特定的视野范围

 @param rectange 视野描述类
 */
- (void)moveCameraToContainer:(WhiteRectangleConfig *)rectange;

/**
 将 ppt 等比例铺满屏幕（参考 UIViewContentModeScaleAspectFit ）。
 该操作为一次性操作，不会持续锁定。
 如果当前页没有 ppt，则不会进行缩放。
 
 注意：如果当前用户，已经通过 setViewMode: 设置为 follower ，或者已经是 follower（有用户主动设置为 broadcaster），此 API 可能会造成，当前用户与主播内容不完全一致。
 @param mode 动画参数，连续动画，或者瞬间切换
 @since 2.5.1
 */
- (void)scalePptToFit:(WhiteAnimationMode)mode;

#pragma mark - 截图

/**
 截取用户切换时，看到的场景内容，不是场景内全部内容。
 图片支持：只有当图片服务器支持跨域，才可以显示在截图中。（请真机中运行）

 @param scenePath 想要截取场景的场景路径，例如 /init
 @param completionHandler 回调函数，image 可能为空
 */
- (void)getScenePreviewImage:(NSString *)scenePath completion:(void (^)(UIImage * _Nullable image))completionHandler;


/**
 场景封面截图，会包含场景内全部内容
 图片支持：只有当图片服务器支持跨域，才可以显示在截图中。（请真机中运行）

 @param scenePath 想要截取场景的场景路径，例如 /init
 @param completionHandler  回调函数，image 可能为空
 */
- (void)getSceneSnapshotImage:(NSString *)scenePath completion:(void (^)(UIImage * _Nullable image))completionHandler;

@end

NS_ASSUME_NONNULL_END
