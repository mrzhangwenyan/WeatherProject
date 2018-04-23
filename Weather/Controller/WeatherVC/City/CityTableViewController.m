//
//  CityTableViewController.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/23.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "CityTableViewController.h"
#import "NSArray+HandleData.h"
#import "DistrictTableViewController.h"

@interface CityTableViewController ()
@property (nonatomic, strong)DistrictTableViewController *districtVC;
@end

@implementation CityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"城市";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"identifier"];
}
- (DistrictTableViewController *)districtVC {
    if (!_districtVC) {
        _districtVC = [[DistrictTableViewController alloc] init];
    }
    return _districtVC;
}
- (void)setCityDataSource:(NSArray<NSString *> *)cityDataSource{
    _cityDataSource = cityDataSource;
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cityDataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
    cell.textLabel.text = self.cityDataSource[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsZero;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.districtVC.districtDataSource = [self.model getDistrictCollection:self.model city:self.cityDataSource[indexPath.row]];
    [self.navigationController pushViewController:self.districtVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
@end


































