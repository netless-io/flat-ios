//
//  CameraBound.h
//  WhiteSDK
//
//  Created by yleaf on 2019/9/5.
//

#import "WhiteObject.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - WhiteContentScaleMode
/** 可以参考 UIViewContentMode */
typedef NS_ENUM(NSUInteger, WhiteContentMode) {
    /** 基于白板 zoomScale 的缩放比例 */
    WhiteContentModeScale,
    /** 与 UIViewContentModeScaleAspectFit 相似，按比例缩放，将设置的宽高范围，铺满视野 */
    WhiteContentModeAspectFit,
    /** 与 UIViewContentModeScaleAspectFit 相似，按比例缩放，将设置的 宽高 * scale 的范围，铺满视野 */
    WhiteContentModeAspectFitScale,
    /** 与 UIViewContentModeScaleAspectFit 相似，按比例缩放，将设置的 宽高 + space 的范围，铺满视野 */
    WhiteContentModeAspectFitSpace,
    /** 与 UIViewContentModeScaleAspectFill 相似，按比例缩放，视野内容会在设置的宽高范围内 */
    WhiteContentModeAspectFill,
    /** 与 UIViewContentModeScaleAspectFill 相似，按比例缩放，视野内容会在设置的 宽高 + space 的范围内 */
    WhiteContentModeAspectFillScale,
};

#pragma mark - WhiteContentMode
@interface WhiteContentModeConfig : WhiteObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithContentMode:(WhiteContentMode)scaleMode;

/** 默认 WhiteContentModeScale */
@property (nonatomic, assign, readonly) WhiteContentMode contentMode;
/** 只有当 scaleMode 为 WhiteContentModeScale、WhiteContentModeAspectFitScale、WhiteContentModeAspectFillScale 设置有效 */
@property (nonatomic, assign) CGFloat scale;
/** 只有当 scaleMode 为 WhiteContentModeAspectFitSpace 时有效 */
@property (nonatomic, assign) CGFloat space;

@end

#pragma mark - WhiteCameraBound
@interface WhiteCameraBound : WhiteObject

- (instancetype)initWithCenter:(CGPoint)visionCenter minContent:(WhiteContentModeConfig *)minConfig maxContent:(WhiteContentModeConfig *)maxConfig;
- (instancetype)initWithFrame:(CGRect)visionFrame minContent:(WhiteContentModeConfig *)minConfig maxContent:(WhiteContentModeConfig *)maxConfig;

/** 效果类似 WhiteSdkConfig 中，删除的 zoomMiniScale 以及 zoomMaxScale */
+ (instancetype)defaultMinContentModeScale:(CGFloat )miniScale maxContentModeScale:(CGFloat )maxScale;

/** 基础视野中心点坐标。不传，则默认为 0 */
@property (nonatomic, nullable, strong) NSNumber *centerX;
/** 基础视野中心点坐标。不传，则默认为 0 */
@property (nonatomic, nullable, strong) NSNumber *centerY;
/** 基础视野宽度。不传，则默认为 无穷大 */
@property (nonatomic, nullable, strong) NSNumber *width;
/** 基础视野高度。不传，则默认为 无穷大 */
@property (nonatomic, nullable, strong) NSNumber *height;

/** 最大缩放比例上限，默认无穷大 */
@property (nonatomic, nullable, strong) WhiteContentModeConfig *maxContentMode;
/** 最小缩放比例下限，默认无限趋近于 0 */
@property (nonatomic, nullable, strong) WhiteContentModeConfig *minContentMode;

@end

NS_ASSUME_NONNULL_END
