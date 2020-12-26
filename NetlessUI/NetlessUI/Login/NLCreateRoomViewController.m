//
//  NLCreateRoomViewController.m
//  NetlessUI
//
//  Created by tinntay on 2020/9/13.
//  Copyright © 2020 yize. All rights reserved.
//

#import "NLCreateRoomViewController.h"
#import "NetlessRoomViewController.h"

@interface NLCreateRoomViewController ()<UITextViewDelegate>

@property (nonatomic, strong)UITextField *nameInput;
@property (nonatomic, strong)UIButton *enterBtn;

@end

@implementation NLCreateRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.VCTitle.text = @"创建房间";
    [self initUI];
}

- (void)initUI
{
    UILabel *nameTitle = [[UILabel alloc] init];
    nameTitle.text = @"名字";
    nameTitle.font = Font(14);
    nameTitle.textColor = Color(@"212324");
    [self.view addSubview:nameTitle];
    [nameTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.top.equalTo(self.navView.mas_bottom).offset(68);
        make.size.mas_equalTo(CGSizeMake(120, 15));
    }];
    
    UIView *nameBack = [[UIView alloc] init];
    nameBack.layer.cornerRadius = 4;
    nameBack.layer.masksToBounds = YES;
    nameBack.layer.borderWidth = 1;
    nameBack.layer.borderColor = Color(@"E7E7E7").CGColor;
    [self.view addSubview:nameBack];
    [nameBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameTitle.mas_bottom).offset(8);
        make.left.equalTo(nameTitle);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth - 60, 40));
    }];
    
    self.nameInput = [[UITextField alloc] init];
    self.nameInput.font = Font(16);
    self.nameInput.textColor = Color(@"212324");
    [self.nameInput addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    NSMutableAttributedString *namePlaceholder = [[NSMutableAttributedString alloc] initWithString:@"请输入名字" attributes:
    @{NSForegroundColorAttributeName:Color(@"BCBDBD"),
      NSFontAttributeName:Font(16)}];
    self.nameInput.attributedPlaceholder = namePlaceholder;
    [nameBack addSubview:self.nameInput];
    [self.nameInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(nameBack);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth - 90, 40));
    }];
    
    self.enterBtn = [[UIButton alloc] init];
    self.enterBtn.backgroundColor = Color(@"E3E8EC");
    self.enterBtn.titleLabel.font = Font(16);
    self.enterBtn.layer.cornerRadius = 4;
    self.enterBtn.layer.masksToBounds = YES;
    self.enterBtn.userInteractionEnabled = NO;
    [self.enterBtn setTitle:@"加入房间" forState:UIControlStateNormal];
    [self.enterBtn addTarget:self action:@selector(createRoomAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.enterBtn];
    [self.enterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameInput.mas_bottom).offset(64);
        make.left.equalTo(nameTitle);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth - 60, 40));
    }];
    
}

#pragma mark - 创建房间
- (void)createRoomAction
{
    NetlessRoomViewController *room = [[NetlessRoomViewController alloc] init];
    room.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:room animated:YES completion:nil];
}

#pragma mark - TextField Changed
- (void)textFieldDidChanged:(UITextField *)field
{
    if (!CheckNull(self.nameInput.text)) {
        self.enterBtn.userInteractionEnabled = YES;
        self.enterBtn.backgroundColor = Color(@"106BC5");

    }else{
        self.enterBtn.userInteractionEnabled = NO;
        self.enterBtn.backgroundColor = Color(@"E3E8EC");
    }
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
