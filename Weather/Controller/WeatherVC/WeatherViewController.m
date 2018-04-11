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

@interface WeatherViewController ()<UICollectionViewDataSource>
@property (nonatomic, strong)WeatherView *weatherView;
@property (nonatomic, strong)UICollectionView *collectionView;
@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"天气";
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"城市" style:UIBarButtonItemStyleDone target:self action:@selector(chooseCity)];
    self.navigationItem.rightBarButtonItem = barBtnItem;
    [self.view addSubview:self.weatherView];
    [self.view addSubview:self.collectionView];
    [self fetchWeatherDataSource];
}
- (void)fetchWeatherDataSource {
    [[ZZWeatherTools shared] requestWithCityName:@"上海" success:^(NSArray<WeatherModel *> *model) {
        NSLog(@"%lu",model.firstObject.future.count);
    } failure:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
}
- (UICollectionView *)collectionView {
    if(!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 1;
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.itemSize = CGSizeMake(100, 250);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_weatherView.frame), SCREENWIDTH, 250) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        [_collectionView registerClass:[WeatherCollectionCell class] forCellWithReuseIdentifier:@"identifier"];
    }
    return _collectionView;
}
///懒加载
- (WeatherView *)weatherView {
    if(_weatherView == nil) {
        _weatherView = [[WeatherView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-250)];
    }
    return _weatherView;
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

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    return cell;
}
@end











































