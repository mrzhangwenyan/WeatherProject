//
//  ProvinceModel+HandleData.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/19.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProvinceModel.h"

@interface NSArray (HandleData)
/// 获取省的名称集合
- (NSArray *)getProvinceCollection:(NSArray<ProvinceModel *> *)modelArr;
/// 根据省会获取城市的集合
- (NSArray *)getCityCollection:(NSArray<ProvinceModel *> *)modelArr province: (NSString *)provinceName;
/// 根据城市获取区县的集合
- (NSArray *)getDistrictCollection:(NSArray<ProvinceModel *> *)modelArr city: (NSString *)cityName;
@end
