//
//  WhiteMemberInformation.m
//  WhiteSDK
//
//  Created by leavesster on 2018/8/14.
//

#import "WhiteMemberInformation.h"

@interface WhiteMemberInformation ()

@property (nonatomic, copy, readwrite) NSString *nickName;
@property (nonatomic, copy, readwrite, nullable) NSString *avatar;
@property (nonatomic, copy, readwrite) NSString *userId;

/**
 sdk 端遗留的无意义字段，为保持一致用，不对外暴露
 */
@property (nonatomic, assign, readwrite) BOOL isOwner;
@end

@implementation WhiteMemberInformation

- (instancetype)initWithUserId:(NSString *)userId name:(NSString *)nickName avatar:(NSString *)avatarUrl
{
    if (self = [super init]) {
        _id = 0;
        _userId = userId;
        _nickName = nickName;
        _avatar = avatarUrl;
        _isOwner = NO;
    }
    return self;
}

@end
