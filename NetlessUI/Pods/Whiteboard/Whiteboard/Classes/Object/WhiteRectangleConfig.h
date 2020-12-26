//
//  WhiteRectangleConfig.h
//  WhiteSDK
//
//  Created by yleaf on 2019/12/10.
//

#import "WhiteObject.h"
#import <UIKit/UIKit.h>
#import "WhiteCameraConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhiteRectangleConfig : WhiteObject

/**
 移动到初始位置，并保证对应宽高部分必然显示在白板中
 
 @param width 白板最小水平视野
 @param height 白板最小垂直视野
 @return 白板视野
 */
- (instancetype)initWithInitialPosition:(CGFloat)width height:(CGFloat)height;

/**
 移动到初始位置，并保证对应宽高部分必然显示在白板中
 
 @param width 白板最小水平视野
 @param height 白板最小垂直视野
 @param mode 切换时，动画显示方式
 @return 白板视野
 */
- (instancetype)initWithInitialPosition:(CGFloat)width height:(CGFloat)height animation:(WhiteAnimationMode)mode;

/**
 自由设置白板视野

 @param originX 白板视觉矩形，左上角在白板内部坐标 X 轴的位置
 @param originY 白板视觉矩形，左上角在白板内部坐标 Y 轴的位置
 @param width 白板水平方向视野宽度，在白板内部坐标 X 轴的单位
 @param height 白板水平方向视野高度，在白板内部坐标 Y 周的单位
 @return 白板视野
 */
- (instancetype)initWithOriginX:(CGFloat)originX originY:(CGFloat)originY width:(CGFloat)width height:(CGFloat)height;

/**
 自由设置白板视野
 
 @param originX 白板视觉矩形，左上角在白板内部坐标 X 轴的位置
 @param originY 白板视觉矩形，左上角在白板内部坐标 Y 轴的位置
 @param width 白板水平方向视野宽度，在白板内部坐标 X 轴的单位
 @param height 白板水平方向视野高度，在白板内部坐标 Y 周的单位
 @param mode 切换时，动画显示方式
 @return 白板视野
 */
- (instancetype)initWithOriginX:(CGFloat)originX originY:(CGFloat)originY width:(CGFloat)width height:(CGFloat)height animation:(WhiteAnimationMode)mode;

/** 白板视觉矩形，左上角在白板内部坐标 X 轴的位置 */
@property (nonatomic, assign) CGFloat originX;

/** 白板视觉矩形，左上角在白板内部坐标 Y 轴的位置 */
@property (nonatomic, assign) CGFloat originY;

/** 白板水平方向视野宽度，在白板内部坐标 X 轴的单位 */
@property (nonatomic, assign) CGFloat width;

/** 白板水平方向视野高度，在白板内部坐标 Y 周的单位 */
@property (nonatomic, assign) CGFloat height;

/** 白板进行视觉变换时动画方式，默认 WhiteAnimationModeContinuous */
@property (nonatomic, assign) WhiteAnimationMode animationMode;

@end


NS_ASSUME_NONNULL_END
