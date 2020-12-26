//
//  NLBaseViewController.m
//  NetlessUI
//
//  Created by tinntay on 2020/9/15.
//  Copyright © 2020 yize. All rights reserved.
//

#import "NLBaseViewController.h"

@interface NLBaseViewController ()

@end

@implementation NLBaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    [self initNav];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
      self.hidesBottomBarWhenPushed = YES;
    }
    
    return self;
}


- (void)initNav
{
    self.navView = [[UIImageView alloc] init];
    self.navView.frame = CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT + 10);
    self.navView.image = [UIImage imageNamed:@"bg"];
    self.navView.userInteractionEnabled = YES;
    [self.view addSubview:self.navView];
    
    UIView *nav = [[UIView alloc] init];
    nav.frame = CGRectMake(0, NAVIGATION_BAR_More + 10, ScreenWidth, NAVIGATION_BAR_HEIGHT - NAVIGATION_BAR_More);
    [self.navView addSubview:nav];

    
    self.VCTitle = [[UILabel alloc] init];
    self.VCTitle.font = BFont(16);
    self.VCTitle.textColor = Color(@"010101");
    self.VCTitle.textAlignment = NSTextAlignmentCenter;
    [nav addSubview:self.VCTitle];
    [self.VCTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(nav);
        make.size.mas_equalTo(CGSizeMake(240, 30));
    }];
    
    self.backBtn = [[UIButton alloc] init];
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.equalTo(nav);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    self.rightBtn = [[UIButton alloc] init];
    [nav addSubview:self.rightBtn];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nav);
        make.right.offset(-15);
        make.size.mas_equalTo(CGSizeMake(17, 17));
    }];
    
}

- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
