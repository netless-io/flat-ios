//
//  WhiteBoardColorSelectView.m
//  NetlessUI
//
//  Created by tinntay on 2020/9/30.
//  Copyright © 2020 yize. All rights reserved.
//

#import "WhiteBoardColorSelectView.h"

@interface WhiteBoardColorSelectView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView *collectionView;

@end

@implementation WhiteBoardColorSelectView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.colorsArray =
        @[@"FC3A3F",@"FD8343",@"FFDA56",@"9FDF76",                                                                  @"60E8C6",@"106BC5",@"4486F6",@"9D27B0",
                @"DC74FC",@"939AA8",@"1D2129",@"FFFFFF"];
        [self setupUI];
    }
    return self;
}


#pragma mark - setupUI
- (void)setupUI
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(24, 24);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 14;
    layout.sectionInset = UIEdgeInsetsMake(10, 16, 0, 16);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 170 , 124) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self addSubview:self.collectionView];
}

#pragma mark - UICollectionView delegate && dateSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.colorsArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *colorName = self.colorsArray[indexPath.row];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [self UIColorFromHexColor:colorName];
    cell.layer.cornerRadius = 12;
    cell.layer.masksToBounds = YES;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *color = self.colorsArray[indexPath.row];
    if (self.colorSelectBlock) {
        self.colorSelectBlock([self UIColorStrFromHexColor:color]);
    }
}

#pragma mark - RGB颜色
- (UIColor *)UIColorFromHexColor:(NSString *)hexColor
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    if ([hexColor isEqualToString:@""]) {
        return nil;
    }
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}

- (NSArray *)UIColorStrFromHexColor:(NSString *)hexColor
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    if ([hexColor isEqualToString:@""]) {
        return nil;
    }
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    NSString *R = [NSString stringWithFormat:@"%d",red];
    NSString *G = [NSString stringWithFormat:@"%d",green];
    NSString *B = [NSString stringWithFormat:@"%d",blue];

    return @[R,G,B];
}

@end
