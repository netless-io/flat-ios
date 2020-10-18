//
//  NLJoinRoomViewController.m
//  NetlessUI
//
//  Created by tinntay on 2020/9/13.
//  Copyright © 2020 yize. All rights reserved.
//

#import "NLJoinRoomViewController.h"
#import "NetlessRoomViewController.h"


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
    
    UIView *roomIdBack = [[UIView alloc] init];
    roomIdBack.layer.cornerRadius = 4;
    roomIdBack.layer.masksToBounds = YES;
    roomIdBack.layer.borderWidth = 1;
    roomIdBack.layer.borderColor = Color(@"E7E7E7").CGColor;
    [self.view addSubview:roomIdBack];
    [roomIdBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(roomIdTilte.mas_bottom).offset(8);
        make.left.equalTo(nameTitle);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth - 60, 40));
    }];
    
    self.roomIdInput = [[UITextField alloc] init];
    self.roomIdInput.font = Font(16);
    self.roomIdInput.textColor = Color(@"212324");
    NSMutableAttributedString *roomPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"请输入房间号" attributes:
    @{NSForegroundColorAttributeName:Color(@"BCBDBD"),
      NSFontAttributeName:Font(16)}];
    self.roomIdInput.attributedPlaceholder = roomPlaceholder;
    [self.roomIdInput addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [roomIdBack addSubview:self.roomIdInput];
    [self.roomIdInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(roomIdBack);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth - 90, 40));
    }];
    
    self.enterBtn = [[UIButton alloc] init];
    self.enterBtn.backgroundColor = Color(@"E3E8EC");
    self.enterBtn.titleLabel.font = Font(16);
    self.enterBtn.userInteractionEnabled = NO;
    [self.enterBtn setTitle:@"加入房间" forState:UIControlStateNormal];
    [self.enterBtn addTarget:self action:@selector(joinRoomAction) forControlEvents:UIControlEventTouchUpInside];
    self.enterBtn.layer.cornerRadius = 4;
    self.enterBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.enterBtn];
    [self.enterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.roomIdInput.mas_bottom).offset(64);
        make.left.equalTo(nameTitle);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth - 60, 40));
    }];
}

#pragma mark - 加入房间
- (void)joinRoomAction
{
    NetlessRoomViewController *room = [[NetlessRoomViewController alloc] init];
    room.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:room animated:YES completion:nil];
}

#pragma mark - TextField Changed
- (void)textFieldDidChanged:(UITextField *)field
{
    if (!CheckNull(self.nameInput.text) && !CheckNull(self.roomIdInput.text)) {
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
