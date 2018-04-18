//
//  ZZLocation.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/17.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "ZZLocation.h"

@interface ZZLocation()<CLLocationManagerDelegate>
@property(nonatomic, strong)CLLocationManager *manager;
@property(nonatomic, copy)NSString *cityName;
@property(nonatomic, copy)CallBack block;
@end
@implementation ZZLocation

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static ZZLocation *instance;
    dispatch_once(&onceToken, ^{
        instance = [[ZZLocation alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.manager = [[CLLocationManager alloc] init];
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            [self.manager requestWhenInUseAuthorization];
        }
        self.manager.delegate = self;
        [self startLocation];
    }
    return self;
}
- (void)getUserLocation:(CallBack)block {
    _block = block;
}
- (void)startLocation {
    /// 返回用户是否启用定位服务
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        return;
    }
    /// kCLAuthorizationStatusDenied /* 用户禁止使用定位或者定位服务处于关闭状态 */
    if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        _cityName = @"北京";
        _block(_cityName);
        return;
    }
    /// 每隔多少米定位一次
    self.manager.distanceFilter = 100;
    /// 定位精准度
    self.manager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [self.manager startUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations firstObject];
    /*
     使用位置前, 务必判断当前获取的位置是否有效
     如果水平精确度小于零, 代表虽然可以获取位置对象, 但是数据错误, 不可用
     */
    __weak typeof (self)weakSelf = self;
    if (location.horizontalAccuracy > 0) {
        /// 获取当前所在的城市名
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        /// 根据经纬度反向地理编译出地址信息
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (placemarks.count > 0) {
                CLPlacemark *placeMark = [placemarks firstObject];
                /// 获取城市
                NSString *city = placeMark.locality;
                if (!city) {
                    /// 四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                    city = placeMark.administrativeArea;
                }
                if ([city containsString:@"市"]) {
                    NSRange range = [city rangeOfString:@"市"];
                    NSString *handleCity = [city substringToIndex:range.location];
                    weakSelf.block(handleCity);
                }else {
                    weakSelf.block(city);
                }
            }
            else if (error == nil && [placemarks count] == 0) {
                NSLog(@"no result were returned");
            }
            else if (error != nil) {
                NSLog(@"an error occurred %@",error);
            }
        }];
        /// 系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
        [self.manager stopUpdatingLocation];
    }
    
}
@end

































