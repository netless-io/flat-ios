//
//  WhiteSdkConfiguration.m
//  WhiteSDK
//
//  Created by leavesster on 2018/8/15.
//

#import "WhiteSdkConfiguration.h"
#import "WhiteSdkConfiguration+Private.h"
#import "WhiteSDK.h"
#import <sys/utsname.h>

@implementation WhitePptParams

@end

WhiteSdkRenderEngineKey const WhiteSdkRenderEngineSvg = @"svg";
WhiteSdkRenderEngineKey const WhiteSdkRenderEngineCanvas = @"canvas";

@interface WhiteSdkConfiguration ()

@property (nonatomic, copy, nonnull) NSDictionary *nativeTags;
@property (nonatomic, copy, nonnull) NSString *platform;

@end

@implementation WhiteSdkConfiguration

static NSString *const kJSDeviceType = @"deviceType";

+ (instancetype)defaultConfig
{
    NSAssert(NO, @"WhiteSdkConfiguration must have appIdentifier, please use initWithApp:");
    return nil;
}

- (instancetype)init
{
    NSAssert(NO, @"WhiteSdkConfiguration must have appIdentifier, please use initWithApp:");
    return nil;
}

- (instancetype)initWithApp:(NSString *)appIdentifier
{
    self = [super init];
    _deviceType = WhiteDeviceTypeTouch;
    if (@available(iOS 10, *)) {
        _renderEngine = WhiteSdkRenderEngineCanvas;
    } else {
        _renderEngine = WhiteSdkRenderEngineSvg;
    }
    UIDevice *currentDevice = [UIDevice currentDevice];
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    _platform = @"ios";
    _nativeTags = @{@"nativeVersion": [WhiteSDK version], @"platform": [NSString stringWithFormat:@"%@ %@", deviceModel, currentDevice.systemVersion]};
    _appIdentifier = appIdentifier;
    return self;
}

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{@"nativeTags": @"__nativeTags", @"platform": @"__platform"};
}

- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    if (_deviceType == WhiteDeviceTypeDesktop) {
        dic[kJSDeviceType] = @"desktop";
    } else {
        dic[kJSDeviceType] = @"touch";
    }
    return YES;
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if ([dic[kJSDeviceType] isEqualToString:@"desktop"]) {
        _deviceType = WhiteDeviceTypeDesktop;
    } else {
        _deviceType = WhiteDeviceTypeTouch;
    }
    return YES;
}

- (void)setPreloadDynamicPPT:(BOOL)preloadDynamicPPT
{
    // 动态ppt的预加载在低版本iOS存在兼容性问题
    if (@available(iOS 13, *)) {
        _preloadDynamicPPT = preloadDynamicPPT;
    } else {
        
    }
}

@end
