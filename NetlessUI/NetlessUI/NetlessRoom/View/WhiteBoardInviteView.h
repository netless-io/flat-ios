//
//  WhiteBoardInviteView.h
//  NetlessUI
//
//  Created by tinntay on 2020/09/29.
//  Copyright © 2020 yize. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WhiteBoardInviteView : UIView

@property (nonatomic, strong)UILabel *title;

@property (nonatomic, strong)UILabel *roomTitle;
@property (nonatomic, strong)UILabel *roomLabel;
@property (nonatomic, strong)UIButton *roomCopyButton;

@property (nonatomic, strong)UILabel *linkTitle;
@property (nonatomic, strong)UILabel *linkLabel;
@property (nonatomic, strong)UIButton *linkCopyButton;

@property (nonatomic, strong)UIButton *allCopyButton;

@property (nonatomic, strong)NSString *roomId;
@property (nonatomic, strong)NSString *linkStr;

@property (nonatomic, strong)NSString *allCopyStr;


@end

NS_ASSUME_NONNULL_END
