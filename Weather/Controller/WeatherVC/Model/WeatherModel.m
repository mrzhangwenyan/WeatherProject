//
//  WeatherModel.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/11.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "WeatherModel.h"

@implementation ZZModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result": [ZZModel class]};
}
@end

@implementation WeatherModel

@end

@implementation FutureModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"future": [FutureModel class]};
}
@end
