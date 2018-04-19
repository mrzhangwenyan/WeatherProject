//
//  ProvinceModel.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/19.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DistrictModel,CityModel;

@interface ProvinceModel: NSObject
@property (nonatomic, copy)NSString *province;
@property (nonatomic, copy)NSArray<CityModel*>*city;
@end

@interface CityModel: NSObject
@property (nonatomic, copy)NSString *city;
@property (nonatomic, strong)NSArray<DistrictModel*> *district;
@end

@interface DistrictModel: NSObject
@property (nonatomic, copy)NSString *district;
@end
