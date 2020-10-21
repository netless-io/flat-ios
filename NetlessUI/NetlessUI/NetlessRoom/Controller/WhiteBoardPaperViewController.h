//
//  WhiteBoardPaperViewController.h
//  NetlessUI
//
//  Created by tinntay on 2020/09/27.
//  Copyright © 2020 yize. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Whiteboard.h>

NS_ASSUME_NONNULL_BEGIN

@interface WhiteBoardPaperViewController : UIViewController

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<WhiteScene *> *pptArray;

@property (nonatomic, copy)void (^removePPTBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
