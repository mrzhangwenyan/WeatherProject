//
//  ProvinceModel.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/19.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "ProvinceModel.h"

@implementation ProvinceModel
+ (nullable NSDictionary<NSString*, id>*)modelContainerPropertyGenericClass
{
    return @{@"city": [CityModel class]};
}
@end
@implementation CityModel
+ (nullable NSDictionary<NSString*, id>*)modelContainerPropertyGenericClass
{
    return @{@"district": [DistrictModel class]};
}
@end

@implementation DistrictModel

@end
