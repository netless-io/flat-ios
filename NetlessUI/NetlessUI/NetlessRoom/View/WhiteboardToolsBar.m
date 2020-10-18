//
//  WhiteboardToolsBar.m
//  NetlessUI
//
//  Created by tinntay on 2020/9/17.
//  Copyright © 2020 yize. All rights reserved.
//

#import "WhiteboardToolsBar.h"

static float  const barWidth = 496;
static float  const barHeight = 56;
static float  const buttonHeight = 40;

@interface WhiteboardToolsBar ()


@end

@implementation WhiteboardToolsBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self addSubview:self.toolsBar];
    [self.toolsBar addSubview:self.selectButton];
    [self.toolsBar addSubview:self.pencilButton];
    [self.toolsBar addSubview:self.editButton];
    [self.toolsBar addSubview:self.eraserButton];
    [self.toolsBar addSubview:self.figureButton];
    [self.toolsBar addSubview:self.straightLineButton];
    [self.toolsBar addSubview:self.arrowButton];
    [self.toolsBar addSubview:self.resetButton];
    [self.toolsBar addSubview:self.uploadButton];
    [self.toolsBar addSubview:self.hiddenBarButton];
    [self.toolsBar addSubview:self.showBarButton];
    
    self.toolsBar.backgroundColor = [UIColor whiteColor];
    [self.toolsBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.offset(0);
        make.size.mas_equalTo(CGSizeMake(barWidth, barHeight));
    }];
    // 工具栏圆角
    [self.toolsBar layoutIfNeeded];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.toolsBar.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10,10)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskPath.CGPath;
    self.toolsBar.layer.mask = maskLayer;

    self.selectButton.layer.masksToBounds = YES;
    self.selectButton.layer.cornerRadius = 8;
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(8);
        make.centerY.equalTo(self.toolsBar);
        make.size.mas_equalTo(CGSizeMake(buttonHeight, buttonHeight));
    }];
    
    self.pencilButton.layer.masksToBounds = YES;
    self.pencilButton.layer.cornerRadius = 8;
    [self.pencilButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectButton.mas_right).offset(8);
        make.centerY.equalTo(self.toolsBar);
        make.size.mas_equalTo(CGSizeMake(buttonHeight, buttonHeight));
    }];
    
    self.editButton.layer.masksToBounds = YES;
    self.editButton.layer.cornerRadius = 8;
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pencilButton.mas_right).offset(8);
        make.centerY.equalTo(self.toolsBar);
        make.size.mas_equalTo(CGSizeMake(buttonHeight, buttonHeight));
    }];
    
    self.eraserButton.layer.masksToBounds = YES;
    self.eraserButton.layer.cornerRadius = 8;
    [self.eraserButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.editButton.mas_right).offset(8);
        make.centerY.equalTo(self.toolsBar);
        make.size.mas_equalTo(CGSizeMake(buttonHeight, buttonHeight));
    }];
    
    self.figureButton.layer.masksToBounds = YES;
    self.figureButton.layer.cornerRadius = 8;
    [self.figureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.eraserButton.mas_right).offset(8);
        make.centerY.equalTo(self.toolsBar);
        make.size.mas_equalTo(CGSizeMake(buttonHeight, buttonHeight));
    }];
    
    self.straightLineButton.layer.masksToBounds = YES;
    self.straightLineButton.layer.cornerRadius = 8;
    [self.straightLineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.figureButton.mas_right).offset(8);
        make.centerY.equalTo(self.toolsBar);
        make.size.mas_equalTo(CGSizeMake(buttonHeight, buttonHeight));
    }];
    
    self.arrowButton.layer.masksToBounds = YES;
    self.arrowButton.layer.cornerRadius = 8;
    [self.arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.straightLineButton.mas_right).offset(8);
        make.centerY.equalTo(self.toolsBar);
        make.size.mas_equalTo(CGSizeMake(buttonHeight, buttonHeight));
    }];
    
    self.resetButton.layer.masksToBounds = YES;
    self.resetButton.layer.cornerRadius = 8;
    [self.resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.arrowButton.mas_right).offset(8);
        make.centerY.equalTo(self.toolsBar);
        make.size.mas_equalTo(CGSizeMake(buttonHeight, buttonHeight));
    }];
    
    self.uploadButton.layer.masksToBounds = YES;
    self.uploadButton.layer.cornerRadius = 8;
    [self.uploadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.resetButton.mas_right).offset(8);
        make.centerY.equalTo(self.toolsBar);
        make.size.mas_equalTo(CGSizeMake(buttonHeight, buttonHeight));
    }];
    
    [self.hiddenBarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.uploadButton.mas_right).offset(8);
        make.centerY.equalTo(self.toolsBar);
        make.size.mas_equalTo(CGSizeMake(buttonHeight, buttonHeight));
    }];
    
    [self.showBarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
}

