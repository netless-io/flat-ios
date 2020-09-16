//
//  NLJoinRoomViewController.m
//  NetlessUI
//
//  Created by tinntay on 2020/9/13.
//  Copyright © 2020 yize. All rights reserved.
//

#import "NLJoinRoomViewController.h"

@interface NLJoinRoomViewController ()

@property (nonatomic, strong)UITextField *nameInput;
@property (nonatomic, strong)UITextField *roomIdInput;

@property (nonatomic, strong)UIButton *enterBtn;

@end

@implementation NLJoinRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.VCTitle.text = @"加入房间";
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
    
    self.nameInput = [[UITextField alloc] init];
    self.nameInput.font = Font(16);
    self.nameInput.textColor = Color(@"212324");
    [self.view addSubview:self.nameInput];
    [self.nameInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameTitle.mas_bottom).offset(8);
        make.left.equalTo(nameTitle);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth - 60, 40));
        
        self.nameInput.layer.cornerRadius = 2;
        self.nameInput.layer.masksToBounds = YES;
        self.nameInput.layer.borderWidth = 1;
        self.nameInput.layer.borderColor = Color(@"E7E7E7").CGColor;
    }];
    
    UILabel *roomIdTilte = [[UILabel alloc] init];
    roomIdTilte.text = @"房间号";
    roomIdTilte.font = Font(14);
    roomIdTilte.textColor = Color(@"212324");
    [self.view addSubview:roomIdTilte];
    [roomIdTilte mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameInput.mas_bottom).offset(16);
        make.left.equalTo(nameTitle);
        make.size.mas_equalTo(CGSizeMake(120, 15));
    }];
    
    self.roomIdInput = [[UITextField alloc] init];
    self.roomIdInput.font = Font(16);
    self.roomIdInput.textColor = Color(@"212324");
    [self.view addSubview:self.roomIdInput];
    [self.roomIdInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(roomIdTilte.mas_bottom).offset(8);
        make.left.equalTo(nameTitle);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth - 60, 40));
        
        self.roomIdInput.layer.cornerRadius = 2;
        self.roomIdInput.layer.masksToBounds = YES;
        self.roomIdInput.layer.borderWidth = 1;
        self.roomIdInput.layer.borderColor = Color(@"E7E7E7").CGColor;
    }];
    
    self.enterBtn = [[UIButton alloc] init];
    self.enterBtn.backgroundColor = Color(@"E3E8EC");
    self.enterBtn.titleLabel.font = Font(16);
    [self.view addSubview:self.enterBtn];
    [self.enterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.roomIdInput.mas_bottom).offset(64);
        make.left.equalTo(nameTitle);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth - 60, 40));
        
        self.enterBtn.layer.cornerRadius = 2;
        self.enterBtn.layer.masksToBounds = YES;
    }];
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
