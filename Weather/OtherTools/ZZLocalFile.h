//
//  ZZLocalFile.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/12.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WeatherModel;

@interface ZZLocalFile : NSObject
@property(nonatomic, strong)WeatherModel *model;
+ (instancetype)sharedLocalFile;
- (void)netRequestWithCityName:(NSString *)cityName;
@end
