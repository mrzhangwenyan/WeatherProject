//
//  ZZWeatherTools.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/11.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "ZZWeatherTools.h"
#import "ZZHttpTool.h"

@implementation ZZWeatherTools
+ (instancetype)shared {
    static ZZWeatherTools *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZZWeatherTools alloc] init];
    });
    return instance;
}
- (void)requestWithCityName:(NSString *)cityName success: (void (^)(NSArray<WeatherModel *> *model)) success failure: (void(^)(NSError *error))failure {
    NSDictionary *paramaters = @{
                                 @"city": cityName,
                                 @"key": @"2529916f4bc5c"
                                 };
    NSString *url = @"http://apicloud.mob.com/v1/weather/query";
    [ZZHttpTool GET:url parameters:paramaters success:^(NSDictionary * _Nonnull responseDic) {
        NSArray *arr = [NSArray yy_modelArrayWithClass:[WeatherModel class] json:responseDic[@"result"]];

        success(arr);
    } failure:failure];
}
@end
