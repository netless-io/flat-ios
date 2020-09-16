//
//  WhiteSDK+Replayer.m
//  WhiteSDK
//
//  Created by yleaf on 2019/12/10.
//

#import "WhiteSDK+Replayer.h"
#import "WhiteSDK+Private.h"
#import "WhiteBoardView+Private.h"
#import "WhitePlayer+Private.h"
#import "WhiteDisplayer+Private.h"
#import "WhiteConsts.h"
#import "WhitePlayerEvent+Private.h"
#import "WhitePlayer.h"

@implementation WhiteSDK (Replayer)

#pragma mark - Replayer

- (void)createReplayerWithConfig:(WhitePlayerConfig *)config callbacks:(nullable id<WhitePlayerEventDelegate>)eventCallbacks completionHandler:(nonnull void (^)(BOOL, WhitePlayer * _Nullable, NSError * _Nullable))completionHandler
{
    NSAssert([config.room length] > 0, NSLocalizedString(@"需要一个房间 UUID", nil));
    
    //从 WhiteBoardView 父类中解耦
    if (!self.bridge.playerEvent) {
        WhitePlayerEvent *playerEvent = [[WhitePlayerEvent alloc] init];
        self.bridge.playerEvent = playerEvent;
        [self.bridge addJavascriptObject:playerEvent namespace:@"player"];
    }
    
    if (eventCallbacks) {
        self.bridge.playerEvent.delegate = eventCallbacks;
    }

    __weak typeof(self.bridge)weakBridge = self.bridge;
    [self.bridge callHandler:@"sdk.replayRoom" arguments:@[config] completionHandler:^(id  _Nullable value) {
        if (completionHandler) {
            NSData *data = [value dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSDictionary *error = dict[@"__error"];
            if (error) {
                NSString *desc = error[@"message"] ? : @"";
                NSString *description = error[@"jsStack"] ? : @"";
                NSDictionary *userInfo = @{NSLocalizedDescriptionKey: desc, NSDebugDescriptionErrorKey: description};
                completionHandler(NO, nil, [NSError errorWithDomain:WhiteConstsErrorDomain code:-101 userInfo:userInfo]);
            } else {
                WhitePlayer *player = [[WhitePlayer alloc] initWithUuid:config.room bridge:weakBridge];
                weakBridge.playerEvent.player = player;
                [player updateTimeInfo:[WhitePlayerTimeInfo modelWithJSON:dict[@"timeInfo"]]];
                [player seekToScheduleTime:0];
                completionHandler(YES, player, nil);
            }
        }
    }];
}


@end
