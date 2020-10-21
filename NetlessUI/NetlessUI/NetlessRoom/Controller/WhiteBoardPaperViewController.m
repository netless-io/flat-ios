//
//  WhiteBoardPaperViewController.m
//  NetlessUI
//
//  Created by tinntay on 2020/09/27.
//  Copyright © 2020 yize. All rights reserved.
//

#import "WhiteBoardPaperViewController.h"
#import "WhiteBoardPaperTableViewCell.h"
#import "AppDelegate.h"

@interface WhiteBoardPaperViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation WhiteBoardPaperViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(0);
        make.size.mas_equalTo(CGSizeMake(240, [UIScreen mainScreen].bounds.size.height));
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    ((AppDelegate *)[UIApplication sharedApplication].delegate).allowRotation = YES;
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}

#pragma mark - tableView delegate && dateSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pptArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    WhiteBoardPaperTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WhiteBoardPaperTableViewCell" forIndexPath:indexPath];
    cell.currentIndex = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    cell.removeBlock = ^(NSInteger index) {
        [weakSelf removePPTActionAtIndex:index];
    };
    return cell;
}

- (void)removePPTActionAtIndex:(NSInteger)index
{
    [self.pptArray removeObjectAtIndex:index];
    [self.tableView reloadData];
    if (self.removePPTBlock) {
        self.removePPTBlock(index);
    }
}

#pragma mark - 懒加载
- (NSMutableArray<WhiteScene *> *)pptArray
{
    if (!_pptArray) {
        _pptArray = [[NSMutableArray alloc] init];
    }
    return _pptArray;
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 200;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[WhiteBoardPaperTableViewCell class] forCellReuseIdentifier:@"WhiteBoardPaperTableViewCell"];
    }
    return _tableView;
}

@end
