//
//  NLBaseViewController.h
//  NetlessUI
//
//  Created by tinntay on 2020/9/15.
//  Copyright © 2020 yize. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NLBaseViewController : UIViewController

@property (nonatomic, strong)UIImageView *navView;
@property (nonatomic, strong)UIButton *backBtn;
@property (nonatomic, strong)UILabel *VCTitle;
@property (nonatomic, strong)UIButton *rightBtn;

- (void)backAction;

@end

NS_ASSUME_NONNULL_END
