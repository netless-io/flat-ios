//
//  WhiteRoomCallbacks+Private.h
//  WhiteSDK
//
//  Created by yleaf on 2019/1/18.
//

#import "WhiteRoomCallbacks.h"
#import "WhiteRoom.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhiteRoomCallbacks ()

#pragma mark - Class Method

+ (WhiteRoomPhase)convertRoomPhaseFromString:(NSString *)phase;

@property (nonatomic, weak) WhiteRoom *room;

@end

NS_ASSUME_NONNULL_END
