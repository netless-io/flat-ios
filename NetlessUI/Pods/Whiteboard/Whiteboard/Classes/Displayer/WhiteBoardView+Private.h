//
//  WhiteBoardView+Private.h
//  WhiteSDK
//
//  Created by leavesster on 2018/8/15.
//

#import "WhiteBoardView.h"

@class WhiteRoomCallbacks, WhitePlayerEvent, WhiteCommonCallbacks, WhiteSdkConfiguration;

@interface WhiteBoardView ()

@property (nonatomic, strong, nullable) WhiteRoomCallbacks *roomCallbacks;
@property (nonatomic, strong, nullable) WhitePlayerEvent *playerEvent;
@property (nonatomic, strong, nullable) WhiteCommonCallbacks *commonCallbacks;

- (void)setupWebSDKWithConfig:(WhiteSdkConfiguration *_Nonnull)config completion:(void (^_Nullable) (id _Nullable value))completionHandler;

@end
