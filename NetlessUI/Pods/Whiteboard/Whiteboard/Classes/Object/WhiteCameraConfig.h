//
//  WhiteCameraConfig.h
//  WhiteSDK
//
//  Created by yleaf on 2019/12/10.
//

#import "WhiteObject.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WhiteAnimationMode) {
    /** 带动画，默认 */
    WhiteAnimationModeContinuous,
    /** 瞬间切换 */
    WhiteAnimationModeImmediately,
};

#pragma mark - CameraConfig

/** 白板视角中心配置类
 除 mode 外，其他均为可选值（NSNumber）。只修改设置过的值
 */
@interface WhiteCameraConfig : WhiteObject

/** 白板视角中心 X 坐标，该坐标为中心在白板内部坐标系 X 轴中的坐标 */
@property (nonatomic, strong, nullable) NSNumber *centerX;
/** 白板视角中心 Y 坐标，该坐标为中心在白板内部坐标系 Y 轴中的坐标 */
@property (nonatomic, strong, nullable) NSNumber *centerY;

/** 缩放比例，白板视觉中心与白板的投影距离 */
@property (nonatomic, strong, nullable) NSNumber *scale;

/** 切换时，动画显示方式，默认 WhiteAnimationModeContinuous */
@property (nonatomic, assign) WhiteAnimationMode animationMode;

@end

NS_ASSUME_NONNULL_END
