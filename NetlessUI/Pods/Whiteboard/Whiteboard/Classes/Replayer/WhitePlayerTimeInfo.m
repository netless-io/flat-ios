//
//  WhitePlayerTimeInfo.m
//  WhiteSDK
//
//  Created by yleaf on 2019/2/28.
//

#import "WhitePlayerTimeInfo.h"
#import "WhiteConsts.h"
@interface WhitePlayerTimeInfo ()

@property (nonatomic, assign, readwrite) NSTimeInterval scheduleTime;
@property (nonatomic, assign, readwrite) NSTimeInterval timeDuration;
@property (nonatomic, assign, readwrite) NSInteger framesCount;
@property (nonatomic, assign, readwrite) NSTimeInterval beginTimestamp;

@end

@implementation WhitePlayerTimeInfo

- (NSDictionary *)modelCustomWillTransformFromDictionary:(NSDictionary *)dic
{
    NSMutableDictionary *modifyDict = [dic mutableCopy];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (![key isEqualToString:@"framesCount"] && [obj isKindOfClass:[NSNumber class]]) {
            modifyDict[key] = @([obj doubleValue] / WhiteConstsTimeUnitRatio);
        }
    }];
    return modifyDict;
}

@end
