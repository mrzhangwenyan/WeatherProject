//
//  WeatherViewController.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/11.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "WeatherViewController.h"
#import "CityGroupTableViewController.h"

@interface WeatherViewController ()

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"城市" style:UIBarButtonItemStyleDone target:self action:@selector(chooseCity)];
    self.navigationItem.rightBarButtonItem = barBtnItem;
}

/// 选择城市
- (void)chooseCity{
    CityGroupTableViewController *cityGroupTableViewVC = [[CityGroupTableViewController alloc] init];
    [self.navigationController pushViewController:cityGroupTableViewVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
