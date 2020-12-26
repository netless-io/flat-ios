//
//  BroadcastState.m
//  WhiteSDK
//
//  Created by leavesster on 2018/8/14.
//

#import "WhiteBroadcastState.h"

static NSString * const kViewModeBroadcaster = @"Broadcaster";
static NSString * const kViewModeFollower = @"Follower";
static NSString * const kViewModeFreedom = @"Freedom";

@interface WhiteBroadcasterInformation ()
@property (nonatomic, assign, readwrite) NSNumber *id;
@property (nonatomic, assign, readwrite) id payload;
@end

@implementation WhiteBroadcasterInformation

@end

@interface WhiteBroadcastState ()

@property (nonatomic, assign, readwrite) WhiteViewMode viewMode;
@property (nonatomic, assign, readwrite) NSNumber *broadcasterId;
@property (nonatomic, strong, readwrite) WhiteBroadcasterInformation *broadcasterInformation;
@end

@implementation WhiteBroadcastState

//遗留问题，web端将mode作为属性名称
static NSString * const kJavascriptModeKey = @"mode";

/** web端，viewMode 属性，是一个字符串枚举值。native 端接收到的是字符串，需要手动转换成枚举类型 */
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *string = dic[kJavascriptModeKey];
    string = [string lowercaseString];
    if ([string isEqualToString:[kViewModeFollower lowercaseString]]) {
        _viewMode = WhiteViewModeFollower;
    } else if ([string isEqualToString:[kViewModeBroadcaster lowercaseString]]) {
        _viewMode = WhiteViewModeBroadcaster;
    } else {
        _viewMode = WhiteViewModeFreedom;
    }
    return YES;
}

@end
