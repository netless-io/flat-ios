//
//  WhiteBoardPaperTableViewCell.h
//  NetlessUI
//
//  Created by tinntay on 2020/09/27.
//  Copyright © 2020 yize. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WhiteBoardPaperTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView *paperImage;
@property (nonatomic, strong)UILabel *indexLabel;
@property (nonatomic, strong)UIButton *deleteButton;

@end

NS_ASSUME_NONNULL_END
