//
//  WeatherModel.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/11.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "WeatherModel.h"

@implementation WeatherModel

+ (nullable NSDictionary<NSString*, id>*)modelContainerPropertyGenericClass
{
    return @{@"future": [FutureModel class]};
}

@end

@implementation FutureModel
//+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
//{
//    return @{@"futureArr" : @"future"};
//}
@end
