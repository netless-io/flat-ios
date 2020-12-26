//
//  WhiteEvent.m
//  WhiteSDK
//
//  Created by yleaf on 2018/10/9.
//

#import "WhiteEvent.h"

@interface WhiteEvent ()

@property (nonatomic, strong, readwrite) NSString *uuid;
@property (nonatomic, strong, readwrite) NSString *scope;
@property (nonatomic, strong, readwrite) NSString *authorId;

@end

@implementation WhiteEvent

- (instancetype)initWithName:(NSString *)eventName payload:(id)payload
{
    self = [super init];
    if (self) {
        _eventName = eventName;
        _payload = payload;
    }
    return self;
}

@end