#pragma mark - 自定义事件
/** 选择 */
- (void)selectAction
{
    if (self.sender != self.selectButton) {
        self.sender.backgroundColor = [UIColor whiteColor];
        self.selectButton.backgroundColor = [UIColor colorWithRed:(float)(241.0f/255.0f) green:(float)(245.0f / 255.0f) blue:(float)(251.0f / 255.0f) alpha:1.0f];
        self.sender = self.selectButton;
    }
    if (self.toolsDelegate) {
        [self.toolsDelegate toolsSelectWithToolsType:ToolsType_select];
    }
}

/** 画笔 */
- (void)pencilAction
{
    if (self.sender != self.pencilButton) {
        self.sender.backgroundColor = [UIColor whiteColor];
        self.pencilButton.backgroundColor = [UIColor colorWithRed:(float)(241.0f/255.0f) green:(float)(245.0f / 255.0f) blue:(float)(251.0f / 255.0f) alpha:1.0f];
        self.sender = self.pencilButton;
    }
    if (self.toolsDelegate) {
        [self.toolsDelegate toolsSelectWithToolsType:ToolsType_pencil];
    }
}

/** 输入框 */
- (void)editAction
{
    if (self.sender != self.editButton) {
        self.sender.backgroundColor = [UIColor whiteColor];
        self.editButton.backgroundColor = [UIColor colorWithRed:(float)(241.0f/255.0f) green:(float)(245.0f / 255.0f) blue:(float)(251.0f / 255.0f) alpha:1.0f];
        self.sender = self.editButton;
    }
    if (self.toolsDelegate) {
        [self.toolsDelegate toolsSelectWithToolsType:ToolsType_edit];
    }
}

/** 橡皮擦 */
- (void)eraserAction
{
    if (self.sender != self.eraserButton) {
        self.sender.backgroundColor = [UIColor whiteColor];
        self.eraserButton.backgroundColor = [UIColor colorWithRed:(float)(241.0f/255.0f) green:(float)(245.0f / 255.0f) blue:(float)(251.0f / 255.0f) alpha:1.0f];
        self.sender = self.eraserButton;
    }
    if (self.toolsDelegate) {
        [self.toolsDelegate toolsSelectWithToolsType:ToolsType_eraser];
    }
}

/** 圆/方行图 */
- (void)figureAction
{
    if (self.sender != self.figureButton) {
        self.sender.backgroundColor = [UIColor whiteColor];
        self.figureButton.backgroundColor = [UIColor colorWithRed:(float)(241.0f/255.0f) green:(float)(245.0f / 255.0f) blue:(float)(251.0f / 255.0f) alpha:1.0f];
        self.sender = self.figureButton;
    }
    if (self.toolsDelegate) {
        [self.toolsDelegate toolsSelectWithToolsType:ToolsType_figure];
    }
}

/** 直线 */
- (void)straightLineAction
{
    if (self.sender != self.straightLineButton) {
        self.sender.backgroundColor = [UIColor whiteColor];
        self.straightLineButton.backgroundColor = [UIColor colorWithRed:(float)(241.0f/255.0f) green:(float)(245.0f / 255.0f) blue:(float)(251.0f / 255.0f) alpha:1.0f];
        self.sender = self.straightLineButton;
    }
    if (self.toolsDelegate) {
        [self.toolsDelegate toolsSelectWithToolsType:ToolsType_straightLine];
    }
}

/** 箭头 */
- (void)arrowAction
{
    if (self.sender != self.arrowButton) {
        self.sender.backgroundColor = [UIColor whiteColor];
        self.arrowButton.backgroundColor = [UIColor colorWithRed:(float)(241.0f/255.0f) green:(float)(245.0f / 255.0f) blue:(float)(251.0f / 255.0f) alpha:1.0f];
        self.sender = self.arrowButton;
    }
    if (self.toolsDelegate) {
        [self.toolsDelegate toolsSelectWithToolsType:ToolsType_arrow];
    }
}

/** 复位 */
- (void)resetAction
{
    if (self.sender != self.resetButton) {
        self.sender.backgroundColor = [UIColor whiteColor];
        self.resetButton.backgroundColor = [UIColor colorWithRed:(float)(241.0f/255.0f) green:(float)(245.0f / 255.0f) blue:(float)(251.0f / 255.0f) alpha:1.0f];
        self.sender = self.resetButton;
    }
    if (self.toolsDelegate) {
        [self.toolsDelegate toolsSelectWithToolsType:ToolsType_reset];
    }
}

