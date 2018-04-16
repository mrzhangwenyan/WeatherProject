//
//  FutureModel+HandleData.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/16.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "FutureModel+HandleData.h"

@implementation FutureModel (HandleData)
- (NSString *)getHighWeatherTemperature:(NSString *)weather {
    NSString *str = [weather substringToIndex:4];
    return str;
}
- (NSString *)getLowWeatherTemperature:(NSString *)weather {
    NSString *str = [weather substringFromIndex:weather.length-4];
    return str;
}
@end
