//
//  WhiteUtils.m
//  NetlessUI
//
//  Created by tinntay on 2020/9/21.
//  Copyright © 2020 yize. All rights reserved.
//

#import "WhiteUtils.h"

static NSString *APIHost = @"https://shunt-api.netless.link/v5/rooms";

@implementation WhiteUtils

+ (void)createRoomWithResult:(void (^) (BOOL success, id response, NSError *error))result
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:APIHost]];
    NSMutableURLRequest *modifyRequest = [request mutableCopy];
    [modifyRequest setHTTPMethod:@"POST"];
    [modifyRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [modifyRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [modifyRequest addValue:@"NETLESSSDK_YWs9VmpVaEZLNlBmMEQtUkF0MiZub25jZT0xNjAwNjc5OTQ5MTY1MDAmcm9sZT0wJnNpZz00ZGJlNTU1MmFlNWY4NjA5ZGQ2OGU4M2NiZDNjYmQyZjBhZjlmYzg5OWQ2NDFjNTIyMzZmMWFlMGQ5M2VhYTg3" forHTTPHeaderField:@"token"];

    //@"mode": @"historied" 为可回放房间，默认为持久化房间。
    NSDictionary *params = @{@"name": @"test", @"limit": @0};
    NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
    [modifyRequest setHTTPBody:postData];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:modifyRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error && result) {
                result(NO, nil, error);
            } else if (result) {
                NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                result(YES, responseObject, nil);
            }
        });
    }];
    [task resume];
}

+ (void)getRoomTokenWithUuid:(NSString *)uuid completionHandler:(void (^)(NSString * _Nullable roomToken, NSError * _Nullable error))completionHandler
{

    [self createRoomTokenWithUuid:uuid accessKey:nil lifespan:0 role:@"admin" Result:^(BOOL success, NSString *response, NSError *error) {
        !completionHandler ? : completionHandler(response, nil);
    }];
}

/**
 向服务器获取对应 room uuid 所需要的房间 roomToken
 
 @param uuid 房间 uuid
 @param result 服务器返回信息
 */
+ (void)createRoomTokenWithUuid:(NSString *)uuid accessKey:(NSString *)accessKey lifespan:(NSUInteger)lifespan role:(NSString *)role Result:(void (^) (BOOL success, NSString *response, NSError *error))result
{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:[@"https://shunt-api.netless.link/v5/" stringByAppendingString:@"tokens/rooms/%@"], uuid]]];
        
    NSMutableURLRequest *modifyRequest = [request mutableCopy];
    
    [modifyRequest setHTTPMethod:@"POST"];
    
    [modifyRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [modifyRequest addValue:@"NETLESSSDK_YWs9VmpVaEZLNlBmMEQtUkF0MiZub25jZT0xNjAwNjc5OTQ5MTY1MDAmcm9sZT0wJnNpZz00ZGJlNTU1MmFlNWY4NjA5ZGQ2OGU4M2NiZDNjYmQyZjBhZjlmYzg5OWQ2NDFjNTIyMzZmMWFlMGQ5M2VhYTg3" forHTTPHeaderField:@"token"];
    
    NSMutableDictionary *params = @{@"lifespan": @(lifespan), @"role": role}.mutableCopy;
    if (accessKey) {
        [params setValue:accessKey forKey:@"ak"];
    }
    NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];

    [modifyRequest setHTTPBody:postData];

    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:modifyRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!result) {
            return ;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 201) {
                id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                
                if ([responseObject isKindOfClass:[NSString class]]) {
                    result(YES, responseObject, nil);
                } else {
                    NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey:@"Error return value type", NSLocalizedDescriptionKey:responseObject};
                    NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:401 userInfo:userInfo];
                    result(NO, nil, error);
                }
            } else if (error) {
                result(NO, nil, error);
            } else if (data) {
                NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:401 userInfo:responseObject];
                result(NO, nil, error);
            }
        });
    }];
    [task resume];

}

@end
