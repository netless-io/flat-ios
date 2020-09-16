//
//  WhiteImageInformation.m
//  WhiteSDK
//
//  Created by leavesster on 2018/8/15.
//

#import "WhiteImageInformation.h"

@implementation WhiteImageInformation

- (instancetype)initWithUuid:(NSString *)uuid frame:(CGRect)frame
{
    self = [self init];
    _uuid = uuid;
    _centerX = CGRectGetMidX(frame);
    _centerY = CGRectGetMidY(frame);
    _width = CGRectGetWidth(frame);
    _height = CGRectGetHeight(frame);
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    NSString *uuid = [NSUUID UUID].UUIDString;
    return [self initWithUuid:uuid frame:frame];
}

- (instancetype)initWithSize:(CGSize)size
{
    NSString *uuid = [NSUUID UUID].UUIDString;
    return [self initWithUuid:uuid frame:CGRectMake(-size.width / 2, -size.height / 2, size.width, size.height)];
}

@end
