//
//  WhitePlayerConfig.m
//  WhiteSDK
//
//  Created by yleaf on 2019/3/1.
//

#import "WhitePlayerConfig.h"
#import "WhiteConsts.h"

@implementation WhitePlayerConfig

- (instancetype)initWithRoom:(NSString *)roomUuid roomToken:(NSString *)roomToken;
{
    if (self = [super init]) {
        _room = roomUuid;
        _roomToken = roomToken;
        _step = @(0.5);
    }
    return self;
}

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{@"audioUrl": @"mediaURL"};
}

- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic
{
    if (self.beginTimestamp) {
        dic[NSStringFromSelector(@selector(beginTimestamp))] = @([self.beginTimestamp integerValue] * WhiteConstsTimeUnitRatio);
    }
    if (self.duration) {
        dic[NSStringFromSelector(@selector(duration))] = @([self.duration integerValue] * WhiteConstsTimeUnitRatio);
    }
    dic[@"step"] = @([self.step floatValue] * WhiteConstsTimeUnitRatio);
    return true;
}

@end
