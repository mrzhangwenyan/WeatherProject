//
//  SearchCityTableViewController.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/20.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeatherModel;

typedef void (^callBlock)(NSString *cityName);
@interface SearchCityTableViewController : UITableViewController
@property (nonatomic, strong)NSMutableArray<WeatherModel *> *dataSource;
@property (nonatomic, copy)callBlock block;
@property (nonatomic, copy)NSString *currentCity;
@end
