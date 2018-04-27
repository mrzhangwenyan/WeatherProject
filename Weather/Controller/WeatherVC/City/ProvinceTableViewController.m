//
//  ProvinceTableViewController.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/23.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "ProvinceTableViewController.h"
#import "ZZWeatherTools.h"
#import "NSArray+HandleData.h"
#import "ProvinceModel.h"
#import "CityTableViewController.h"
#import "ZZLocalFile.h"

@interface ProvinceTableViewController ()
@property (nonatomic, strong)NSArray<NSString *> *dataSource;
@property (nonatomic, strong)NSArray<ProvinceModel *> *model;
@property (nonatomic, strong)CityTableViewController *cityVC;
@end

@implementation ProvinceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"省";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"identifier"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    [self fetchProvinceData];
    self.dataSource = [ZZLocalFile sharedLocalFile].provinceCollection;
    self.model = [ZZLocalFile sharedLocalFile].provinceModel;
//    [HUDTools showHUDWithLabel:@"loading..." withView:self.view];
}
- (void)fetchProvinceData {
    
    [[ZZWeatherTools shared] requestQueryCityList:^(NSArray<ProvinceModel *> *model) {
//        self.dataSource = [model getProvinceCollection:model];
        self.model = model;
        [HUDTools removeHUD];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        ZZLog(@"%@",error.description);
    }];
}
- (CityTableViewController *)cityVC {
    if (!_cityVC) {
        _cityVC = [[CityTableViewController alloc] init];
    }
    return _cityVC;
}
- (NSArray<NSString *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsZero;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.cityVC.model = self.model;
    self.cityVC.cityDataSource = [self.model getCityCollection:self.model province:self.dataSource[indexPath.row]];
    [self.navigationController pushViewController:self.cityVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
@end













































