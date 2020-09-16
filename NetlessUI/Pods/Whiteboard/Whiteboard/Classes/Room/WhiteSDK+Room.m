//
//  WhiteSDK+Room.m
//  WhiteSDK
//
//  Created by yleaf on 2019/12/10.
//

#import "WhiteSDK+Room.h"
#import "WhiteSDK+Private.h"
#import "WhiteBoardView+Private.h"
#import "WhiteConsts.h"
#import "WhiteRoom+Private.h"
#import "WhiteRoomCallbacks+Private.h"
#import "WhiteRoom.h"

@implementation WhiteSDK (Room)

#pragma mark - Room API

- (void)joinRoomWithUuid:(NSString *)uuid roomToken:(NSString *)roomToken completionHandler:(nonnull void (^)(BOOL, WhiteRoom * _Nullable, NSError * _Nullable))completionHandler
{
    [self joinRoomWithRoomUuid:uuid roomToken:roomToken callbacks:nil completionHandler:completionHandler];
}

- (void)joinRoomWithRoomUuid:(NSString *)roomUuid roomToken:(NSString *)roomToken callbacks:(nullable id<WhiteRoomCallbackDelegate>)callbacks completionHandler:(nonnull void (^)(BOOL, WhiteRoom * _Nullable, NSError * _Nullable))completionHandler
{
    WhiteRoomConfig *config = [[WhiteRoomConfig alloc] initWithUuid:roomUuid roomToken:roomToken userPayload:nil];
    [self joinRoomWithConfig:config callbacks:callbacks completionHandler:completionHandler];
}

- (void)joinRoomWithConfig:(WhiteRoomConfig *)config callbacks:(nullable id<WhiteRoomCallbackDelegate>)callbacks completionHandler:(void (^) (BOOL success, WhiteRoom * _Nullable room, NSError * _Nullable error))completionHandler
{
    NSAssert([config.roomToken length] > 0 && [config.uuid length] > 0, NSLocalizedString(@"room uuid 和 token 不能为空", nil));
    
    //从 WhiteBoardView 父类中解耦
    if (!self.bridge.roomCallbacks) {
        WhiteRoomCallbacks *roomCallbacks = [[WhiteRoomCallbacks alloc] init];
        self.bridge.roomCallbacks = roomCallbacks;
        [self.bridge addJavascriptObject:roomCallbacks namespace:@"room"];
    }
    
    if (callbacks) {
        self.bridge.roomCallbacks.delegate = callbacks;
    }
    __weak typeof(self.bridge)weakBridge = self.bridge;
    WhiteRoom *room = [[WhiteRoom alloc] initWithUuid:config.uuid bridge:weakBridge];
    self.bridge.roomCallbacks.room = room;
    
    [self.bridge callHandler:@"sdk.joinRoom" arguments:@[config] completionHandler:^(id _Nullable value) {
        if (completionHandler) {
            NSData *data = [value dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSDictionary *error = dict[@"__error"];
            if (error) {
                NSString *desc = error[@"message"] ? : @"";
                NSString *description = error[@"jsStack"] ? : @"";
                NSDictionary *userInfo = @{NSLocalizedDescriptionKey: desc, NSDebugDescriptionErrorKey: description};
                completionHandler(NO, nil, [NSError errorWithDomain:WhiteConstsErrorDomain code:-100 userInfo:userInfo]);
            } else {
                room.observerId = dict[@"observerId"];
                room.writable = [dict[@"isWritable"] boolValue];
                [room updateRoomState:[WhiteRoomState modelWithJSON:dict[@"state"]]];
                weakBridge.room = room;
                weakBridge.roomCallbacks.room = room;
                completionHandler(YES, room, nil);
            }
        }
    }];
}

@end
