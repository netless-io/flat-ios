//
//  WhiteCameraConfig.m
//  WhiteSDK
//
//  Created by yleaf on 2019/12/10.
//

#import "WhiteCameraConfig.h"

@implementation WhiteCameraConfig

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

