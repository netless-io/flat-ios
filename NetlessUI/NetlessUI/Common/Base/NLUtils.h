//
//  NLUtils.h
//  NetlessUI
//
//  Created by tinntay on 2020/9/12.
//  Copyright © 2020 yize. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NLUtils : NSObject

+ (NLUtils *)shareInstance;

+ (UIColor *)UIColorFromHexColor:(NSString *)hexColor;

//根据高度算文本的宽度
- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height fontSize:(CGFloat)font;

@end

NS_ASSUME_NONNULL_END
