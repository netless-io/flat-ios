//
//  CameraBound.m
//  WhiteSDK
//
//  Created by yleaf on 2019/9/5.
//

#import "WhiteCameraBound.h"

@interface WhiteContentModeConfig()

@property (nonatomic, assign, readwrite) WhiteContentMode contentMode;

@end

@implementation WhiteContentModeConfig


- (instancetype)initWithContentMode:(WhiteContentMode)scaleMode
{
    if (self = [super init]) {
        _scale = 1;
        _contentMode = scaleMode;
}
    return self;
}

//iOS 上用 UIKit 现有字段
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper;
{
    return @{@"contentMode": @"mode"};
}

- (void)setScale:(CGFloat)scale
{
    NSAssert(_contentMode == WhiteContentModeScale || _contentMode == WhiteContentModeAspectFitScale || _contentMode == WhiteContentModeAspectFillScale, NSLocalizedString(@"该属性仅当 scaleMode 为 WhiteContentModeScale、WhiteContentModeAspectFitScale 时有效", nil));
    _scale = scale;
}

- (void)setSpace:(CGFloat)space
{
    NSAssert(_contentMode == WhiteContentModeAspectFitSpace, NSLocalizedString(@"该属性仅当 scaleMode 为 WhiteContentModeAspectFitSpace 时有效", nil));
    _space = space;
}

@end

@implementation WhiteCameraBound

+ (instancetype)defaultMinContentModeScale:(CGFloat )miniScale maxContentModeScale:(CGFloat )maxScale
{
    WhiteContentModeConfig *minConfig = [[WhiteContentModeConfig alloc] initWithContentMode:WhiteContentModeScale];
    minConfig.scale = miniScale;
    
    WhiteContentModeConfig *maxConfig = [[WhiteContentModeConfig alloc] initWithContentMode:WhiteContentModeScale];
    maxConfig.scale = maxScale;

    
    WhiteCameraBound *bound = [[WhiteCameraBound alloc] initWithCenter:CGPointZero minContent:minConfig maxContent:maxConfig];
    return bound;
}

- (instancetype)initWithCenter:(CGPoint)visionCenter minContent:(WhiteContentModeConfig *)minConfig maxContent:(WhiteContentModeConfig *)maxConfig {
    self = [self init];
    _centerX = @(visionCenter.x);
    _centerY = @(visionCenter.y);
    _minContentMode = minConfig;
    _maxContentMode = maxConfig;
    return self;
}

- (instancetype)initWithFrame:(CGRect)visionFrame minContent:(WhiteContentModeConfig *)minConfig maxContent:(WhiteContentModeConfig *)maxConfig {
    self = [self initWithCenter:CGPointMake(CGRectGetMidX(visionFrame), CGRectGetMidY(visionFrame)) minContent:minConfig maxContent:maxConfig];
    _width = @(CGRectGetWidth(visionFrame));
    _height = @(CGRectGetHeight(visionFrame));
    return self;
}

@end
