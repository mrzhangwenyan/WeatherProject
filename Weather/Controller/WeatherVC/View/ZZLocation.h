//
//  ZZLocation.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/17.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^ CallBack)(NSString *name);
@interface ZZLocation : NSObject
- (void)getUserLocation: (CallBack)block;
+ (instancetype)sharedManager;
@end
