//
//  WeatherViewController.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/11.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "WeatherViewController.h"
#import "CityGroupTableViewController.h"
#import "WeatherView.h"
#import "WeatherCollectionCell.h"
#import "ZZWeatherTools.h"
#import "NSDictionary+Log.h"
#import "ZZLocalFile.h"
#import "SharedView.h"

@interface WeatherViewController ()

@property (nonatomic, strong)WeatherView *weatherView;
//@property (nonatomic, strong)UICollectionView *collectionView;
//@property (nonatomic, strong)WeatherModel *model;
@property (nonatomic, strong)UIView *rightView;
@property (nonatomic, strong)SharedView *sharedView;

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"天气";
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightView];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
    self.tableView.tableHeaderView = self.weatherView;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"identifier"];
//    [self.view addSubview:self.weatherView];
//    [self.view addSubview:self.collectionView];
//    [self.view addSubview:self.sharedView];
//    [self fetchWeatherDataSourceWithCityName:@"上海"];
    
}
- (UIView *)rightView {
    if (!_rightView) {
        _rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        UIButton *cityBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 0, 30, 30)];
//        cityBtn.adjustsImageWhenHighlighted = NO;
        [cityBtn setBackgroundImage:[UIImage imageNamed:@"locationIcon"] forState:UIControlStateNormal];
        [cityBtn addTarget:self action:@selector(chooseCity) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *sharedBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [sharedBtn setImage:[UIImage imageNamed:@"sharedIcon"] forState:UIControlStateNormal];
        [sharedBtn addTarget:self action:@selector(sharedAction) forControlEvents:UIControlEventTouchUpInside];
        [_rightView addSubview:cityBtn];
        [_rightView addSubview:sharedBtn];
        
    }
    return _rightView;
}
- (void)fetchWeatherDataSourceWithCityName:(NSString *)city {
    __weak typeof(self) weakSelf = self;
    [[ZZWeatherTools shared] requestWithCityName:city success:^(NSArray<WeatherModel *> *model) {
        weakSelf.weatherView.model = model.firstObject;
//        weakSelf.model = model.firstObject;
        [weakSelf.weatherView.collectionView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
}
//- (UICollectionView *)collectionView {
//    if(!_collectionView) {
//
//        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        flowLayout.minimumLineSpacing = 1;
//        flowLayout.minimumInteritemSpacing = 1;
//        flowLayout.itemSize = CGSizeMake(100, 250);
//        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//
//        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_weatherView.frame), SCREENWIDTH, 250) collectionViewLayout:flowLayout];
//        _collectionView.backgroundColor = [UIColor whiteColor];
//        _collectionView.dataSource = self;
//        [_collectionView registerClass:[WeatherCollectionCell class] forCellWithReuseIdentifier:@"identifier"];
//    }
//    return _collectionView;
//}

///懒加载
- (WeatherView *)weatherView {
    if(_weatherView == nil) {
        _weatherView = [[WeatherView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    }
    return _weatherView;
}

- (SharedView *)sharedView {
    if (!_sharedView) {
        
        CGFloat height = (SCREENWIDTH / 4) + 40;
        _sharedView = [[SharedView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, height)];
        _sharedView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.7];
        __weak typeof(self) weakSelf = self;
        _sharedView.cancelBlock = ^{
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.sharedView.top = SCREENHEIGHT;
//                [weakSelf.view layoutIfNeeded];
            } completion:nil];
        };
    }
    return _sharedView;
}

/// 选择城市
- (void)chooseCity{

    __weak typeof(self) weakSelf = self;
    CityGroupTableViewController *cityGroupTableViewVC = [[CityGroupTableViewController alloc] init];
    [cityGroupTableViewVC setBlock:^(NSString *cityName) {
        NSLog(@"%@",cityName);
        [weakSelf fetchWeatherDataSourceWithCityName:cityName];
    }];
    [self.navigationController pushViewController:cityGroupTableViewVC animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.sharedView removeFromSuperview];
}

/// 分享
- (void)sharedAction {
    CGFloat height = (SCREENWIDTH / 4) + 40;
    CGFloat Y = SCREENHEIGHT-height - 64;
    [UIView animateWithDuration:0.5 animations:^{
        self.sharedView.top = Y;
    } completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
    cell.textLabel.text = @"text";
    return cell;
}
//#pragma mark UICollectionViewDataSource
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return self.model.future.count;
//}
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    WeatherCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
//    cell.model = self.model.future[indexPath.row];
//    return cell;
//}
@end











































