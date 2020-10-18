//
//  ToolsGraphicalSelectView.h
//  NetlessUI
//
//  Created by tinntay on 2020/10/01.
//  Copyright © 2020 yize. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToolsGraphicalSelectView : UIView

// 椭圆
@property (nonatomic, strong)UIButton *ellipseButton;
// 方形
@property (nonatomic, strong)UIButton *rectangleButton;

@property (nonatomic, copy)void (^ellipseSelectBlock)(void);
@property (nonatomic, copy)void (^rectangleSelectBlock)(void);


@end

NS_ASSUME_NONNULL_END
