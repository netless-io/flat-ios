//
//  NetlessRoomViewController.h
//  NetlessUI
//
//  Created by tinntay on 2020/9/12.
//  Copyright © 2020 yize. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Whiteboard.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetlessRoomViewController : UIViewController

/** 房间号 */
@property (nonatomic, strong) NSString *roomId;
/** 用户名 */
@property (nonatomic, strong) NSString *userName;

@property (nonatomic, copy) NSString *roomToken;

@property (nonatomic, strong, nullable) WhiteRoom *room;


@end

NS_ASSUME_NONNULL_END
