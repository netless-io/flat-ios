//
//  WhiteBaseCallbacks.m
//  WhiteSDK
//
//  Created by yleaf on 2019/3/1.
//

#import "WhiteCommonCallbacks.h"
#import "WhiteConsts.h"
#import <YYModel/YYModel.h>

@implementation WhiteCommonCallbacks

- (NSString *)logger:(id)log
{
    NSLog(@"%@", log);
    return @"";
}

- (NSString *)throwError:(NSDictionary *)errInfo
{
    if ([self.delegate respondsToSelector:@selector(throwError:)]) {
        NSMutableDictionary *info = [errInfo mutableCopy];
        
        static NSString *kMessageKey = @"message";
        static NSString *kErrorKey = @"error";
        info[NSLocalizedDescriptionKey] = errInfo[kMessageKey];
        info[NSDebugDescriptionErrorKey] = errInfo[kErrorKey];
        info[kMessageKey] = nil;
        info[kErrorKey] = nil;
        
        NSError *error = [NSError errorWithDomain:WhiteConstsErrorDomain code:NSIntegerMax userInfo:info];
        [self.delegate throwError:error];
    }
    return @"";
}

- (NSString *)urlInterrupter:(NSString *)url
{
    if ([self.delegate respondsToSelector:@selector(urlInterrupter:)]) {
        return [self.delegate urlInterrupter:url];
    }
    return url;
}

- (NSString *)onPPTMediaPlay:(NSDictionary *)dict
{
    if ([self.delegate respondsToSelector:@selector(pptMediaPlay)]) {
        [self.delegate pptMediaPlay];
    }
    return @"";
}


- (NSString *)onPPTMediaPause:(NSDictionary *)dict
{
    if ([self.delegate respondsToSelector:@selector(pptMediaPause)]) {
        [self.delegate pptMediaPause];
    }
    return @"";
}

- (NSString *)setupFail:(NSDictionary *)info
{
    if ([self.delegate respondsToSelector:@selector(sdkSetupFail:)]) {
        NSString *desc = info[@"message"] ? : @"";
        NSString *description = info[@"jsStack"] ? : @"";
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey: desc, NSDebugDescriptionErrorKey: description};
        NSError *error = [NSError errorWithDomain:WhiteConstsErrorDomain code:-400 userInfo:userInfo];
        [self.delegate sdkSetupFail:error];
    }
    
    return @"";
}

- (NSString *)postMessage:(NSString *)message
{
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    if (dict && [dict[@"name"] isEqualToString:@"pptImageLoadError"]) {
        NSString *name = dict[@"name"];
        NSString *notificationName = [NSString stringWithFormat:@"DynamicPpt-%@", name];
        /**
         名字
         name: "pptImageLoadError",
         加载失败的图片网址
         src: this.props.imageURL,
         error 事件
         event: e,
         错误类型，是直接从网络加载失败，还是从网络连接加载失败
         type: this.props.preload ? "indexDB" : "url",
         */
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:dict];
    }
    if (dict && dict[@"shapeId"] && dict[@"mediaType"]) {
        NSString *name = dict[@"action"];
        NSString *notificationName = [NSString stringWithFormat:@"DynamicPpt-%@", name];
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:dict];
    }
    return @"";
}

@end
