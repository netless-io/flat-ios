//
//  WhiteRoomConfig.m
//  WhiteSDK
//
//  Created by yleaf on 2019/3/30.
//

#import "WhiteRoomConfig.h"
#import "WhiteConsts.h"

@implementation WhiteRoomConfig

/** never use this */
- (instancetype)init
{
    NSAssert(false, @"please never use this method.");
    return [self initWithUuid:nil roomToken:nil userPayload:nil];
}

- (instancetype)initWithUuid:(NSString *)uuid roomToken:(NSString *)roomToken
{
    return [self initWithUuid:uuid roomToken:roomToken userPayload:nil];
}

- (instancetype)initWithUuid:(NSString *)uuid roomToken:(NSString *)roomToken memberInfo:(WhiteMemberInformation *)memberInfo
{
    self = [self initWithUuid:uuid roomToken:roomToken userPayload:memberInfo];
    if (self) {
        _memberInfo = memberInfo;
    }
    return self;
}

- (instancetype)initWithUuid:(NSString *)uuid roomToken:(NSString *)roomToken userPayload:(id)userPayload
{
    if (self = [super init]) {
        _uuid = uuid;
        _roomToken = roomToken;
        _userPayload = userPayload;
        _timeout = @45;
        _isWritable = true;
        if (_userPayload) {
            NSDictionary *dict = @{@"key": _userPayload};
            if (![NSJSONSerialization isValidJSONObject:dict]) {
                
            }
        }
    }
    return self;
}

- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic
{
    dic[@"timeout"] = @([self.timeout floatValue] * WhiteConstsTimeUnitRatio);
    return true;
}

- (void)setDisableOperations:(BOOL)disableOperations
{
    _disableOperations = disableOperations;
    _disableDeviceInputs = disableOperations;
    _disableCameraTransform = disableOperations;
}

@end
