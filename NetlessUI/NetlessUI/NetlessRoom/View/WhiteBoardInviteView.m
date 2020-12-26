//
//  WhiteBoardInviteView.m
//  NetlessUI
//
//  Created by tinntay on 2020/09/29.
//  Copyright © 2020 yize. All rights reserved.
//

#import "WhiteBoardInviteView.h"

@implementation WhiteBoardInviteView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 0, 400, 218);
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.title = [[UILabel alloc] init];
    self.title.font = [UIFont systemFontOfSize:16];
    self.title.textColor = [UIColor colorWithRed:33/255.0 green:35/255.0 blue:36/255.0 alpha:1];
    self.title.textAlignment = NSTextAlignmentCenter;
    self.title.text = @"邀请成员";
    [self addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.offset(16);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [self addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-16);
        make.top.offset(16);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(54);
        make.size.mas_equalTo(CGSizeMake(400, 1));
    }];
    
    self.roomTitle = [[UILabel alloc] init];
    self.roomTitle.font = [UIFont systemFontOfSize:14];
    self.roomTitle.textColor = [UIColor colorWithRed:122/255.0 green:123/255.0 blue:124/255.0 alpha:1];
    self.roomTitle.text = @"房间号";
    [self addSubview:self.roomTitle];
    [self.roomTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(20);
        make.left.offset(16);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    UIView *roomBack = [[UIView alloc] init];
    roomBack.layer.masksToBounds = YES;
    roomBack.layer.cornerRadius = 2;
    roomBack.layer.borderColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1].CGColor;
    roomBack.layer.borderWidth = 1;
    [self addSubview:roomBack];
    [roomBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(88);
        make.centerY.equalTo(self.roomTitle);
        make.size.mas_equalTo(CGSizeMake(256, 32));
    }];
    
    self.roomLabel = [[UILabel alloc] init];
    self.roomLabel.font = [UIFont systemFontOfSize:14];
    self.roomLabel.textColor = [UIColor colorWithRed:122/255.0 green:123/255.0 blue:124/255.0 alpha:1];
    [roomBack addSubview:self.roomLabel];
    [self.roomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.centerY.equalTo(roomBack);
        make.size.mas_equalTo(CGSizeMake(216, 32));
    }];
    
    self.roomCopyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.roomCopyButton setBackgroundImage:[UIImage imageNamed:@"copy"] forState:UIControlStateNormal];
    [self.roomCopyButton addTarget:self action:@selector(copyRoomAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.roomCopyButton];
    [self.roomCopyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(roomBack.mas_right).offset(8);
        make.centerY.equalTo(roomBack);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];

    self.linkTitle = [[UILabel alloc] init];
    self.linkTitle.font = [UIFont systemFontOfSize:14];
    self.linkTitle.textColor = [UIColor colorWithRed:122/255.0 green:123/255.0 blue:124/255.0 alpha:1];
    self.linkTitle.text = @"加入链接";
    [self addSubview:self.linkTitle];
    [self.linkTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.roomTitle);
        make.top.equalTo(self.roomTitle.mas_bottom).offset(24);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    UIView *linkBack = [[UIView alloc] init];
    linkBack.layer.masksToBounds = YES;
    linkBack.layer.cornerRadius = 2;
    linkBack.layer.borderColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1].CGColor;
    linkBack.layer.borderWidth = 1;
    [self addSubview:linkBack];
    [linkBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(88);
        make.centerY.equalTo(self.linkTitle);
        make.size.mas_equalTo(CGSizeMake(256, 32));
    }];
    
    self.linkLabel = [[UILabel alloc] init];
    self.linkLabel.font = [UIFont systemFontOfSize:14];
    self.linkLabel.textColor = [UIColor colorWithRed:122/255.0 green:123/255.0 blue:124/255.0 alpha:1];
    [linkBack addSubview:self.linkLabel];
    [self.linkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.centerY.equalTo(linkBack);
        make.size.mas_equalTo(CGSizeMake(216, 32));
    }];
    
    self.linkCopyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.linkCopyButton setBackgroundImage:[UIImage imageNamed:@"copy"] forState:UIControlStateNormal];
    [self.linkCopyButton addTarget:self action:@selector(copyLinkAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.linkCopyButton];
    [self.linkCopyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(linkBack.mas_right).offset(8);
        make.centerY.equalTo(linkBack);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
    
    self.allCopyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.allCopyButton.backgroundColor = [UIColor colorWithRed:16/255.0 green:107/255.0 blue:197/255.0 alpha:1];
    self.allCopyButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.allCopyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.allCopyButton setTitle:@"复制" forState:UIControlStateNormal];
    [self.allCopyButton addTarget:self action:@selector(copyAllAction) forControlEvents:UIControlEventTouchUpInside];
    self.allCopyButton.layer.masksToBounds = YES;
    self.allCopyButton.layer.cornerRadius = 4;
    [self addSubview:self.allCopyButton];
    [self.allCopyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.offset(-16);
        make.size.mas_equalTo(CGSizeMake(368, 40));
    }];
    
}

- (void)setRoomId:(NSString *)roomId
{
    _roomId = roomId;
    self.roomLabel.text = roomId;
}

- (void)setLinkStr:(NSString *)linkStr
{
    _linkStr = linkStr;
    self.linkLabel.text = linkStr;
}


- (void)copyRoomAction
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.roomId;
}

- (void)copyLinkAction
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.linkStr;
}

- (void)copyAllAction
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.allCopyStr;
}


@end
