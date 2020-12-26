//
//  WhitePlayer+Private.h
//  WhiteSDK
//
//  Created by yleaf on 2019/2/28.
//

#import "WhitePlayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhitePlayer ()

+ (WhitePlayerPhase)phaseFromString:(NSString *)str;

- (void)updatePhase:(WhitePlayerPhase)phase;
- (void)updatePlayerState:(WhitePlayerState *)state;
- (void)updateTimeInfo:(WhitePlayerTimeInfo *)info;
- (void)updateScheduleTime:(NSTimeInterval)time;

@end

NS_ASSUME_NONNULL_END
