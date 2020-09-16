//
//  WhitePlayerEvent.m
//  WhiteSDK
//
//  Created by yleaf on 2019/3/1.
//

#import "WhitePlayerEvent.h"
#import "WhitePlayerState.h"
#import "WhitePlayer+Private.h"
#import "WhitePlayerEvent+Private.h"
#import <YYModel/YYModel.h>
#import "WhiteConsts.h"

@implementation WhitePlayerEvent

//Player 中名称，与 JS 中保持了一致，具体对外暴露时，方法名修改为了 Objective-C 风格的命名方式。所以不能偷懒用 _cmd 。

- (NSString *)onPhaseChanged:(NSString *)json
{
    WhitePlayerPhase phase = [WhitePlayer phaseFromString:json];
    [self.player updatePhase:phase];
    if ([self.delegate respondsToSelector:@selector(phaseChanged:)]) {
        [self.delegate phaseChanged:phase];
    }
    return @"";
}

- (NSString *)onLoadFirstFrame:(id)nothing
{
    if ([self.delegate respondsToSelector:@selector(loadFirstFrame)]) {
        [self.delegate loadFirstFrame];
    }
    return @"";
}

- (NSString *)onSliceChanged:(NSString *)slice
{
    if ([self.delegate respondsToSelector:@selector(sliceChanged:)]) {
        [self.delegate sliceChanged:slice];
    }
    return @"";
}

- (NSString *)onPlayerStateChanged:(NSString *)json
{
    WhitePlayerState *state = [WhitePlayerState modelWithJSON:json];
    //连 sceneState 都没有时，说明内容没有初始化，此时的回调是返回所有信息。
    if (self.player.state.sceneState == nil) {
        [self.player updatePlayerState:state];
    } else if ([self.delegate respondsToSelector:@selector(playerStateChanged:)]) {
        [self.player updatePlayerState:state];
        [self.delegate playerStateChanged:state];
    }
    return @"";
}

- (NSString *)onStoppedWithError:(NSString *)errorJSON
{
    if ([self.delegate respondsToSelector:@selector(stoppedWithError:)]) {
        NSMutableDictionary *errorInfo = [NSJSONSerialization JSONObjectWithData:[errorJSON dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];

        NSString *message = errorInfo[@"message"];
        NSString *description = errorInfo[@"jsStack"];
        NSString *err = errorInfo[@"error"];
        [errorInfo removeObjectForKey:@"message"];
        [errorInfo removeObjectForKey:@"jsStack"];
        [errorInfo removeObjectForKey:@"error"];
        errorInfo[NSLocalizedDescriptionKey] = message;
        errorInfo[NSLocalizedFailureReasonErrorKey] = err;
        errorInfo[NSDebugDescriptionErrorKey] = description;
        NSError *error = [NSError errorWithDomain:WhiteConstsErrorDomain code:-101 userInfo:errorInfo];
        [self.delegate stoppedWithError:error];
    }
    return @"";
}

- (NSString *)onScheduleTimeChanged:(NSNumber *)time
{
    NSTimeInterval scheduleTime = (([time doubleValue]) / WhiteConstsTimeUnitRatio);
    [self.player updateScheduleTime:scheduleTime];
    if ([self.delegate respondsToSelector:@selector(scheduleTimeChanged:)]) {
        [self.delegate scheduleTimeChanged:scheduleTime];
    }
    return @"";
}

- (NSString *)onCatchErrorWhenAppendFrame:(NSString *)errInfo
{
    if ([self.delegate respondsToSelector:@selector(errorWhenAppendFrame:)]) {
        NSData *data = [errInfo dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(@"添加帧时，出现错误", nil), NSDebugDescriptionErrorKey: dict};
        NSError *error = [NSError errorWithDomain:WhiteConstsErrorDomain code:-100 userInfo:userInfo];
        [self.delegate errorWhenAppendFrame:error];
    }
    return @"";
}

- (NSString *)onCatchErrorWhenRender:(NSString *)errInfo
{
    if ([self.delegate respondsToSelector:@selector(errorWhenRender:)]) {
        NSData *data = [errInfo dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(@"渲染时，出现错误", nil), NSDebugDescriptionErrorKey: dict};
        NSError *error = [NSError errorWithDomain:WhiteConstsErrorDomain code:-100 userInfo:userInfo];
        [self.delegate errorWhenRender:error];
    }
    return @"";
}

- (NSString *)fireMagixEvent:(NSString *)info
{
    if ([self.delegate respondsToSelector:@selector(fireMagixEvent:)]) {
        WhiteEvent *event = [WhiteEvent modelWithJSON:info];
        [self.delegate fireMagixEvent:event];
    }
    return @"";
}

- (NSString *)fireHighFrequencyEvent:(NSString *)info
{
    if ([self.delegate respondsToSelector:@selector(fireMagixEvent:)]) {
        NSArray *array  = [NSJSONSerialization JSONObjectWithData:[info dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray<WhiteEvent *> *events = [NSMutableArray arrayWithCapacity:[array count]];
        for (NSString *evtString in array) {
            WhiteEvent *event = [WhiteEvent modelWithJSON:evtString];
            [events addObject:event];
        }
        [self.delegate fireHighFrequencyEvent:events];
    }
    return @"";
}

@end
