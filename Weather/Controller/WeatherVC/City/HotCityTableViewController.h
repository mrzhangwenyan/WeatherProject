//
//  HotCityTableViewController.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/20.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeatherModel;

@interface HotCityTableViewController : UIViewController
@property (nonatomic, strong)NSArray<WeatherModel *> *hotCityArr;
@end
