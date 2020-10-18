//
//  WhiteBoardColorSelectView.h
//  NetlessUI
//
//  Created by tinntay on 2020/9/30.
//  Copyright © 2020 yize. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WhiteBoardColorSelectView : UIView

/** 颜色数组 */
@property (nonatomic, strong)NSArray *colorsArray;

@property (nonatomic, copy)void (^colorSelectBlock)(NSArray *RGBColor);

@end

NS_ASSUME_NONNULL_END
