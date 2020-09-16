//
//  MemberState.m
//  WhiteSDK
//
//  Created by leavesster on 2018/8/14.
//

#import "WhiteMemberState.h"

WhiteApplianceNameKey const AppliancePencil = @"pencil";
WhiteApplianceNameKey const ApplianceSelector = @"selector";
WhiteApplianceNameKey const ApplianceText = @"text";
WhiteApplianceNameKey const ApplianceEllipse = @"ellipse";
WhiteApplianceNameKey const ApplianceRectangle = @"rectangle";
WhiteApplianceNameKey const ApplianceEraser = @"eraser";
WhiteApplianceNameKey const ApplianceStraight = @"straight";
WhiteApplianceNameKey const ApplianceArrow = @"arrow";
WhiteApplianceNameKey const ApplianceHand = @"hand";
WhiteApplianceNameKey const ApplianceLaserPointer = @"laserPointer";


@interface WhiteReadonlyMemberState ()
@property (nonatomic, copy) WhiteApplianceNameKey currentApplianceName;
@property (nonatomic, copy) NSArray<NSNumber *> *strokeColor;
@property (nonatomic, strong) NSNumber *strokeWidth;
@property (nonatomic, strong) NSNumber *textSize;
@end

@implementation WhiteReadonlyMemberState

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"strokeColor" : [NSNumber class]};
}

- (void)setStrokeColor:(NSArray<NSNumber *> *)newColor
{
    NSMutableArray *IntArray = [NSMutableArray arrayWithCapacity:newColor.count];
    for (NSNumber *n in newColor) {
        //fix issue: iOS 10 rgb css don's support float
        [IntArray addObject:[NSNumber numberWithInteger:[n integerValue]]];
    }
    _strokeColor = [IntArray copy];
}

@end

@implementation WhiteMemberState
@dynamic currentApplianceName;
@dynamic strokeColor;
@dynamic strokeWidth;
@dynamic textSize;

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"strokeColor" : [NSNumber class]};
}

@end
