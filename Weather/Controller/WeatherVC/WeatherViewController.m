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
#import "WeatherTableViewCell.h"
#import "FutureModel+HandleData.h"
#import "NSArray+HandleData.h"
#import "SharedBtnAction.h"
#import "ZZLocation.h"
#import "SettingTableViewController.h"
#import "SearchCityTableViewController.h"
#import "ZZUserDefaults.h"
#import "LocalArchiverManager.h"
#import "ZZFMDBManager.h"

@interface WeatherViewController ()

@property (nonatomic, strong)WeatherView *weatherView;
@property (nonatomic, strong)UIView *rightView;
@property (nonatomic, strong)WeatherModel *weatherModel;
@property (nonatomic, strong)SharedView *sharedView;
@property (nonatomic, strong)UIView *shadeView;
@property (nonatomic, copy)NSString *cityName;
@property (nonatomic, assign)BOOL isRemoveNotification;
@property (nonatomic, strong)NSMutableArray<WeatherModel*> *mutableModel;

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"天气";
    
    self.tableView.backgroundView = [UIImageView imageViewWithName:@"back_two"];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightView];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"locationIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(chooseCity)];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    self.tableView.tableHeaderView = self.weatherView;
    [self.tableView registerClass:[WeatherTableViewCell class] forCellReuseIdentifier:@"identifier"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    __weak typeof (self) weakSelf = self;
    [self shareSuccess];
    
    /// 优化中...
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf fetchWeatherDataSourceWithCityName:self.cityName];
//    }];
    [HUDTools showHUDWithLabel:@"loading..." withView:self.view];
    [[ZZLocation sharedManager] getUserLocation:^(NSString *name) {
        weakSelf.cityName = name;
        [self fetchWeatherDataSourceWithCityName:name];
    }];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
//    NSArray *a = @[@"张",@"文",@"晏",@"张三",@"文章",@"子晏",@"张三丰"];
//    [[ZZFMDBManager sharedManager] insertData:a];
    
    
}
- (UIView *)rightView {
    if (!_rightView) {
        _rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        UIButton *cityBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 0, 30, 30)];
        /// cityBtn.adjustsImageWhenHighlighted = NO;
        [cityBtn setBackgroundImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
        [cityBtn addTarget:self action:@selector(jumpToSettingVC) forControlEvents:UIControlEventTouchUpInside];
        
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
        NSString *cityStr = model.firstObject.city;
        if ((![cityStr isEqual:[NSNull null]]) && ([cityStr isChinese])) {
            weakSelf.cityName = cityStr;
        }
        weakSelf.weatherView.model = model.firstObject;
        weakSelf.weatherModel = model.firstObject;
        __block BOOL isExit = YES;
        if (weakSelf.mutableModel.count >= 1) {
            isExit = NO;
            [weakSelf.mutableModel enumerateObjectsUsingBlock:^(WeatherModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.city isEqualToString:model.firstObject.city]) {
                    *stop = YES;
                    isExit = YES;
                }
            }];
        }else {
            /// 注意是英文的情况处理
            if ((![cityStr isEqual:[NSNull null]]) && ([cityStr isChinese])) {
                [weakSelf.mutableModel addObject:model.firstObject];
            }
        }
        if (!isExit) {
   
            if ((![cityStr isEqual:[NSNull null]]) && ([cityStr isChinese])) {
                NSMutableArray<WeatherModel *> *arrModel = [[LocalArchiverManager shareManager] archiverQueryName:@"mutableModel"];
                
                if (arrModel.count <= 0) {
                    [weakSelf.mutableModel addObject:model.firstObject];
                    [[LocalArchiverManager shareManager]saveDataArchiver:weakSelf.mutableModel fileName:@"mutableModel"];
                }else {                
                    __block BOOL isContain;
                    [arrModel enumerateObjectsUsingBlock:^(WeatherModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if ([obj.city isEqualToString:model.firstObject.city]) {
                            *stop = YES;
                            isContain = YES;
                        }
                    }];
                    if (!isContain) {
                        [arrModel addObject:model.firstObject];
                        [[LocalArchiverManager shareManager] saveDataArchiver:arrModel fileName:@"mutableModel"];
                    }
                }
            }
        }
        [weakSelf.weatherView.collectionView reloadData];
        [weakSelf.tableView reloadData];
        [HUDTools removeHUD];
