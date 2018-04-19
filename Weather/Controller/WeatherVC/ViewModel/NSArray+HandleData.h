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
/// 获取城市的集合
- (NSArray *)getCityCollection:(NSArray<ProvinceModel *> *)modelArr;
/// 获取区县的集合
- (NSArray *)getDistrictCollection:(NSArray<ProvinceModel *> *)modelArr;
@end
