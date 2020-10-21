//
//  WhiteBoardFunctionBar.h
//  NetlessUI
//
//  Created by tinntay on 2020/9/21.
//  Copyright © 2020 yize. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleColorButton.h"

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger,FunctionType)
{
    FunctionType_lastOperation = 1,  /// 上一步操作
    FunctionType_nextOperation,      /// 下一步操作
    FunctionType_color,              /// 颜色选中
    FunctionType_reset,              /// 复位
    FunctionType_page,               /// 查看白板
    FunctionType_startPage,          /// 第一页
    FunctionType_endPage,            /// 最后一页
    FunctionType_lastPage,           /// 上一页
    FunctionType_nextPage,           /// 下一页
    FunctionType_currentPage,        /// 当前页
    FunctionType_Follow,             /// 视角跟随
    FunctionType_file,               /// 上传文件
    FunctionType_link,               /// 链接
    FunctionType_exitRoom,           /// 退出房间
};

@protocol functionBarDelegate <NSObject>

/**
 选择功能.

 @param functionType  功能类型.
 
*/
- (void)functionSelectWithToolsType:(FunctionType)functionType;

@end

@interface WhiteBoardFunctionBar : UIView

@property (nonatomic, strong)UIView *functionBar;

/** 上一步操作 */
@property (nonatomic, strong)UIButton *lastOperationButton;

/** 下一步操作 */
@property (nonatomic, strong)UIButton *nextOperationButton;

/** 颜色选择 */
@property (nonatomic, strong)CircleColorButton *colorButton;

/** 定位到当前位置 */
@property (nonatomic, strong)UIButton *resetButton;

/** 比例 */
@property (nonatomic, strong)UILabel *scaleLabel;

/** 跳转到页面浏览 */
@property (nonatomic, strong)UIButton *pageButton;

/** 第一页 */
@property (nonatomic, strong)UIButton *startPageButton;

/** 最后一夜 */
@property (nonatomic, strong)UIButton *endPageButton;

/** 上一页 */
@property (nonatomic, strong)UIButton *lastPageButton;

/** 下一页 */
@property (nonatomic, strong)UIButton *nextPageButton;

/** 当前页码显示 */
@property (nonatomic, strong)UILabel *currentPageLabel;

/** 上传音视频 */
@property (nonatomic, strong)UIButton *videoButton;

/** 上传文件 */
@property (nonatomic, strong)UIButton *fileButton;

/** 复制链接 */
@property (nonatomic, strong)UIButton *linkButton;

/** 退出 */
@property (nonatomic, strong)UIButton *exitRoomButton;

@property (nonatomic, weak) id<functionBarDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
