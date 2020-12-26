//
//  WhiteVideoView.m
//  WhiteCombinePlayer
//
//  Created by yleaf on 2019/7/15.
//

#import "WhiteVideoView.h"
#import <AVFoundation/AVFoundation.h>

@implementation WhiteVideoView

+ (Class)layerClass
{
    return [AVPlayerLayer class];
}

- (void)setAVPlayer:(AVPlayer *)player;
{
    AVPlayerLayer *avplayerLayer = (AVPlayerLayer *)self.layer;
    dispatch_async(dispatch_get_main_queue(), ^{
        [avplayerLayer setPlayer:player];
        [avplayerLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
    });
}

@end
