//
//  SearchCityTableViewController.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/20.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "SearchCityTableViewController.h"
#import "HotCityTableViewController.h"
#import "WeatherModel.h"
#import "HUDTools.h"
#import "LocalArchiverManager.h"

@interface SearchCityTableViewController ()
@property (nonatomic, assign)BOOL isSelectedItem;
@property (nonatomic, strong)NSIndexPath *editIndexPath;
@property (nonatomic, assign)BOOL isSelectedRow;
@property (nonatomic, copy)NSString *cityName;
@property (nonatomic, strong)UIBarButtonItem *rightBtnItem;
@property (nonatomic, assign)NSInteger currentIndex;
@property (nonatomic, assign)NSInteger deleIndex;
@property (nonatomic, assign)BOOL isFirst;
@property (nonatomic, assign)BOOL isLast;
@property (nonatomic, assign)BOOL isRemoveCell;
@end

@implementation SearchCityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"城市管理";
    self.isSelectedItem = false;
    self.rightBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editTableViewCell:)];
    self.navigationItem.rightBarButtonItem = self.rightBtnItem;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.isSelectedRow = NO;
    self.isRemoveCell = NO;
    /// 从本地中取出数据
    NSMutableArray<WeatherModel *> *arrModel = [[LocalArchiverManager shareManager] archiverQueryName:@"mutableModel"];
    if (arrModel.count > 1) {
        self.dataSource = arrModel;
    }
    if (self.dataSource.count == 1) {
        [self.rightBtnItem setEnabled:NO];
    }else {
        [self.rightBtnItem setEnabled:YES];
    }
}
- (void)editTableViewCell:(UIBarButtonItem *)item {
    
    self.isSelectedItem = !self.isSelectedItem;
    [self.tableView setEditing:NO animated:YES];
    if (self.isSelectedItem) {
        item.title = @"完成";
        [self.tableView setEditing:YES animated:YES];
    }else {
        item.title = @"编辑";
        [self.tableView setEditing:NO animated:YES];
    }
}
- (void)setDataSource:(NSMutableArray<WeatherModel *> *)dataSource {
    _dataSource = dataSource;
    [self.tableView reloadData];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (self.editIndexPath) {
        [self configSwipeButtons];
    }
}
- (void)configSwipeButtons {
    if (@available(iOS 11.0, *)) {
        for (UIView *subview in self.tableView.subviews) {
            if ([subview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")] && [subview.subviews count] >= 1) {
                UIButton *deleteBtn = subview.subviews[0];
                [deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
            }
        }
    }else {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.editIndexPath];
        for (UIView *subview in cell.subviews) {
            if ([subview isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")] && [subview.subviews count] >= 1) {
                UIButton *deleteBtn = subview.subviews[0];
                [deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
            }
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    __weak typeof (self) weakSelf = self;
    [self.dataSource enumerateObjectsUsingBlock:^(WeatherModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.city isEqualToString:self.currentCity]) {
            weakSelf.currentIndex = idx;
        }
    }];
    self.isFirst = (self.currentIndex == 1) ? YES : NO;
    self.isLast = (self.currentIndex == self.dataSource.count - 1) ? YES : NO;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    /// 没有点击cell直接返回
    if (!self.isSelectedRow && self.isRemoveCell) {
        _block(self.cityName);
    }
}

- (void)showCityWeather {
    /// 1.如果城市删除到了最后一个的情况 同时没有点击cell 直接返回
    if (self.dataSource.count == 1) {
        self.cityName = self.dataSource.lastObject.city;
//        NSLog(@"%@",self.cityName);
    }
    /// 2.若当前城市是最后一个并且从最一个开始删（包含当前城市） 展示数组最后一个城市 同时没有点击cell 直接返回
    else if (self.isLast && (self.dataSource.count == self.deleIndex)) {
        self.cityName = self.dataSource.lastObject.city;
//        NSLog(@"%@",self.cityName);
    }
    /// 3.若是当前城市是第一个并且从第一个开始删（包含当前城市） 展示数组中第一个城市 同时没有点击cell 直接返回
    else if (self.isFirst && (self.deleIndex == 1)) {
        self.cityName = self.dataSource[1].city;
//        NSLog(@"%@",self.cityName);
    }
    else {
        __weak typeof (self) weakSelf = self;
        __block BOOL isExit = NO;
        [self.dataSource enumerateObjectsUsingBlock:^(WeatherModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            /// 判断当前城市是否还在数组中
            if ([obj.city isEqualToString:weakSelf.currentCity]) {
                isExit = YES;
                *stop = YES;
            }
        }];
        /// 4.若是当前城市是在中间位置，没有删掉当前城市，则依然是改城市，同时没有点击cell 直接返回
        if (isExit) {
            self.cityName = self.currentCity;
//            NSLog(@"%@",self.cityName);
        }
        /// 5.若是当前城市在中间位置，同时被删除了 则是当前的下一个城市展示  同时没有点击cell 直接返回
        else {
            if (self.deleIndex < self.dataSource.count) {
                self.cityName = self.dataSource[self.deleIndex].city;
//                NSLog(@"%@",self.cityName);
            }
            else {
                self.cityName = self.dataSource.lastObject.city;
//                NSLog(@"%@",self.cityName);
            }
        }
    }
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"identifier"];
    }
    
    UIImage *image = nil;
    if (indexPath.row == self.dataSource.count) {
        image = [UIImage imageNamed:@"addCity"];
    }else {
        WeatherModel *model = self.dataSource[indexPath.row];
        image = [NSString imageWithWeatherStr:model.weather];
    }
    
    CGSize imageSize = CGSizeMake(29, 29);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, imageSize.width, imageSize.height);
    [image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if (indexPath.row == self.dataSource.count) {
        cell.textLabel.text = @"添加城市";
        cell.detailTextLabel.text = @"";
    }else {
        WeatherModel *model = self.dataSource[indexPath.row];
        cell.textLabel.text = model.city;
        cell.detailTextLabel.text = model.temperature;
    }
    
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsZero;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == self.dataSource.count) {
        if (self.dataSource.count == 6) {
            [HUDTools showText:@"最多只能添加6个城市" withView:self.view withDelay:2.0];
            return;
        }else {
            HotCityTableViewController *hotvc = [[HotCityTableViewController alloc] init];
            [self.navigationController pushViewController:hotvc animated:YES];
        }
    }else {
        NSString *name = [(WeatherModel *)self.dataSource[indexPath.row] city];
        if (_block) {
            _block(name);
        }
        self.isSelectedRow = YES;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dataSource.count == 1) {
        [self.rightBtnItem setEnabled:NO];
        [self.tableView setEditing:NO animated:YES];
        self.rightBtnItem.title = @"编辑";
    }
    if (indexPath.row == 0 || indexPath.row == self.dataSource.count) {
        return NO;
    }else {
        return YES;
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

/// 删除当前城市的上面或者下面
/// 删除当前城市
/// 当前城市是否是最后一个
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.editIndexPath = indexPath;
    self.deleIndex = 0;
    [self.view setNeedsLayout];
    __weak typeof (self) weakSelf = self;
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"      " handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        weakSelf.deleIndex = indexPath.row;
        [weakSelf.dataSource removeObjectAtIndex:indexPath.row];
        [weakSelf showCityWeather];
        weakSelf.isRemoveCell = YES;
        [[LocalArchiverManager shareManager] saveDataArchiver:weakSelf.dataSource fileName:@"mutableModel"];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }];
    
    return @[deleteAction];
}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    self.editIndexPath = nil;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 || indexPath.row == self.dataSource.count) {
        return NO;
    }else {
        return YES;
    }
}
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
    
    if (proposedDestinationIndexPath.row == 0 || proposedDestinationIndexPath.row == self.dataSource.count) {
        return sourceIndexPath;
    }
    return proposedDestinationIndexPath;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    /// 交换数据
    [self.dataSource exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    NSLog(@"%lu------%lu",sourceIndexPath.row,destinationIndexPath.row);
}
@end










































