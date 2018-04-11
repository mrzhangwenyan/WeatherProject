//
//  CityGroupTableViewController.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/11.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "CityGroupTableViewController.h"

@interface CityGroupTableViewController ()
@property (nonatomic, strong)NSArray *cityGroupArray;
@end

@implementation CityGroupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"城市列表";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(clickBackItem)];
    self.navigationItem.leftBarButtonItem = backItem;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"identifier"];
    
}
- (void)clickBackItem {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSArray *)cityGroupArray {
    if (!_cityGroupArray) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"cityGroups.plist" ofType:nil];
        NSArray *cityGroupArray = [NSArray arrayWithContentsOfFile:plistPath];
        ///所有字典对象转成模型对象
        NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in cityGroupArray) {
            /// 声明一个空的对象
            CityGroup *cityGroup = [[CityGroup alloc] init];
            /// kvc绑定模型对象属性和字典key关系
            [cityGroup setValuesForKeysWithDictionary:dic];
            [mutableArray addObject:cityGroup];
        }
        _cityGroupArray = mutableArray;
    }
    return _cityGroupArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cityGroupArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CityGroup *cityGroup = self.cityGroupArray[section];
    return cityGroup.cities.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
    CityGroup *cityGroup = self.cityGroupArray[indexPath.section];
    cell.textLabel.text = cityGroup.cities[indexPath.row];
    return  cell;
}
/// 返回section的头部
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    CityGroup *cityGroup = self.cityGroupArray[section];
    return cityGroup.title;
}
/// 返回tableViewIndex数组
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self.cityGroupArray valueForKey:@"title"];
}
/// 选中哪一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CityGroup *cityGroup = self.cityGroupArray[indexPath.section];
    NSString *name = cityGroup.cities[indexPath.row];
    if (_block != nil) {
        _block(name);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end



























