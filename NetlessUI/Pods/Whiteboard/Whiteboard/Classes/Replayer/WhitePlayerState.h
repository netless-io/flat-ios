//
//  WhitePlayerState.h
//  WhiteSDK
//
//  Created by yleaf on 2019/2/28.
//

#import "WhiteObject.h"
#import "WhiteDisplayerState.h"
#import "WhitePlayerConsts.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhitePlayerState : WhiteDisplayerState

/** 用户观察状态 */
@property (nonatomic, assign, readonly) WhiteObserverMode observerMode;

@end

NS_ASSUME_NONNULL_END
