//
//  WhiteCombinePlayer.h
//  WhiteSDK
//
//  Created by yleaf on 2019/7/11.
//

#import <Foundation/Foundation.h>
#import "WhitePlayer.h"
#import <AVFoundation/AVFoundation.h>
#import "WhiteVideoView.h"
#import "WhiteSliderView.h"

NS_ASSUME_NONNULL_BEGIN


/// TODO: native player 隔离，支持第三方 player
@protocol WhiteNativePlayerProtocol <NSObject>

- (void)play;
- (void)pause;
- (BOOL)desireToPlay;
- (BOOL)hasEnoughBuffer;
- (CMTime)itemDuration;

@end

@protocol WhiteCombineDelegate <NSObject>

@optional

/**
 进入缓冲状态，WhitePlayer，NativePlayer 任一进入缓冲，都会回调。
 目前存在重复回调的情况
 */
- (void)combinePlayerStartBuffering;

/**
 结束缓冲状态，WhitePlayer，NativePlayer 全部完成缓冲，才会回调。
 */
- (void)combinePlayerEndBuffering;

/**
 nativePlayer，进入缓冲
 */
- (void)nativePlayerStartBuffering;

/**
 nativePlayer，结束缓冲
 */
- (void)nativePlayerEndBuffering;
/**
 NativePlayer 播放结束
 */
- (void)nativePlayerDidFinish;

/**
 NativePlayer 播放状态变化，由播放变停止，或者由暂停变播放

 @param isPlaying 是否正在播放
 */
- (void)combineVideoPlayStateChange:(BOOL)isPlaying;


/**
 videoPlayer 无法进行播放，需要重新创建 CombinePlayer 进行播放

 @param error 错误原因
 */
- (void)combineVideoPlayerError:(NSError *)error;

/**
 NativePlayer 缓冲进度更新

 @param loadedTimeRanges 数组内元素为 CMTimeRange，使用 CMTimeRangeValue 获取 CMTimeRange，是 video 已经加载了的缓存
 */
- (void)loadedTimeRangeChange:(NSArray<NSValue *> *)loadedTimeRanges;
@end

#pragma mark - WhiteSyncManagerPauseReason

typedef NS_OPTIONS(NSUInteger, WhiteSyncManagerPauseReason) {
    //正常播放
    WhiteSyncManagerPauseReasonNone                           = 0,
    //暂停，暂停原因：白板缓冲
    WhiteSyncManagerPauseReasonWaitingWhitePlayerBuffering    = 1 << 0,
    //暂停，暂停原因：音视频缓冲
    WhiteSyncManagerPauseReasonWaitingNativePlayerBuffering   = 1 << 1,
    //暂停，暂停原因：主动暂停
    SyncManagerWaitingPauseReasonPlayerPause                  = 1 << 2,
    //初始状态，暂停，全缓冲
    WhiteSyncManagerPauseReasonInit                           = WhiteSyncManagerPauseReasonWaitingWhitePlayerBuffering | WhiteSyncManagerPauseReasonWaitingNativePlayerBuffering | SyncManagerWaitingPauseReasonPlayerPause,
};


#pragma mark - WhiteCombinePlayer

/**
 同步系统 AVPlayer 与 WhitePlayer 的播放状态。某一个进入缓冲状态，另一个则暂停等待。
 */
@interface WhiteCombinePlayer : NSObject

@property (nonatomic, strong, readonly) AVPlayer *nativePlayer;

/** 设置 WhitePlayer，会同时更新 WhitePlayerPhase
 如果不设置，PauseReason 不会移除 WhiteSyncManagerPauseReasonWaitingWhitePlayerBuffering 的 flag
 */
@property (nonatomic, strong, nullable, readwrite) WhitePlayer *whitePlayer;

@property (nonatomic, weak, nullable) id<WhiteCombineDelegate> delegate;

/** 播放时，播放速率。即使暂停，该值也不会变为 0 */
@property (nonatomic, assign) CGFloat playbackSpeed;

/** 暂停原因，默认所有 buffer + 主动暂停 */
@property (nonatomic, assign, readonly) NSUInteger pauseReason;


- (instancetype)initWithNativePlayer:(AVPlayer *)nativePlayer whitePlayer:(WhitePlayer *)replayer;
- (instancetype)initWithMediaUrl:(NSURL *)mediaUrl whitePlayer:(WhitePlayer *)replayer;

- (instancetype)initWithMediaUrl:(NSURL *)mediaUrl;
- (instancetype)initWithNativePlayer:(AVPlayer *)nativePlayer NS_DESIGNATED_INITIALIZER;

- (NSTimeInterval)videoDuration;

- (void)play;
- (void)pause;
- (void)seekToTime:(CMTime)time completionHandler:(void (^)(BOOL finished))completionHandler;

/**
 当 whiteplayer 播放状态发生变化时，会主动调用 whiteplayer 的 WhitePlayerEventDelegate 中 - (void)phaseChanged:(WhitePlayerPhase)phase 方法.
 开发者在该回调中，需要主动调用该方法，将状态同步给 WhiteCombinePlayer
 */
- (void)updateWhitePlayerPhase:(WhitePlayerPhase)phase;

//TODO:是否支持，只有 WhitePlayer 的情况

@end

NS_ASSUME_NONNULL_END
