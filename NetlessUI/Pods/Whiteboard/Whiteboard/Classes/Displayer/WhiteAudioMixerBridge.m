//
//  AudioMixerBridge.m
//  Whiteboard
//
//  Created by yleaf on 2020/8/13.
//

#import "WhiteAudioMixerBridge.h"

@interface WhiteAudioMixerBridge ()

@property (nonatomic, weak) WhiteBoardView *bridge;
@property (nonatomic, weak, nullable) id<WhiteAudioMixerBridgeDelegate> delegate;

@end

@implementation WhiteAudioMixerBridge

- (instancetype)initWithBridge:(WhiteBoardView *)bridge deletegate:(id<WhiteAudioMixerBridgeDelegate>)delegate;
{
    self = [super init];
    _bridge = bridge;
    _delegate = delegate;
    return self;
}

- (void)setMediaState:(NSInteger)stateCode errorCode:(NSInteger)errorCode
{
    [self.bridge callHandler:@"rtc.callback" arguments:@[@(stateCode), @(errorCode)]];
}

- (NSString *)startAudioMixing:(NSDictionary *)dict
{
    if ([self.delegate respondsToSelector:@selector(startAudioMixing:loopback:replace:cycle:)]) {
        NSString *filePath = dict[@"filePath"];
        BOOL loopback = [dict[@"loopback"] boolValue];
        BOOL replace = [dict[@"replace"] boolValue];
        NSInteger cycle = [dict[@"cycle"] integerValue];
        [self.delegate startAudioMixing:filePath loopback:loopback replace:replace cycle:cycle];
    }
    return @"";
}

- (NSString *)stopAudioMixing:(id)nothing
{
    if ([self.delegate respondsToSelector:@selector(stopAudioMixing)]) {
        [self.delegate stopAudioMixing];
    }
    return @"";
}

- (NSString *)setAudioMixingPosition:(NSNumber *)position
{
    if ([self.delegate respondsToSelector:@selector(setAudioMixingPosition:)]) {
        [self.delegate setAudioMixingPosition:[position integerValue]];
    }
    return @"";
}

@end
