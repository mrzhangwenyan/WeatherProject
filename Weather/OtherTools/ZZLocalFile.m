//
//  ZZLocalFile.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/12.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "ZZLocalFile.h"
#import "ZZWeatherTools.h"
#import "NSArray+HandleData.h"
#import "ZZFMDBManager.h"

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
- (void)netRequest {
    [[ZZWeatherTools shared] requestQueryCityList:^(NSArray<ProvinceModel *> *model) {
        self.provinceCollection = [model getProvinceCollection:model];
        self.provinceModel = model;
        [[ZZFMDBManager sharedManager] insertData:[model getDistrictCollection:model]];
    } failure:nil];
}
@end
