//
//  WhitePptPage.m
//  WhiteSDK
//
//  Created by leavesster on 2018/8/15.
//

#import "WhitePptPage.h"

@interface WhitePptPage ()

@property (nonatomic, copy, readwrite) NSString *previewURL;

@end

@implementation WhitePptPage

- (instancetype)initWithSrc:(NSString *)src size:(CGSize)size
{
    self = [super init];
    _src = src;
    _width = size.width;
    _height = size.height;
    return self;
}

- (instancetype)initWithSrc:(NSString *)src preview:(NSString *)url size:(CGSize)size
{
    self = [self initWithSrc:src size:size];
    _previewURL = url;
    return self;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"src" : @[@"src", @"conversionFileUrl"]};
}

@end
