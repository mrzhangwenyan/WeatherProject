//
//  TodayWeatherView.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/28.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherModel.h"

@interface TodayWeatherView : UIView
@property (nonatomic, strong)FutureModel *model;
@property (nonatomic, strong)UILabel *currenDayLabel;
@property (nonatomic, strong)UILabel *pollutionLabel;
@property (nonatomic, copy)NSString *title;
@end
