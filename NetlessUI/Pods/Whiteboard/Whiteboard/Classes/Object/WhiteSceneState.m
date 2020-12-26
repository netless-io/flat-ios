//
//  WhiteSceneState.m
//  WhiteSDK
//
//  Created by yleaf on 2019/2/25.
//

#import "WhiteSceneState.h"

@interface WhiteSceneState ()
@property (nonatomic, nonnull, strong, readwrite) NSArray<WhiteScene *> *scenes;
@property (nonatomic, nonnull, strong, readwrite) NSString *scenePath;
@property (nonatomic, assign, readwrite) NSInteger index;
@end

@implementation WhiteSceneState

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"scenes" : [WhiteScene class]};
}

@end
