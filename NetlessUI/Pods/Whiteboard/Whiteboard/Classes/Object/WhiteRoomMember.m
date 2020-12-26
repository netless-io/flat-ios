//
//  WhiteRoomMember.m
//  WhiteSDK
//
//  Created by leavesster on 2018/8/14.
//

#import "WhiteRoomMember.h"

@interface WhiteRoomMember ()

@property (nonatomic, copy, readwrite) NSString *currentApplianceName;
@property (nonatomic, assign, readwrite) NSInteger memberId;
@property (nonatomic, strong, readwrite) WhiteMemberState *memberState;
@property (nonatomic, strong, readwrite) WhiteMemberInformation *information;
@property (nonatomic, strong, readwrite) id payload;

@end

@implementation WhiteRoomMember

- (WhiteApplianceNameKey)currentApplianceName
{
    return self.memberState.currentApplianceName;
}

@end
