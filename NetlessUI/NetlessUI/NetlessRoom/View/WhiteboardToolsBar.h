//
//  WhiteboardToolsBar.h
//  NetlessUI
//
//  Created by tinntay on 2020/9/17.
//  Copyright © 2020 yize. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ToolsType)
{
    ToolsType_select = 1,    // 选择
    ToolsType_pencil,        // 画笔
    ToolsType_edit,          // 输入框
    ToolsType_eraser,        // 橡皮擦
    ToolsType_figure ,       // 方/圆形图
    ToolsType_straightLine,  // 直线
    ToolsType_arrow,         // 箭头
    ToolsType_reset,         // 复位
    ToolsType_upload,        // 上传
};

@protocol toolsBarDelegate <NSObject>

/**
 选择教具.

 @param toolsType  教具类型.
 
*/
- (void)toolsSelectWithToolsType:(ToolsType)toolsType;

@end

@interface WhiteboardToolsBar : UIView

@property (nonatomic, strong)UIView *toolsBar;

/** 选择 */
@property (nonatomic, strong)UIButton *selectButton;
/** 画笔 */
@property (nonatomic, strong)UIButton *pencilButton;
/** 输入框 */
@property (nonatomic, strong)UIButton *editButton;
/** 橡皮擦 */
@property (nonatomic, strong)UIButton *eraserButton;
/** 圆/方形框 */
@property (nonatomic, strong)UIButton *figureButton;
/** 直线 */
@property (nonatomic, strong)UIButton *straightLineButton;
/** 箭头 */
@property (nonatomic, strong)UIButton *arrowButton;
/** 复位 */
@property (nonatomic, strong)UIButton *resetButton;
/** 上传 */
@property (nonatomic, strong)UIButton *uploadButton;
/** 隐藏当前工具栏 */
@property (nonatomic, strong)UIButton *hiddenBarButton;
/** 显示当前工具栏 */
@property (nonatomic, strong)UIButton *showBarButton;
/** 当前选中的教具 */
@property (nonatomic, strong)UIButton *sender;

@property (nonatomic, weak) id<toolsBarDelegate> toolsDelegate;

@end

NS_ASSUME_NONNULL_END
