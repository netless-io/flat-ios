//
//  WhiteBoardFunctionBar.m
//  NetlessUI
//
//  Created by tinntay on 2020/9/19.
//  Copyright © 2020 yize. All rights reserved.
//

#import "WhiteBoardFunctionBar.h"

static float  const buttonHeight = 32;

@interface WhiteBoardFunctionBar ()




@end

@implementation WhiteBoardFunctionBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI布局
- (void)setupUI
{
    
    [self addSubview:self.functionBar];
    [self.functionBar addSubview:self.lastOperationButton];
    [self.functionBar addSubview:self.nextOperationButton];
    [self.functionBar addSubview:self.colorButton];
    [self.functionBar addSubview:self.resetButton];
    [self.functionBar addSubview:self.scaleLabel];
    [self.functionBar addSubview:self.pageButton];
    [self.functionBar addSubview:self.startPageButton];
    [self.functionBar addSubview:self.endPageButton];
    [self.functionBar addSubview:self.lastPageButton];
    [self.functionBar addSubview:self.nextPageButton];
    [self.functionBar addSubview:self.currentPageLabel];
    [self.functionBar addSubview:self.videoButton];
    [self.functionBar addSubview:self.fileButton];
    [self.functionBar addSubview:self.linkButton];
    [self.functionBar addSubview:self.exitRoomButton];
    
    [self.functionBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.offset(0);
        make.size.mas_equalTo(CGSizeMake(667, 48));
    }];
    
    [self.lastOperationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(buttonHeight, buttonHeight));
    }];
    
    [self.nextOperationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lastOperationButton.mas_right).offset(8);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(buttonHeight, buttonHeight));
    }];
    
    [self.colorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nextOperationButton.mas_right).offset(25);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(buttonHeight, buttonHeight));
    }];
    
    [self.resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.colorButton.mas_right).offset(25);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(buttonHeight, buttonHeight));
    }];
    
    [self.scaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.resetButton.mas_right).offset(16);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(40, buttonHeight));
    }];
    
    [self.pageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scaleLabel.mas_right).offset(24);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(buttonHeight, buttonHeight));
    }];
    
    [self.startPageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pageButton.mas_right).offset(8);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(buttonHeight, buttonHeight));
    }];
    
    [self.lastPageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.startPageButton.mas_right).offset(0);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(buttonHeight, buttonHeight));
    }];
    
    [self.currentPageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lastPageButton.mas_right).offset(0);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(buttonHeight, buttonHeight));
    }];
    
    [self.nextPageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.currentPageLabel.mas_right).offset(0);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(buttonHeight, buttonHeight));
    }];
    
    [self.endPageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nextPageButton.mas_right).offset(0);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(buttonHeight, buttonHeight));
    }];
        
    [self.videoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.endPageButton.mas_right).offset(25);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(buttonHeight, buttonHeight));
    }];
    
    [self.fileButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.videoButton.mas_right).offset(8);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(buttonHeight, buttonHeight));
    }];
    
    [self.linkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fileButton.mas_right).offset(8);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(buttonHeight, buttonHeight));
    }];
    
    [self.exitRoomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.linkButton.mas_right).offset(8);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(buttonHeight, buttonHeight));
    }];
    
}

#pragma mark - 自定义事件
/** 上一步操作 */
- (void)lastOperationAction
{
    if (self.delegate) {
        [self.delegate functionSelectWithToolsType:FunctionType_lastOperation];
    }
}

/** 下一步操作 */
- (void)nextOperationAction
{
    if (self.delegate) {
        [self.delegate functionSelectWithToolsType:FunctionType_nextOperation];
    }
}

/** 颜色选择 */
- (void)colorAction
{
    if (self.delegate) {
        [self.delegate functionSelectWithToolsType:FunctionType_color];
    }
}

/** 定位到当前位置 */
- (void)resetAction
{
    if (self.delegate) {
        [self.delegate functionSelectWithToolsType:FunctionType_reset];
    }
}


/** 跳转到页面浏览 */
- (void)pageAction
{
    if (self.delegate) {
        [self.delegate functionSelectWithToolsType:FunctionType_page];
    }
}

/** 第一页 */
- (void)startPageAction
{
    if (self.delegate) {
        [self.delegate functionSelectWithToolsType:FunctionType_startPage];
    }
}

/** 最后一夜 */
- (void)endPageAction
{
    if (self.delegate) {
        [self.delegate functionSelectWithToolsType:FunctionType_endPage];
    }
}

/** 上一页 */
- (void)lastPageAction
{
    if (self.delegate) {
        [self.delegate functionSelectWithToolsType:FunctionType_lastPage];
    }
}

/** 下一页 */
- (void)nextPageAction
{
    if (self.delegate) {
        [self.delegate functionSelectWithToolsType:FunctionType_nextPage];
    }
}

/** 视角跟随 */
- (void)videoAction
{
    if (self.delegate) {
        [self.delegate functionSelectWithToolsType:FunctionType_Follow];
    }
}

/** 上传文件 */
- (void)fileAction
{
    if (self.delegate) {
        [self.delegate functionSelectWithToolsType:FunctionType_file];
    }
}

