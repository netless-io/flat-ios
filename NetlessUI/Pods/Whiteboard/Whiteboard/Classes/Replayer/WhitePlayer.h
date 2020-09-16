//
//  WhitePlayer.h
//  WhiteSDK
//
//  Created by yleaf on 2019/2/28.
//

#import <Foundation/Foundation.h>
#import "WhitePlayerConsts.h"
#import "WhitePlayerState.h"
#import "WhitePlayerTimeInfo.h"
#import "WhiteDisplayer.h"
#import "WhiteSDK+Replayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhitePlayer : WhiteDisplayer

#pragma mark - 同步 API

@property (nonatomic, copy, readonly) NSString *uuid;

/**
 大部分 Action API，都必须要等 phase 从 WhitePlayerPhaseWaitingFirstFrame变成其他状态，才可以操作。
 可以监听 phaseChange 回调
 */
@property (nonatomic, assign, readonly) WhitePlayerPhase phase;

/** 当 phase 处于 WhitePlayerPhaseWaitingFirstFrame 时，房间处于为开始状态，state 为 nil */
@property (nonatomic, strong, readonly, nullable) WhitePlayerState *state;

@property (nonatomic, strong, readonly) WhitePlayerTimeInfo *timeInfo;

#pragma mark - Action API

- (void)play;
- (void)pause;

//stop 后，player 资源会被释放。需要重新创建WhitePlayer实例，才可以重新播放
- (void)stop;

/** 播放时，播放速率，默认为 1。处于暂停状态时，speed 不会变为 0。 */
@property (nonatomic, assign) CGFloat playbackSpeed;

/**
 跳转到特定时间戳
 @param beginTime 开始时间（秒）
 */
- (void)seekToScheduleTime:(NSTimeInterval)beginTime;

/**
 设置查看模式
 必须要等待 phase 属性，从初始 WhitePlayerPhaseWaitingFirstFrame 变成其他任意状态时，该 API 才能正确设置。
 */
- (void)setObserverMode:(WhiteObserverMode)mode;

@end


/**
 异步 API
 目前 SDK 会在状态变化回调时，自动更新对应属性。如果不是调用了 Action API 后，立刻查看内容，不需要使用以下 API。
 */
@interface WhitePlayer (Asynchronous)

#pragma mark - get API

/**
 目前：初始状态为 WhitePlayerPhaseWaitingFirstFrame

 当 WhitePlayerPhaseWaitingFirstFrame 时，调用 getPlayerStateWithResult 返回值可能为空。
 */
- (void)getPhaseWithResult:(void (^)(WhitePlayerPhase phase))result;

/**
 当 phase 状态为 WhitePlayerPhaseWaitingFirstFrame
 回到内容为空
 */
- (void)getPlayerStateWithResult:(void (^)(WhitePlayerState * _Nullable state))result;

- (void)getPlayerTimeInfoWithResult:(void (^)(WhitePlayerTimeInfo *info))result;

/** 播放时的播放速率，正常使用，直接使用同步 API 即可。该 API 主要用作 debug 与测试 */
- (void)getPlaybackSpeed:(void (^) (CGFloat speed))result;

@end

NS_ASSUME_NONNULL_END
