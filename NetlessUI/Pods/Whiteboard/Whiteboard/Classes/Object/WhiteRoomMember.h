//
//  WhiteRoomMember.h
//  WhiteSDK
//
//  Created by leavesster on 2018/8/14.
//

#import "WhiteObject.h"
#import "WhiteMemberState.h"
#import "WhiteMemberInformation.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhiteRoomMember : WhiteObject

@property (nonatomic, copy, readonly) WhiteApplianceNameKey currentApplianceName DEPRECATED_MSG_ATTRIBUTE("使用 memberState.currentApplianceName 获取");

/** 当前用户在该房间中时的序号，为从 0 开始的自增数字 */
@property (nonatomic, assign, readonly) NSInteger memberId;

/** 对应用户的教具信息 */
@property (nonatomic, strong, readonly) WhiteReadonlyMemberState *memberState;

/**
 兼容旧版本， 从 iOS 2.1.0（Android 2.0.0，web 2.0.0）开始，使用 payload 字段
 */
@property (nonatomic, strong, readonly, nullable) WhiteMemberInformation *information;

/**
 从 iOS 2.1.0（Android 2.0.0，web 2.0.0） 开始，加入房间时，允许带入任意数据（限制：允许转换为 JSON，或者单纯的字符串，数字）
 如果想要使用 SDK 默认头像显示，请全平台使用 avatar 字段设置用户头像。
 */
@property (nonatomic, strong, readonly, nullable) id payload;

@end

NS_ASSUME_NONNULL_END
