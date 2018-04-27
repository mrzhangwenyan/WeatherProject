//
//  ZZLocalFile.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/12.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WeatherModel;
@class ProvinceModel;

@interface ZZLocalFile : NSObject
@property(nonatomic, strong)WeatherModel *model;
@property(nonatomic, strong)NSArray *provinceCollection;
@property(nonatomic, strong)NSArray *cityCollection;
@property(nonatomic, strong)NSArray <ProvinceModel *> *provinceModel;
+ (instancetype)sharedLocalFile;
- (void)netRequestWithCityName:(NSString *)cityName;
/// 城市列表查询
- (void)netRequest;
@end
