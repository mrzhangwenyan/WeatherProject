//
//  WeatherModel.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/11.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherModel : NSObject
/// 空气质量
@property(nonatomic, copy)NSString *airCondition;
/// 城市
@property(nonatomic, copy)NSString *city;
/// 感冒指数
@property(nonatomic, copy)NSString *coldIndex;
/// 日期
@property(nonatomic, copy)NSString *date;
/// 区县
@property(nonatomic, copy)NSString *distrct;
/// 穿衣指数
@property(nonatomic, copy)NSString *dressingIndex;
/// 运动指数
@property(nonatomic, copy)NSString *exerciseIndex;
/// 湿度
@property(nonatomic, copy)NSString *humidity;
/// 省份
@property(nonatomic, copy)NSString *province;
/// 日出时间
@property(nonatomic, copy)NSString *sunset;
/// 日落时间
@property(nonatomic, copy)NSString *sunrise;
/// 温度
@property(nonatomic, copy)NSString *temperature;
/// 时间
@property(nonatomic, copy)NSString *time;
/// 洗车指数
@property(nonatomic, copy)NSString *washIndex;
/// 天气
@property(nonatomic, copy)NSString *weather;
/// 星期
@property(nonatomic, copy)NSString *week;
/// 风向
@property(nonatomic, copy)NSString *wind;
@end

@interface FutureMode: NSObject

@end


































