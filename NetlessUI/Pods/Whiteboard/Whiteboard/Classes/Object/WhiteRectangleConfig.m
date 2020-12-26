//
//  WhiteRectangleConfig.m
//  WhiteSDK
//
//  Created by yleaf on 2019/12/10.
//

#import "WhiteRectangleConfig.h"

@implementation WhiteRectangleConfig

- (instancetype)initWithInitialPosition:(CGFloat)width height:(CGFloat)height;
{
    return [self initWithInitialPosition:width height:height animation:WhiteAnimationModeContinuous];
}

- (instancetype)initWithInitialPosition:(CGFloat)width height:(CGFloat)height animation:(WhiteAnimationMode)mode;
{
    CGFloat originX = - width / 2;
    CGFloat originY = - height / 2;
    return [self initWithOriginX:originX originY:originY width:width height:height animation:mode];
}

- (instancetype)initWithOriginX:(CGFloat)originX originY:(CGFloat)originY width:(CGFloat)width height:(CGFloat)height;
{
    return [self initWithOriginX:originX originY:originY width:width height:height animation:WhiteAnimationModeContinuous];
}

- (instancetype)initWithOriginX:(CGFloat)originX originY:(CGFloat)originY width:(CGFloat)width height:(CGFloat)height animation:(WhiteAnimationMode)mode;
{
    if (self = [super init]) {
        _originX = originX;
        _originY = originY;
        _width = width;
        _height = height;
        _animationMode = mode;
    }
    return self;
}

- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    switch (_animationMode) {
        case WhiteAnimationModeContinuous:
            dic[@"animationMode"] = @"continuous";
            break;
        case WhiteAnimationModeImmediately:
            dic[@"animationMode"] = @"immediately";
    }
    return YES;
}

@end

