//
//  PptProgress.m
//  WhiteSDK
//
//  Created by yleaf on 2019/6/25.
//

#import "WhiteConversionInfo.h"


#pragma mark - PptProgress

@interface WhiteConversionInfo ()

@property (nonatomic, assign, readwrite) ServerConversionStatus convertStatus;
@property (nonatomic, copy, readwrite) NSString *reason;
@property (nonatomic, assign, readwrite) NSInteger totalPageSize;
@property (nonatomic, assign, readwrite) NSInteger convertedPageSize;
@property (nonatomic, assign, readwrite) CGFloat convertedPercentage;
@property (nonatomic, copy, readwrite, nullable) NSString *prefix;
@property (nonatomic, copy, readwrite, nullable) NSArray<WhitePptPage *> *convertedFileList;
@end

@implementation WhiteConversionInfo

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *statusString = dic[@"convertStatus"];
    statusString = [statusString lowercaseString];
    NSDictionary *map = @{@"waiting": @(ServerConversionStatusWaiting), @"converting": @(ServerConversionStatusConverting), @"notfound": @(ServerConversionStatusNotFound), @"finished": @(ServerConversionStatusFinished), @"fail": @(ServerConversionStatusFail)};
    _convertStatus = [map[statusString] integerValue];
    return YES;
}


+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass
{
    return @{@"convertedFileList": WhitePptPage.class};
}

@end

#pragma mark - ConvertedPpt

@implementation ConvertedFiles
@end
