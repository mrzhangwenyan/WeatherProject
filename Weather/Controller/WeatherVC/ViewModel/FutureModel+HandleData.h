//
//  FutureModel+HandleData.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/16.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "WeatherModel.h"

@interface FutureModel (HandleData)
- (NSString *)getHighWeatherTemperature:(NSString *)weather;
- (NSString *)getLowWeatherTemperature:(NSString *)weather;
@end