//        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        ZZLog(@"%@",error.description);
    }];
}
- (NSMutableArray<WeatherModel *> *)mutableModel {
    if (!_mutableModel) {
        _mutableModel = [NSMutableArray array];
    }
    return _mutableModel;
}
///懒加载
- (WeatherView *)weatherView {
    if(_weatherView == nil) {
        _weatherView = [[WeatherView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 760)];
    }
    return _weatherView;
}
- (UIView *)shadeView {
    if(!_shadeView) {
        _shadeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _shadeView.backgroundColor = [[UIColor brownColor] colorWithAlphaComponent:0.1];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelSharedView)];
        [_shadeView addGestureRecognizer:tap];
    }
    return _shadeView;
}

- (SharedView *)sharedView {
    if (!_sharedView) {
        
        CGFloat height = (SCREENWIDTH / 4) + 40;
        _sharedView = [[SharedView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, height)];
        _sharedView.backgroundColor = [UIColor whiteColor];
        __weak typeof(self) weakSelf = self;
        _sharedView.cancelBlock = ^{
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.sharedView.top = SCREENHEIGHT;
                [weakSelf.shadeView removeFromSuperview];
            } completion:nil];
        };
        [_sharedView setCallBack:^(UIButton *button) {
            [weakSelf performSelector:@selector(cancelSharedView) withObject:nil afterDelay:0.5];
            [[SharedBtnAction sharedInstance] sharedBtnRespond:button];
        }];
    }
    return _sharedView;
}
- (void)addShadeViewToWindow {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self.shadeView];
    [window addSubview:self.sharedView];
    [self.sharedView bringSubviewToFront:self.shadeView];
}

- (void)cancelSharedView {
    [UIView animateWithDuration:0.5 animations:^{
        self.sharedView.top = SCREENHEIGHT;
        [self.shadeView removeFromSuperview];
    } completion:nil];
}
/// 设置页面
- (void)jumpToSettingVC {
    SettingTableViewController *setVc = [[SettingTableViewController alloc] init];
    [self.navigationController pushViewController:setVc animated:YES];
    self.isRemoveNotification = YES;
}
/// 选择城市
- (void)chooseCity{

    SearchCityTableViewController *cityTableVC = [[SearchCityTableViewController alloc] init];
    cityTableVC.dataSource = self.mutableModel;
    __weak typeof (self) weakSelf = self;
    [cityTableVC setBlock:^(NSString *cityName) {
        [weakSelf fetchWeatherDataSourceWithCityName:cityName];
    }];
    cityTableVC.currentCity = self.weatherModel.city;
    [self.navigationController pushViewController:cityTableVC animated:YES];
    
//    __weak typeof(self) weakSelf = self;
//    CityGroupTableViewController *cityGroupTableViewVC = [[CityGroupTableViewController alloc] init];
//    [cityGroupTableViewVC setBlock:^(NSString *cityName) {
//        ZZLog(@"%@",cityName);
//        [weakSelf fetchWeatherDataSourceWithCityName:cityName];
//    }];
//    [self.navigationController pushViewController:cityGroupTableViewVC animated:YES];
}

