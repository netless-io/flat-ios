//
//  NLUtils.m
//  NetlessUI
//
//  Created by tinntay on 2020/9/12.
//  Copyright © 2020 yize. All rights reserved.
//

#import "NLUtils.h"

@implementation NLUtils

+ (NLUtils *)shareInstance {
    static NLUtils *NLUtils = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NLUtils = [[self alloc] init];
    });
    return NLUtils;
}

+ (UIColor *)UIColorFromHexColor:(NSString *)hexColor
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    
    if ([hexColor isEqualToString:@""]) {
        return nil;
    }
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}

//根据高度算文本的宽度
- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height fontSize:(CGFloat)font {
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
}

@end
