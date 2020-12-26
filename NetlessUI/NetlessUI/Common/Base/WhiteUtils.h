//
//  WhiteUtils.h
//  NetlessUI
//
//  Created by tinntay on 2020/9/21.
//  Copyright © 2020 yize. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WhiteUtils : NSObject

+ (void)createRoomWithResult:(void (^) (BOOL success, id response, NSError *error))result;

+ (void)getRoomTokenWithUuid:(NSString *)uuid completionHandler:(void (^)(NSString * _Nullable roomToken, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
