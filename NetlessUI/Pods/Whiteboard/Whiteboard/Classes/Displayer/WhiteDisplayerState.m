//
//  WhiteDisplayerState.m
//  WhiteSDK
//
//  Created by yleaf on 2019/7/22.
//

#import "WhiteDisplayerState.h"

@interface WhiteDisplayerState ()

@property (nonatomic, strong, readwrite) WhiteGlobalState *globalState;
@property (nonatomic, strong, readwrite) WhiteSceneState *sceneState;
@property (nonatomic, strong, readwrite) NSArray<WhiteRoomMember *> *roomMembers;

@end

@implementation WhiteDisplayerState

static Class CustomGlobalClass;
+ (BOOL)setCustomGlobalStateClass:(Class)clazz
{
    if ([clazz isSubclassOfClass:[WhiteGlobalState class]]) {
        CustomGlobalClass = clazz;
        return YES;
    } else {
        CustomGlobalClass = nil;
        return NO;
    }
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"roomMembers": [WhiteRoomMember class]};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic;
{
    if (CustomGlobalClass) {
        _globalState = [CustomGlobalClass modelWithJSON:dic[@"globalState"]];
    }
    return YES;
}

@end
