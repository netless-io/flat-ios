//
//  WhiteNativeApi.m
//  Pods
//
//  Created by leavesster on 2018/8/12.
//

#import "WhiteRoomCallbacks.h"
#import "WhiteRoomState.h"
#import "WhiteEvent.h"
#import "WhiteRoomCallbacks+Private.h"
#import "WhiteRoom+Private.h"
@implementation WhiteRoomCallbacks

+ (WhiteRoomPhase)convertRoomPhaseFromString:(NSString *)phase
{
    if ([phase isEqualToString:@"connecting"]) {
        return WhiteRoomPhaseConnecting;
    } else if ([phase isEqualToString:@"connected"]) {
        return WhiteRoomPhaseConnected;
    } else if ([phase isEqualToString:@"reconnecting"]) {
        return WhiteRoomPhaseReconnecting;
    } else if ([phase isEqualToString:@"disconnecting"]) {
        return WhiteRoomPhaseDisconnecting;
    } else if ([phase isEqualToString:@"disconnected"]) {
        return WhiteRoomPhaseDisconnected;
    }
    return WhiteRoomPhaseDisconnected;
}

- (NSString *)firePhaseChanged:(NSString *)phase
{
    WhiteRoomPhase roomPhase = [[self class] convertRoomPhaseFromString:phase];
    [self.room updatePhase:roomPhase];
    if ([self.delegate respondsToSelector:@selector(firePhaseChanged:)]) {
        [self.delegate firePhaseChanged:roomPhase];
    }
    return @"";
}

- (NSString *)fireRoomStateChanged:(id)magixPhase;
{
    WhiteRoomState *state = [WhiteRoomState modelWithJSON:magixPhase];
    [self.room updateRoomState:state];
    if ([self.delegate respondsToSelector:@selector(fireRoomStateChanged:)]) {
        [self.delegate fireRoomStateChanged:state];
    }
    return @"";
}

- (NSString *)fireDisconnectWithError:(NSString *)error
{
    if ([self.delegate respondsToSelector:@selector(fireDisconnectWithError:)]) {
        [self.delegate fireDisconnectWithError:error];
    }
    return @"";
}

- (NSString *)fireKickedWithReason:(NSString *)reason
{
    if ([self.delegate respondsToSelector:@selector(fireKickedWithReason:)]) {
        [self.delegate fireKickedWithReason:reason];
    }
    return @"";
}

- (NSString *)fireCatchErrorWhenAppendFrame:(NSDictionary *)object
{
    if ([self.delegate respondsToSelector:@selector(fireCatchErrorWhenAppendFrame:error:)]) {
        [self.delegate fireCatchErrorWhenAppendFrame:[object[@"userId"] integerValue] error:object[@"error"]];
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
    if ([self.delegate respondsToSelector:@selector(fireHighFrequencyEvent:)]) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:[info dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
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
