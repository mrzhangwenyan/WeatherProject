//
//  WeatherTableViewCell.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/16.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherModel.h"

@interface WeatherTableViewCell : UITableViewCell
@property (nonatomic ,strong) UILabel *promptLabel;
@property (nonatomic ,strong) UILabel *dataShowLabel;
@end
