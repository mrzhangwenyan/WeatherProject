//
//  ZZLocalFile.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/12.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "ZZLocalFile.h"
#import "ZZWeatherTools.h"

@implementation ZZLocalFile

+ (instancetype)sharedLocalFile {
    static dispatch_once_t onceToken;
    static ZZLocalFile *instance;
    dispatch_once(&onceToken, ^{
        instance = [[ZZLocalFile alloc] init];
    });
    return instance;
}
- (void)netRequestWithCityName:(NSString *)cityName {
    [[ZZWeatherTools shared] requestWithCityName:cityName success:^(NSArray<WeatherModel *> *model) {
        self.model = model.firstObject;
    } failure:nil];
}
@end
