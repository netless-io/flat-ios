//
//  ToolsGraphicalSelectView.m
//  NetlessUI
//
//  Created by tinntay on 2020/10/01.
//  Copyright © 2020 yize. All rights reserved.
//

#import "ToolsGraphicalSelectView.h"

@implementation ToolsGraphicalSelectView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.frame = CGRectMake(0, 0, 48, 96);
    self.backgroundColor = [UIColor whiteColor];
    
    self.ellipseButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.ellipseButton setBackgroundImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
    [self.ellipseButton addTarget:self action:@selector(ellipseAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.ellipseButton];
    [self.ellipseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.size.mas_equalTo(CGSizeMake(48, 48));
    }];
    
    self.rectangleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.rectangleButton setBackgroundImage:[UIImage imageNamed:@"shape"] forState:UIControlStateNormal];
    [self.rectangleButton addTarget:self action:@selector(rectangleAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.rectangleButton];
    [self.rectangleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ellipseButton.mas_bottom);
        make.left.offset(0);
        make.size.equalTo(self.ellipseButton);
    }];
}

- (void)ellipseAction
{
    if (self.ellipseSelectBlock) {
        self.ellipseSelectBlock();
    }
}

- (void)rectangleAction
{
    if (self.rectangleSelectBlock) {
        self.rectangleSelectBlock();
    }
}

@end
