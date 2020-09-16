//
//  WhiteBroadView.m
//  WhiteSDK
//
//  Created by leavesster on 2018/8/15.
//

#import "WhiteBoardView.h"
#import "WhiteBoardView+Private.h"
#import "WhiteWebViewInjection.h"
#import <YYModel/YYModel.h>
#import "WhiteObject.h"
#import "WhiteCommonCallbacks.h"

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)\
    if (dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL) == dispatch_queue_get_label(dispatch_get_main_queue())) {\
        block();\
    } else {\
        dispatch_async(dispatch_get_main_queue(), block);\
    }
#endif

@implementation WhiteBoardView

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (void)dealloc
{
    [WhiteWebViewInjection allowDisplayingKeyboardWithoutUserAction:FALSE];
}

- (instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration
{
    configuration.allowsInlineMediaPlayback = YES;
    
    if (@available(iOS 10.0.0, *)) {
        configuration.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeNone;
#if defined(__LP64__) && __LP64__
        //https://mabin004.github.io/2018/06/25/iOS%E5%BA%94%E7%94%A8%E6%B2%99%E7%AE%B1/
        [configuration setValue:@"TRUE" forKey:@"allowUniversalAccessFromFileURLs"];
#else
        //32位 CPU 支持：https://www.jianshu.com/p/fe876b9d1f7c
        [configuration setValue:@(1) forKey:@"allowUniversalAccessFromFileURLs"];
#endif
    }
    
    self = [super initWithFrame:frame configuration:configuration];
    
    if (@available(iOS 11.0.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    _commonCallbacks = [[WhiteCommonCallbacks alloc] init];
    [self addJavascriptObject:_commonCallbacks namespace:@"sdk"];
    
    [WhiteWebViewInjection allowDisplayingKeyboardWithoutUserAction:TRUE];
    self.scrollView.scrollEnabled = NO;
    
    NSURL *html = [NSURL fileURLWithPath:[[self whiteSDKBundle] pathForResource:@"index" ofType:@"html"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:html];
    [self loadRequest:request];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHandler:) name:UIKeyboardWillChangeFrameNotification object:nil];
    return self;
}

#pragma mark - Keyboard Notification
- (void)keyboardHandler:(NSNotification *)notification
{
    if (self.disableKeyboardHandler) {
        return;
    }
    
    CGPoint offset = self.scrollView.contentOffset;
    if (offset.y != 0) {
        NSDictionary *userInfo = notification.userInfo;
        NSTimeInterval interval = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        //适配第三方输入法主动修改自身大小的行为
        if (CGRectGetMaxY(beginFrame) == CGRectGetMinY(endFrame)) {
            [UIView animateWithDuration:interval animations:^{
                self.scrollView.contentOffset = CGPointMake(offset.x, 0);
            }];
        }
    }
}

#pragma mark - Private.h Methods
- (void)setupWebSDKWithConfig:(WhiteSdkConfiguration *)config completion:(void (^) (id _Nullable value))completionHandler
{
    [self callHandler:@"sdk.newWhiteSdk" arguments:@[config] completionHandler:nil];
}

#pragma mark - Override
-(void)callHandler:(NSString *)methodName arguments:(NSArray *)args completionHandler:(void (^)(id  _Nullable value))completionHandler
{
    if (!args) {
        dispatch_main_async_safe(^ {
            [super callHandler:methodName arguments:args completionHandler:completionHandler];
        });
        return;
    }
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:[args count]];
    for (NSObject *item in args) {
        if ([item isKindOfClass:[NSString class]]) {
            [arr addObject:item];
        } else if ([item isKindOfClass:[NSNumber class]]) {
            [arr addObject:item];
        } else if ([item isKindOfClass:[WhiteObject class]]) {
            [arr addObject:[(WhiteObject *)item jsonDict]];
        } else {
            [arr addObject:([item yy_modelToJSONObject] ? : @"")];
        }
    }
    dispatch_main_async_safe(^ {
        [super callHandler:methodName arguments:arr completionHandler:completionHandler];
    });
}

#pragma mark - Private Methods
- (NSBundle *)whiteSDKBundle
{
    // 脱离 Cocoapods 时，打包成同名 bundle 就可以保证读取一致性
    return [NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"Whiteboard" ofType:@"bundle"]];
}

@end
