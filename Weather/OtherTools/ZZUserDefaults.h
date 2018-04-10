//
//  ZZUserDefaults.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/10.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define ZZYourKeySetting @"ZZYourKeySetting"
@interface ZZUserDefaults : NSObject
+ (void)setObject:(id)obj forKey:(NSString *)key;
+ (id)objectForKey:(NSString *)key;

+(void)setBool:(BOOL)anBool forKey:(NSString *)key;
+(BOOL)boolForKey:(NSString *)key;

@end
