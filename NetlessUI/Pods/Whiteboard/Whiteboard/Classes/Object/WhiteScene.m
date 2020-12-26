//
//  WhiteScene.m
//  WhiteSDK
//
//  Created by yleaf on 2019/1/11.
//

#import "WhiteScene.h"

@interface WhiteScene ()
@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, assign, readwrite) NSInteger componentsCount;
@property (nonatomic, strong, readwrite, nullable) WhitePptPage *ppt;
@end

@implementation WhiteScene

- (instancetype)init
{
    return [super init];
}

- (instancetype)initWithName:(NSString *)name ppt:(WhitePptPage *)ppt
{
    self = [self init];
    if (self) {
        _name = name;
        _ppt = ppt;
    }
    return self;
}

- (NSString *)description
{
    NSString *desc = [super description];
    return [desc stringByAppendingFormat:@" %@", [self jsonString]];
}

@end
