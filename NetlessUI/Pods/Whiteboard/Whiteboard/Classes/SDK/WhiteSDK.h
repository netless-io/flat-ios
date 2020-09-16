//
//  WhiteSDK.h
//  Pods-white-ios-sdk_Example
//
//  Created by leavesster on 2018/8/11.
//

#import <Foundation/Foundation.h>
#import "WhiteBoardView.h"
#import "WhiteCommonCallbacks.h"
#import "WhiteSdkConfiguration.h"
#import "WhiteAudioMixerBridge.h"
NS_ASSUME_NONNULL_BEGIN

/** 非单例，一个 SDK 实例绑定，为了能够进行重连房间操作，最好由当前 ViewController 持有。 */
@interface WhiteSDK : NSObject


/** White SDK 版本号 */
+ (NSString *)version;

- (instancetype)initWithWhiteBoardView:(WhiteBoardView *)boardView config:(WhiteSdkConfiguration *)config commonCallbackDelegate:(nullable id<WhiteCommonCallbackDelegate>)callback audioMixerBridgeDelegate:(nullable id<WhiteAudioMixerBridgeDelegate>)mixer;
/**
 初始化方法, CommonCallback 为 Room 与 Player 都支持的 callback
 注意: 在 iOS 12 以后，调用该方法，以及任何 sdk 代码时，都先确保 WhiteBoardView 在视图栈中，并且没有被隐藏（可以被遮盖）
 */
- (instancetype)initWithWhiteBoardView:(WhiteBoardView *)boardView config:(WhiteSdkConfiguration *)config commonCallbackDelegate:(nullable id<WhiteCommonCallbackDelegate>)callback;

- (instancetype)initWithWhiteBoardView:(WhiteBoardView *)boardView config:(WhiteSdkConfiguration *)config DEPRECATED_MSG_ATTRIBUTE("initWithWhiteBoardView:config:commonCallbackDelegate");

@property (nonatomic, strong, readonly, nullable) WhiteAudioMixerBridge *audioMixer;

#pragma mark - CommonCallback

/// 更新 CommonCallback 的 delegate
/// @param callbackDelegate 为空，会移除原有的 CallbackDelegate
- (void)setCommonCallbackDelegate:(nullable id<WhiteCommonCallbackDelegate>)callbackDelegate;


@end
NS_ASSUME_NONNULL_END
