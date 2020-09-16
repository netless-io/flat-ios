//
//  WhitePlayerState.m
//  WhiteSDK
//
//  Created by yleaf on 2019/2/28.
//

#import "WhitePlayerState.h"

@interface WhitePlayerState ()

@property (nonatomic, assign, readwrite) WhiteObserverMode observerMode;

@end

@implementation WhitePlayerState

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"roomMembers" : [WhiteRoomMember class]};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if ([super respondsToSelector:_cmd]) {
        [super modelCustomTransformFromDictionary:dic];
    }
    
    NSString *string = NSStringFromSelector(@selector(observerMode));
    string = [string lowercaseString];
    if ([string isEqualToString:@"directory"]) {
        _observerMode = WhiteObserverModeDirectory;
    } else {
        _observerMode = WhiteObserverModeFreedom;
    }
    return YES;
}

@end
