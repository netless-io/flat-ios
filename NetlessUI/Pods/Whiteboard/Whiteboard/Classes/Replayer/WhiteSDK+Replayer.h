//
//  WhiteSDK+Replayer.h
//  WhiteSDK
//
//  Created by yleaf on 2019/12/10.
//

#import "WhiteSDK.h"
#import "WhitePlayerEvent.h"
#import "WhitePlayerConfig.h"

NS_ASSUME_NONNULL_BEGIN

@class WhitePlayer;

@interface WhiteSDK (Replayer)
#pragma mark - Player
- (void)createReplayerWithConfig:(WhitePlayerConfig *)config callbacks:(nullable id<WhitePlayerEventDelegate>)eventCallbacks completionHandler:(void (^) (BOOL success, WhitePlayer * _Nullable player, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
