//
//  WhiteBoardPaperTableViewCell.m
//  NetlessUI
//
//  Created by tinntay on 2020/09/27.
//  Copyright © 2020 yize. All rights reserved.
//

#import "WhiteBoardPaperTableViewCell.h"

@implementation WhiteBoardPaperTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.paperImage = [[UIImageView alloc] init];
        self.paperImage.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
        self.paperImage.layer.masksToBounds = YES;
        self.paperImage.layer.cornerRadius = 4;
        [self.contentView addSubview:self.paperImage];
        [self.paperImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(14);
            make.centerX.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(208, 156));
        }];
        
        self.indexLabel = [[UILabel alloc] init];
        self.indexLabel.font = [UIFont systemFontOfSize:14];
        self.indexLabel.textColor = [UIColor colorWithRed:122/255.0 green:123/255.0 blue:124/255.0 alpha:1];
        [self.contentView addSubview:self.indexLabel];
        [self.indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(16);
            make.top.equalTo(self.paperImage.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(100, 22));
        }];
        
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.deleteButton setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.deleteButton];
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-16);
            make.top.equalTo(self.paperImage.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(22, 22));
        }];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
