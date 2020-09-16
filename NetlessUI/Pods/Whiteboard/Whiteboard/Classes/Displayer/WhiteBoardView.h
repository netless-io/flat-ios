//
//  WhiteBroadView.h
//  WhiteSDK
//
//  Created by leavesster on 2018/8/15.
//

#import <dsbridge/dsbridge.h>

NS_ASSUME_NONNULL_BEGIN

@class WhiteRoom, WhitePlayer;

@interface WhiteBoardView : DWKWebView

@property (nonatomic, strong, nullable) WhiteRoom *room;
@property (nonatomic, strong, nullable) WhitePlayer *player;

/**
 禁用 SDK 本身对键盘偏移的处理
 */
@property (nonatomic, assign) BOOL disableKeyboardHandler;

- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
