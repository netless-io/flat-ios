//
//  CircleColorButton.m
//  NetlessUI
//
//  Created by tinntay on 2020/09/30.
//  Copyright © 2020 yize. All rights reserved.
//

#import "CircleColorButton.h"

@implementation CircleColorButton

- (void)drawRect:(CGRect)rect
{
    // 获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect bigRect = CGRectMake(8,
                                8,
                                16,
                                16);
    //设置空心圆的线条宽度
    CGContextSetLineWidth(ctx, 6);
    //以矩形bigRect为依据画一个圆
    CGContextAddEllipseInRect(ctx, bigRect);
    //填充当前绘画区域的颜色
    [self.cyclesColor set];
    //(如果是画圆会沿着矩形外围描画出指定宽度的（圆线）空心圆)/（根据上下文的内容渲染图层）
    CGContextStrokePath(ctx);
}

@end
