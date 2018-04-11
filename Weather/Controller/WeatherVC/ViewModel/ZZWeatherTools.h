//
//  ZZWeatherTools.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/11.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherModel.h"

@interface ZZWeatherTools : NSObject
+(instancetype)shared;
- (void)requestWithCityName:(NSString *)cityName success: (void (^)(ZZModel *model)) success failure: (void(^)(NSError *error))failure;
@end
