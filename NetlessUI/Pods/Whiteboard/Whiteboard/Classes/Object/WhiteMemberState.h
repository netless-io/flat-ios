//
//  MemberState.h
//  WhiteSDK
//
//  Created by leavesster on 2018/8/14.
//

#import "WhiteObject.h"

typedef NSString * WhiteApplianceNameKey NS_STRING_ENUM;

extern WhiteApplianceNameKey const AppliancePencil;
extern WhiteApplianceNameKey const ApplianceSelector;
extern WhiteApplianceNameKey const ApplianceText;
extern WhiteApplianceNameKey const ApplianceEllipse;
extern WhiteApplianceNameKey const ApplianceRectangle;
extern WhiteApplianceNameKey const ApplianceEraser;
/** 直线工具 */
extern WhiteApplianceNameKey const ApplianceStraight;
/** 箭头工具 */
extern WhiteApplianceNameKey const ApplianceArrow;
/** 抓手工具 */
extern WhiteApplianceNameKey const ApplianceHand;
/** 激光笔工具 */
extern WhiteApplianceNameKey const ApplianceLaserPointer;

@interface WhiteReadonlyMemberState : WhiteObject

/** 教具，初始教具为pencil，无默认值 */
@property (nonatomic, copy, readonly) WhiteApplianceNameKey currentApplianceName;
/** 传入格式为[@(0-255),@(0-255),@(0-255)]的RGB */
@property (nonatomic, copy, readonly) NSArray<NSNumber *> *strokeColor;
/** 画笔粗细 */
@property (nonatomic, strong, readonly) NSNumber *strokeWidth;
/** 字体大小 */
@property (nonatomic, strong, readonly) NSNumber *textSize;
@end


@interface WhiteMemberState : WhiteReadonlyMemberState
/** 教具，初始教具为pencil，无默认值 */
@property (nonatomic, copy, readwrite) WhiteApplianceNameKey currentApplianceName;
/** 传入格式为[@(0-255),@(0-255),@(0-255)]的RGB，均为整型。 */
@property (nonatomic, copy, readwrite) NSArray<NSNumber *> *strokeColor;
/** 画笔粗细 */
@property (nonatomic, strong, readwrite) NSNumber *strokeWidth;
/** 字体大小 */
@property (nonatomic, strong, readwrite) NSNumber *textSize;
@end