/// 分享
- (void)sharedAction {
    [SharedBtnAction sharedInstance].isShareAppStoreURL = NO;
    [SharedBtnAction sharedInstance].tableView = self.tableView;
    [self addShadeViewToWindow];
    CGFloat height = (SCREENWIDTH / 4) + 40;
    CGFloat Y = SCREENHEIGHT-height;
    [UIView animateWithDuration:0.5 animations:^{
        self.sharedView.top = Y;
    }];
}
- (void)shareSuccess {
    [[SharedBtnAction sharedInstance] setBlock:^(NSString *title,BOOL isInstall) {
        NSString *message = nil;
        if (isInstall) {
            if ([title isEqualToString:@"分享成功"]) {
                message = @"成功";
            }else {
                message = @"失败";
            }
        }else {
            message = @"去AppStore下载";
        }
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:sure];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}
- (void)districtWeather:(NSNotification *)info {
    NSDictionary *dict = [info userInfo];
    NSString *name = dict[@"name"];
    [self fetchWeatherDataSourceWithCityName:name];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.delegate = self;
    [self scrollViewDidScroll:self.tableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.isRemoveNotification = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(districtWeather:) name:@"districtName" object:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
    if (self.isRemoveNotification) {
        [[NSNotificationCenter defaultCenter]removeObserver:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UIColor *color = CustomBlack;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    }else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = nil;
    if (indexPath.row == 0) {
        identifier = @"cellID";
    }else {
        identifier = @"identifier";
    }
    UITableViewCell *commonCell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (indexPath.row == 0) {
        UITableViewCell *cell = (UITableViewCell *)commonCell;
        FutureModel *model = self.weatherModel.future.firstObject;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.textColor = CustomBlack;
        if ([model.temperature containsString:@"/"]) {
            NSString *highStr = [model getHighWeatherTemperature:model.temperature];
            NSString *lowStr = [model getLowWeatherTemperature:model.temperature];
            cell.textLabel.text = [NSString stringWithFormat:@"今天：现在%@。最高温度%@。今晚%@。最低温度%@。",model.dayTime,highStr,model.night,lowStr];
        }else {
            cell.textLabel.text = [NSString stringWithFormat:@"今天：现在%@。最高温度%@。今晚%@",model.dayTime,model.temperature,model.night];
        }
        
    }else {
        WeatherTableViewCell *cell = (WeatherTableViewCell *)commonCell;
        
        switch (indexPath.row) {
            case 0:
            cell.promptLabel.hidden = YES;
            cell.dataShowLabel.hidden = YES;
            break;
            case 1:

            cell.promptLabel.text = @"日出";
            cell.dataShowLabel.text = self.weatherModel.sunset;
            break;
            case 2:
            
            cell.promptLabel.text = @"日落";
            cell.dataShowLabel.text = self.weatherModel.sunrise;
            break;
            case 3:
            
            cell.promptLabel.text = @"湿度";
            cell.dataShowLabel.text = [_weatherModel.humidity substringFromIndex:_weatherModel.humidity.length - 3];
            break;
            case 4:
            
            cell.promptLabel.text = @"风速";
            cell.dataShowLabel.text = _weatherModel.wind;
            break;
            case 5:
            
            cell.promptLabel.text = @"空气质量";
            cell.dataShowLabel.text = _weatherModel.airCondition;
            break;
            case 6:
            
            cell.promptLabel.text = @"穿衣类型";
            cell.dataShowLabel.text = _weatherModel.dressingIndex;
            break;
            case 7:
            
            cell.promptLabel.text = @"运动指数";
            cell.dataShowLabel.text = _weatherModel.exerciseIndex;
            break;
            case 8:
            
            cell.promptLabel.text = @"洗车指数";
            cell.dataShowLabel.text = _weatherModel.washIndex;
            break;
            case 9:
            
            cell.promptLabel.text = @"感冒指数";
            cell.dataShowLabel.text = _weatherModel.coldIndex;
            break;
            case 10:
            
            cell.promptLabel.text = @"空气污染";
            cell.dataShowLabel.text = _weatherModel.pollutionIndex;
            break;
            default:
            break;
        }
    }
    commonCell.backgroundColor = [UIColor clearColor];
    commonCell.layoutMargins = UIEdgeInsetsZero;
    commonCell.separatorInset = UIEdgeInsetsZero;
    commonCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return commonCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

@end











































