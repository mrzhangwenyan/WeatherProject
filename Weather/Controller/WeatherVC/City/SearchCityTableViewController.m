//
//  SearchCityTableViewController.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/20.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "SearchCityTableViewController.h"
#import "HotCityTableViewController.h"

@interface SearchCityTableViewController ()
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, assign)BOOL isSelectedItem;
@property (nonatomic, strong)NSIndexPath *editIndexPath;
@end

@implementation SearchCityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"城市管理";
    self.isSelectedItem = false;
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editTableViewCell:)];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    self.tableView.tableFooterView = [[UIView alloc] init];
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
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1", nil];
    }
    return _dataSource;
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (self.editIndexPath) {
        [self configSwipeButtons];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    NSString *imageName = nil;
    if (indexPath.row == self.dataSource.count) {
        imageName = @"addCity";
    }else {
        imageName = @"sunshine";
    }

    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsZero;
    UIImage *image = [UIImage imageNamed:imageName];
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
        cell.textLabel.text = self.dataSource[indexPath.row];
        cell.detailTextLabel.text = @"25℃";
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == self.dataSource.count) {
        HotCityTableViewController *hotvc = [[HotCityTableViewController alloc] init];
        [self.navigationController pushViewController:hotvc animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == self.dataSource.count) {
        return NO;
    }else {
        return YES;
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    self.editIndexPath = nil;
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.editIndexPath = indexPath;
    [self.view setNeedsLayout];
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"      " handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
//        [tableView setEditing:NO animated:YES];
    }];
    return @[deleteAction];
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










































