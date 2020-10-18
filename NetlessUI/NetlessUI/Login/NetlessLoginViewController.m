//
//  NetlessLoginViewController.m
//  NetlessUI
//
//  Created by tinntay on 2020/9/9.
//  Copyright © 2020 yize. All rights reserved.
//

#import "NetlessLoginViewController.h"
#import "NetlessRoomViewController.h"
#import "NLJoinRoomViewController.h"
#import "NLCreateRoomViewController.h"

@interface NetlessLoginViewController ()<UITextViewDelegate>

@property (nonatomic, strong)UIImageView *loginIcon;

@property (nonatomic, strong)UILabel *loginTip;
@property (nonatomic, strong)UIImageView *nextIcon;
@property (nonatomic, strong)UIButton *joinRoom;
@property (nonatomic, strong)UIButton *createRoom;
@property (nonatomic, strong)UITextView *loginAgreement;


@end

@implementation NetlessLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
}

- (void)initUI
{
    self.loginIcon = [[UIImageView alloc] init];
    self.loginIcon.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:self.loginIcon];
    [self.loginIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(NAVIGATION_BAR_HEIGHT + 50);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(96, 20));
    }];
    
    self.loginTip = [[UILabel alloc] init];
    self.loginTip.text = @"欢迎使用";
    self.loginTip.textColor = Color(@"7A7B7C");
    self.loginTip.font = Font(14);
    self.loginTip.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.loginTip];
    [self.loginTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(-5);
        make.size.mas_equalTo(CGSizeMake(60, 20));
        make.top.equalTo(self.loginIcon.mas_bottom).offset(12);
    }];
    
    self.nextIcon = [[UIImageView alloc] init];
    self.nextIcon.image = [UIImage imageNamed:@"next"];
    [self.view addSubview:self.nextIcon];
    [self.nextIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loginTip.mas_right).offset(-5);
        make.centerY.equalTo(self.loginTip);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    self.joinRoom = [[UIButton alloc] init];
//    [self.joinRoom setImage:[UIImage imageNamed:@"join"] forState:UIControlStateNormal];
    [self.joinRoom setBackgroundImage:[UIImage imageNamed:@"join"] forState:UIControlStateNormal];
    [self.joinRoom addTarget:self action:@selector(joinAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.joinRoom];
    [self.joinRoom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(60);
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.top.equalTo(self.loginTip.mas_bottom).offset(100);
    }];
    
    self.createRoom = [[UIButton alloc] init];
//    [self.createRoom setImage:[UIImage imageNamed:@"create"] forState:UIControlStateNormal];
    [self.createRoom setBackgroundImage:[UIImage imageNamed:@"create"] forState:UIControlStateNormal];
    [self.createRoom addTarget:self action:@selector(createAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.createRoom];
    [self.createRoom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.right.offset(-60);
        make.top.equalTo(self.loginTip.mas_bottom).offset(100);
    }];
    
    UIButton *joinLabel = [[UIButton alloc] init];
    joinLabel.titleLabel.font = Font(16);
    [joinLabel setTitleColor:Color(@"212324") forState:UIControlStateNormal];
    [joinLabel setTitle:@"加入房间" forState:UIControlStateNormal];
    [joinLabel addTarget:self action:@selector(joinAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:joinLabel];
    [joinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.joinRoom);
        make.top.equalTo(self.joinRoom.mas_bottom).offset(16);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    UIButton *createLabel = [[UIButton alloc] init];
    createLabel.titleLabel.font = Font(16);
    [createLabel setTitleColor:Color(@"212324") forState:UIControlStateNormal];
    [createLabel setTitle:@"创建房间" forState:UIControlStateNormal];
    [createLabel addTarget:self action:@selector(createAction) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:createLabel];
    [createLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.createRoom);
        make.top.equalTo(self.createRoom.mas_bottom).offset(16);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = Color(@"E7E7E7");
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.joinRoom);
        make.size.mas_equalTo(CGSizeMake(0.5, 120));
    }];
    
    self.loginAgreement  = [[UITextView alloc] init];
    self.loginAgreement.textAlignment = NSTextAlignmentCenter;
    self.loginAgreement.textColor = Color(@"A0A0A0");
    self.loginAgreement.font = [UIFont systemFontOfSize:11];
    self.loginAgreement.delegate = self;
    self.loginAgreement.editable = NO;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"本开源项目遵循《 MIT 开源协议》"];
    NSRange range = NSMakeRange(0, str.length - 1);
    NSRange range1 = [@"本开源项目遵循《 MIT 开源协议》" rangeOfString:@"《 MIT 开源协议》"];
    [str addAttribute:NSLinkAttributeName value:@"click://" range:range1];
    [str addAttributes:@{NSForegroundColorAttributeName:Color(@"212324"),
                            NSFontAttributeName:Font(12)} range:range];
    self.loginAgreement.linkTextAttributes = @{NSForegroundColorAttributeName:Color(@"106BC5"),NSFontAttributeName:Font(12)};
    self.loginAgreement.attributedText = str;
    self.loginAgreement.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.loginAgreement];
    [self.loginAgreement mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(- 50);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(220, 30));
    }];
   
}

#pragma mark - button action
- (void)joinAction
{
    NLJoinRoomViewController *join = [[NLJoinRoomViewController alloc] init];
    join.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:join animated:YES completion:nil];
}

- (void)createAction
{
    NLCreateRoomViewController *create = [[NLCreateRoomViewController alloc] init];
    create.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:create animated:YES completion:nil];
}

#pragma mark - textView delegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{
     if ([[URL scheme] isEqualToString:@"click"]) {
        // 开源协议
        return NO;
    }
    return YES;
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
