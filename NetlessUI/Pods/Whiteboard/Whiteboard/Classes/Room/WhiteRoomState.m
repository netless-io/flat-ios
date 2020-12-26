//
//  RoomState.m
//  WhiteSDK
//
//  Created by leavesster on 2018/8/14.
//

#import "WhiteRoomState.h"

@interface WhiteRoomState ()

@property (nonatomic, strong, nullable, readwrite) WhiteMemberState *memberState;
@property (nonatomic, strong, nullable, readwrite) WhiteBroadcastState *broadcastState;
@property (nonatomic, strong, nullable, readwrite) NSNumber *zoomScale;

@end

@implementation WhiteRoomState

//目前仅作为占位用，防止以后有自定义转换时，忘掉继承父类的调用
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if ([super respondsToSelector:_cmd]) {
        return [super modelCustomTransformFromDictionary:dic];
    }
    return YES;
}

@end
