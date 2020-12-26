//
//  WhitePlayer.m
//  WhiteSDK
//
//  Created by yleaf on 2019/2/28.
//

#import "WhitePlayer.h"
#import "WhiteBoardView.h"
#import "WhitePlayer+Private.h"
#import "WhitePlayerTimeInfo.h"
#import "WhitePlayerState.h"
#import "WhitePlayer+Private.h"
#import "WhiteDisplayer+Private.h"
#import "WhiteConsts.h"
@interface WhitePlayer ()

@property (nonatomic, copy, readwrite) NSString *uuid;
@property (nonatomic, readwrite) WhitePlayerPhase phase;
@property (nonatomic, strong, readwrite) WhitePlayerState *state;
@property (nonatomic, strong, readwrite) WhitePlayerTimeInfo *timeInfo;

@end

@implementation WhitePlayer

- (instancetype)initWithUuid:(NSString *)uuid bridge:(WhiteBoardView *)bridge
{
    self = [super initWithUuid:uuid bridge:bridge];
    if (self) {
        bridge.player = self;
        _uuid = uuid;
        _state = [[WhitePlayerState alloc] init];
        _timeInfo = [[WhitePlayerTimeInfo alloc] init];
        _playbackSpeed = 1.0;
    }
    return self;
}

- (WhitePlayerState *)state
{
    if (_phase == WhitePlayerPhaseWaitingFirstFrame) {
        return nil;
    }
    return _state;
}

- (void)updatePhase:(WhitePlayerPhase)phase
{
    _phase = phase;
}

- (void)updatePlayerState:(WhitePlayerState *)state
{
    [_state yy_modelSetWithJSON:[state yy_modelToJSONObject]];
}

- (void)updateTimeInfo:(WhitePlayerTimeInfo *)info
{
    _timeInfo = info;
}

- (void)updateScheduleTime:(NSTimeInterval)time;
{
    NSString *key = @"scheduleTime";
    [_timeInfo yy_modelSetWithJSON:@{key : @(time)}];
}

#pragma mark - action API

static NSString * const PlayerNamespace = @"player.%@";

- (void)setPlaybackSpeed:(CGFloat)playbackSpeed
{
    _playbackSpeed = playbackSpeed;
    [self.bridge callHandler:[NSString stringWithFormat:PlayerNamespace, @"setPlaybackSpeed"] arguments:@[@(playbackSpeed)] completionHandler:nil];
}

- (void)play
{
    [self.bridge callHandler:[NSString stringWithFormat:PlayerNamespace, @"play"] arguments:nil];
}

- (void)pause
{
    [self.bridge callHandler:[NSString stringWithFormat:PlayerNamespace, @"pause"] arguments:nil];
}

- (void)stop
{
    [self.bridge callHandler:[NSString stringWithFormat:PlayerNamespace, @"stop"] arguments:nil];
}

- (void)seekToScheduleTime:(NSTimeInterval)beginTime
{
    [self.bridge callHandler:[NSString stringWithFormat:PlayerNamespace, @"seekToScheduleTime"] arguments:@[@(beginTime * WhiteConstsTimeUnitRatio)]];
}

- (void)setObserverMode:(WhiteObserverMode)mode
{
    NSString *modeString = @"";
    if (mode == WhiteObserverModeDirectory) {
        modeString = @"directory";
    } else {
        modeString = @"freedom";
    }
    [self.bridge callHandler:[NSString stringWithFormat:PlayerNamespace, @"setObserverMode"] arguments:@[modeString]];
}

#pragma mark - Class Method String to enum

static NSString * const kPlayerPhaseWaitingFirstFrame = @"waitingFirstFrame";
static NSString * const kPlayerPhasePlaying = @"playing";
static NSString * const kPlayerPhasePause = @"pause";
static NSString * const kPlayerPhaseStopped = @"stop";
static NSString * const kPlayerPhaseEnded = @"ended";
static NSString * const kPlayerPhaseBuffering = @"buffering";

+ (WhitePlayerPhase)phaseFromString:(NSString *)str
{
    str = [str lowercaseString];
    if ([str isEqualToString:kPlayerPhaseWaitingFirstFrame]) {
        return WhitePlayerPhaseWaitingFirstFrame;
    } else if ([str isEqualToString:kPlayerPhasePlaying]) {
        return WhitePlayerPhasePlaying;
    } else if ([str isEqualToString:kPlayerPhasePause]) {
        return WhitePlayerPhasePause;
    } else if ([str isEqualToString:kPlayerPhaseStopped]) {
        return WhitePlayerPhaseStopped;
    } else if ([str isEqualToString:kPlayerPhaseEnded]) {
        return WhitePlayerPhaseEnded;
    } else if ([str isEqualToString:kPlayerPhaseBuffering]) {
        return WhitePlayerPhaseBuffering;
    } else {
        return WhitePlayerPhaseStopped;
    }
}

#pragma mark - get API

static NSString * const PlayerStateNamespace = @"player.state.%@";

- (void)getPhaseWithResult:(void (^)(WhitePlayerPhase phase))result
{
    [self.bridge callHandler:[NSString stringWithFormat:PlayerStateNamespace, @"phase"] arguments:nil completionHandler:^(id  _Nullable value) {
        if (result) {
            result([[self class] phaseFromString:value]);
        }
    }];
}

- (void)getPlayerStateWithResult:(void (^) (WhitePlayerState *state))result
{
    [self.bridge callHandler:[NSString stringWithFormat:PlayerStateNamespace, @"playerState"] arguments:nil completionHandler:^(id  _Nullable value) {
        WhitePlayerState *state;
        if ([NSJSONSerialization isValidJSONObject:value]) {
            state = [WhitePlayerState modelWithJSON:value];
        }
        if (result) {
            result(state);
        }
    }];
}

- (void)getPlayerTimeInfoWithResult:(void (^) (WhitePlayerTimeInfo *info))result
{
    [self.bridge callHandler:[NSString stringWithFormat:PlayerStateNamespace, @"timeInfo"] arguments:nil completionHandler:^(id  _Nullable value) {
        WhitePlayerTimeInfo *timeInfo;
        if ([NSJSONSerialization isValidJSONObject:value]) {
            timeInfo = [WhitePlayerTimeInfo modelWithJSON:value];
        }
        if (result) {
            result(timeInfo);
        }
    }];
}

/** 播放时的播放速率，正常使用，直接使用同步 API 即可。该 API 主要用作 debug 与测试 */
- (void)getPlaybackSpeed:(void (^) (CGFloat speed))result {
    [self.bridge callHandler:[NSString stringWithFormat:PlayerStateNamespace, @"playbackSpeed"] completionHandler:^(id  _Nullable value) {
        if (result) {
            CGFloat speed = [value doubleValue];
            result(speed);
        }
    }];
}

@end
