//
//  WhiteSDK+Room.h
//  WhiteSDK
//
//  Created by yleaf on 2019/12/10.
//

#import "WhiteSDK.h"
#import "WhiteRoomConfig.h"
#import "WhiteRoomCallbacks.h"

NS_ASSUME_NONNULL_BEGIN

@class WhiteRoom;

@interface WhiteSDK (Room)

- (void)joinRoomWithConfig:(WhiteRoomConfig *)config callbacks:(nullable id<WhiteRoomCallbackDelegate>)callbacks completionHandler:(void (^) (BOOL success, WhiteRoom * _Nullable room, NSError * _Nullable error))completionHandler;


- (void)joinRoomWithUuid:(NSString *)uuid roomToken:(NSString *)roomToken completionHandler:(void (^)(BOOL success, WhiteRoom * _Nullable room, NSError * _Nullable error))completionHandler;

- (void)joinRoomWithRoomUuid:(NSString *)roomUuid roomToken:(NSString *)roomToken callbacks:(nullable id<WhiteRoomCallbackDelegate>)callbacks completionHandler:(void (^) (BOOL success, WhiteRoom * _Nullable room, NSError * _Nullable error))completionHandler;


@end

NS_ASSUME_NONNULL_END