/** 上传 */
- (void)uploadAction
{
    if (self.sender != self.uploadButton) {
        self.sender.backgroundColor = [UIColor whiteColor];
        self.uploadButton.backgroundColor = [UIColor colorWithRed:(float)(241.0f/255.0f) green:(float)(245.0f / 255.0f) blue:(float)(251.0f / 255.0f) alpha:1.0f];
        self.sender = self.uploadButton;
    }
    if (self.toolsDelegate) {
        [self.toolsDelegate toolsSelectWithToolsType:ToolsType_upload];
    }
}

/** 隐藏toolsBar */
- (void)hiddenBarAction
{
    
}

/** 显示toolsBar */
- (void)showBarAction
{
    
}


#pragma mark - 懒加载
- (UIView *)toolsBar
{
    if (!_toolsBar) {
        _toolsBar = [[UIView alloc] init];
    }
    return _toolsBar;
}

/** 选择 */
- (UIButton *)selectButton
{
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
        [_selectButton setBackgroundImage:[UIImage imageNamed:@"cursor"] forState:UIControlStateNormal];

    }
    return _selectButton;
}

/** 画笔 */
- (UIButton *)pencilButton
{
    if (!_pencilButton) {
        _pencilButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pencilButton addTarget:self action:@selector(pencilAction) forControlEvents:UIControlEventTouchUpInside];
        [_pencilButton setBackgroundImage:[UIImage imageNamed:@"pen"] forState:UIControlStateNormal];

    }
    return _pencilButton;
}

/** 输入框 */
- (UIButton *)editButton
{
    if (!_editButton) {
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editButton addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
        [_editButton setBackgroundImage:[UIImage imageNamed:@"text"] forState:UIControlStateNormal];

    }
    return _editButton;
}

/** 橡皮擦 */
- (UIButton *)eraserButton
{
    if (!_eraserButton) {
        _eraserButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_eraserButton addTarget:self action:@selector(eraserAction) forControlEvents:UIControlEventTouchUpInside];
        [_eraserButton setBackgroundImage:[UIImage imageNamed:@"eraser"] forState:UIControlStateNormal];

    }
    return _eraserButton;
}

/** 圆/方形框 */
- (UIButton *)figureButton
{
    if (!_figureButton) {
        _figureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_figureButton addTarget:self action:@selector(figureAction) forControlEvents:UIControlEventTouchUpInside];
        [_figureButton setBackgroundImage:[UIImage imageNamed:@"shape(1)"] forState:UIControlStateNormal];

    }
    return _figureButton;
}

/** 直线 */
- (UIButton *)straightLineButton
{
    if (!_straightLineButton) {
        _straightLineButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_straightLineButton addTarget:self action:@selector(straightLineAction) forControlEvents:UIControlEventTouchUpInside];
        [_straightLineButton setBackgroundImage:[UIImage imageNamed:@"line"] forState:UIControlStateNormal];

    }
    return _straightLineButton;
}

/** 箭头 */
- (UIButton *)arrowButton
{
    if (!_arrowButton) {
        _arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_arrowButton addTarget:self action:@selector(arrowAction) forControlEvents:UIControlEventTouchUpInside];
        [_arrowButton setBackgroundImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];

    }
    return _arrowButton;
}

/** 复位 */
- (UIButton *)resetButton
{
    if (!_resetButton) {
        _resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resetButton addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
        [_resetButton setBackgroundImage:[UIImage imageNamed:@"laser"] forState:UIControlStateNormal];

    }
    return _resetButton;
}

/** 上传 */
- (UIButton *)uploadButton
{
    if (!_uploadButton) {
        _uploadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_uploadButton addTarget:self action:@selector(uploadAction) forControlEvents:UIControlEventTouchUpInside];
        [_uploadButton setBackgroundImage:[UIImage imageNamed:@"upload"] forState:UIControlStateNormal];

    }
    return _uploadButton;
}

/** 隐藏当前工具栏 */
- (UIButton *)hiddenBarButton
{
    if (!_hiddenBarButton) {
        _hiddenBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_hiddenBarButton addTarget:self action:@selector(hiddenBarAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hiddenBarButton;
}

/** 显示当前工具栏 */
- (UIButton *)showBarButton
{
    if (!_showBarButton) {
        _showBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_showBarButton addTarget:self action:@selector(showBarAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showBarButton;
}

@end
