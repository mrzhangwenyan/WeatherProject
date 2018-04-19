//
//  ZZWeatherTools.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/11.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherModel.h"
#import "ProvinceModel.h"

@interface ZZWeatherTools : NSObject
+(instancetype)shared;
/// 根据城市名查询天气
- (void)requestWithCityName:(NSString *)cityName success: (void (^)(NSArray<WeatherModel *> *model)) success failure: (void(^)(NSError *error))failure;
/// 天气类型查询
- (void)requestQueryWeatherType:(void(^)(NSArray* weatherTypeArr))success failure:(void(^)(NSError *error))failure;
/// 城市列表查询
- (void)requestQueryCityList:(void(^)(NSArray<ProvinceModel *>*model))success failure:(void(^)(NSError *error))failure;
@end
