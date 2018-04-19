//
//  ProvinceModel+HandleData.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/19.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "NSArray+HandleData.h"

@implementation NSArray (HandleData)
- (NSArray *)getProvinceCollection:(NSArray<ProvinceModel *> *)modelArr; {
    NSMutableArray *mutableArr = [NSMutableArray array];
    [modelArr enumerateObjectsUsingBlock:^(ProvinceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [mutableArr addObject:obj.province];
    }];
    return mutableArr;
}

- (NSArray *)getCityCollection:(NSArray<ProvinceModel *> *)modelArr {
    NSMutableArray *mutableArr = [NSMutableArray array];
    [modelArr enumerateObjectsUsingBlock:^(ProvinceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        for (CityModel *model in obj.city) {
            [mutableArr addObject:model.city];
        }
    }];
    return mutableArr;
}
- (NSArray *)getDistrictCollection:(NSArray<ProvinceModel *> *)modelArr {
    NSMutableArray *mutableArr = [NSMutableArray array];
    [modelArr enumerateObjectsUsingBlock:^(ProvinceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        for (CityModel *model in obj.city) {
            for (DistrictModel *d in model.district) {
                [mutableArr addObject:d.district];
            }
        }
    }];
    return mutableArr;
}
@end
