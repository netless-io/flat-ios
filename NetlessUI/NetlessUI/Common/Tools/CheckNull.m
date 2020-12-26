//
//  CheckNull.m
//  金程网校-HD
//
//  Created by Gaoyize on 2017/6/23.
//  Copyright © 2017年 Gaoyz. All rights reserved.
//

#import "CheckNull.h"

@implementation CheckNull

+ (bool)checkNull:(id)data
{
    if ([data isKindOfClass:[NSNull class]] || data == nil) {
//        SHOWALERT(@"暂无数据");
        return YES;
    }
    
    if ([data isKindOfClass:[NSString class]]) {
        if (data==nil||data==NULL)
        {
//            SHOWALERT(@"暂无数据");
            return YES;
        }
        
        if ([data isKindOfClass:[NSNull class]])
        {
//            SHOWALERT(@"暂无数据");
            return YES;
        }
        
        //去掉前后空格,判断length是否为空
        if ([[data stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
        {
//            SHOWALERT(@"暂无数据");
            return YES;
        }
        
        if ([data isEqualToString:@"(null)"]||[data isEqualToString:@"null"]||[data isEqualToString:@"<null>"])
        {
//            SHOWALERT(@"暂无数据");
            return YES;
        }

    }if ([data isKindOfClass:[NSArray class]]) {
        NSArray *array = [NSArray arrayWithArray:data];
        if (array.count == 0 || [array isKindOfClass:[NSNull class]]) {
//            SHOWALERT(@"暂无数据");
            return YES;
        }
    }if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:data];
        if ([dic isKindOfClass:[NSNull class]]) {
//            SHOWALERT(@"暂无数据");
            return YES;
        }
    }
    return NO;
}

@end