/** 复制链接 */
- (void)linkAction
{
    if (self.delegate) {
        [self.delegate functionSelectWithToolsType:FunctionType_link];
    }
}

/** 退出 */
- (void)exitRoomAction
{
    if (self.delegate) {
        [self.delegate functionSelectWithToolsType:FunctionType_exitRoom];
    }
}

#pragma mark - 懒加载
- (UIView *)functionBar
{
    if (!_functionBar) {
        _functionBar = [[UIView alloc] init];
    }
    return _functionBar;
}

/** 上一步操作 */
- (UIButton *)lastOperationButton
{
    if (!_lastOperationButton) {
        _lastOperationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lastOperationButton setBackgroundImage:[UIImage imageNamed:@"undo"] forState:UIControlStateNormal];
        [_lastOperationButton addTarget:self action:@selector(lastOperationAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lastOperationButton;
}

/** 下一步操作 */
- (UIButton *)nextOperationButton
{
    if (!_nextOperationButton) {
        _nextOperationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextOperationButton setBackgroundImage:[UIImage imageNamed:@"redo"] forState:UIControlStateNormal];
        [_nextOperationButton addTarget:self action:@selector(nextOperationAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextOperationButton;
}

/** 颜色选择 */
- (CircleColorButton *)colorButton
{
    if (!_colorButton) {
        _colorButton = [[CircleColorButton alloc] init];
        [_colorButton addTarget:self action:@selector(colorAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _colorButton;
}

/** 定位到当前位置 */
- (UIButton *)resetButton
{
    if (!_resetButton) {
        _resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resetButton setBackgroundImage:[UIImage imageNamed:@"reset"] forState:UIControlStateNormal];
        [_resetButton addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetButton;
}

/** 比例 */
- (UILabel *)scaleLabel
{
    if (!_scaleLabel) {
        _scaleLabel = [[UILabel alloc] init];
        _scaleLabel.font = [UIFont systemFontOfSize:12];
        _scaleLabel.textColor = [UIColor colorWithRed:33/255.0 green:35/255.0 blue:36/255.0 alpha:1];
        _scaleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _scaleLabel;
}

/** 跳转到页面浏览 */
- (UIButton *)pageButton
{
    if (!_pageButton) {
        _pageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pageButton setBackgroundImage:[UIImage imageNamed:@"pages备份"] forState:UIControlStateNormal];
        [_pageButton addTarget:self action:@selector(pageAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pageButton;
}

/** 第一页 */
- (UIButton *)startPageButton
{
    if (!_startPageButton) {
        _startPageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startPageButton setBackgroundImage:[UIImage imageNamed:@"first"] forState:UIControlStateNormal];
        [_startPageButton addTarget:self action:@selector(startPageAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _startPageButton;
}

/** 最后一夜 */
- (UIButton *)endPageButton
{
    if (!_endPageButton) {
        _endPageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_endPageButton setBackgroundImage:[UIImage imageNamed:@"last(1)"] forState:UIControlStateNormal];
        [_endPageButton addTarget:self action:@selector(endPageAction) forControlEvents:UIControlEventTouchUpInside];


    }
    return _endPageButton;
}

/** 上一页 */
- (UIButton *)lastPageButton
{
    if (!_lastPageButton) {
        _lastPageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lastPageButton setBackgroundImage:[UIImage imageNamed:@"last"] forState:UIControlStateNormal];
        [_lastPageButton addTarget:self action:@selector(lastPageAction) forControlEvents:UIControlEventTouchUpInside];


    }
    return _lastPageButton;
}

/** 下一页 */
- (UIButton *)nextPageButton
{
    if (!_nextPageButton) {
        _nextPageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextPageButton setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
        [_nextPageButton addTarget:self action:@selector(nextPageAction) forControlEvents:UIControlEventTouchUpInside];


    }
    return _nextPageButton;
}

/** 当前页码显示 */
- (UILabel *)currentPageLabel
{
    if (!_currentPageLabel) {
        _currentPageLabel = [[UILabel alloc] init];
    }
    return _currentPageLabel;
}

/** 视角跟随 */
- (UIButton *)videoButton
{
    if (!_videoButton) {
        _videoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_videoButton setBackgroundImage:[UIImage imageNamed:@"follow"] forState:UIControlStateNormal];
        [_videoButton addTarget:self action:@selector(videoAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _videoButton;
}

/** 上传文件 */
- (UIButton *)fileButton
{
    if (!_fileButton) {
        _fileButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fileButton setBackgroundImage:[UIImage imageNamed:@"folder"] forState:UIControlStateNormal];
        [_fileButton addTarget:self action:@selector(fileAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _fileButton;
}

/** 复制链接 */
- (UIButton *)linkButton
{
    if (!_linkButton) {
        _linkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_linkButton setBackgroundImage:[UIImage imageNamed:@"invite"] forState:UIControlStateNormal];
        [_linkButton addTarget:self action:@selector(linkAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _linkButton;
}

/** 退出 */
- (UIButton *)exitRoomButton
{
    if (!_exitRoomButton) {
        _exitRoomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_exitRoomButton setBackgroundImage:[UIImage imageNamed:@"exit"] forState:UIControlStateNormal];
        [_exitRoomButton addTarget:self action:@selector(exitRoomAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitRoomButton;
}


@end
