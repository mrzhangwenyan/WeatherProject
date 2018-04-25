//
//  WeatherModel.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/11.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "WeatherModel.h"

@implementation WeatherModel
/// 利用运行时 对属性进行归档解档
+ (nullable NSDictionary<NSString*, id>*)modelContainerPropertyGenericClass
{
    return @{@"future": [FutureModel class]};
}
- (void)encodeWithCoder:(NSCoder *)coder
{
    Class currentClass = self.class;
    if (currentClass == NSObject.class) {
        return;
    }
    while (currentClass && currentClass != [NSObject class]) {
        unsigned int count = 0;
        objc_property_t *pList = class_copyPropertyList(currentClass, &count);
        if (count > 0) {
            for (int i = 0; i<count; i++) {
                NSString *key = [NSString stringWithUTF8String:property_getName(pList[i])];
                [coder encodeObject:[self valueForKey:key] forKey:key];
            }
        }
        currentClass = class_getSuperclass(currentClass);
        free(pList);
    }
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    Class currentClass = self.class;
    if (currentClass == NSObject.class) {
        return nil;
    }
    while (currentClass && currentClass != [NSObject class]) {
        unsigned int count = 0;
        objc_property_t *plist = class_copyPropertyList(currentClass, &count);
        if (count > 0) {
            for (int i = 0; i<count; i++) {
                NSString *key = [NSString stringWithUTF8String:property_getName(plist[i])];
                [self setValue:[coder decodeObjectForKey:key] forKey:key];
            }
        }
        currentClass = class_getSuperclass(currentClass);
        free(plist);
    }
    return self;
}

@end

@implementation FutureModel
- (void)encodeWithCoder:(NSCoder *)coder
{
    Class currentClass = self.class;
    if (currentClass == NSObject.class) {
        return;
    }
    while (currentClass && currentClass != [NSObject class]) {
        unsigned int count = 0;
        objc_property_t *plist = class_copyPropertyList(currentClass, &count);
        if (count > 0) {
            for (int i=0; i<count; i++) {
                NSString *key = [NSString stringWithUTF8String:property_getName(plist[i])];
                [coder encodeObject:[self valueForKey:key] forKey:key];
            }
        }
        currentClass = class_getSuperclass(currentClass);
        free(plist);
    }
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    Class currentClass = self.class;
    if (currentClass == NSObject.class) {
        return nil;
    }
    while (currentClass && currentClass != [NSObject class]) {
        unsigned int count = 0;
        objc_property_t *plist = class_copyPropertyList(currentClass, &count);
        if (count>0) {
            for (int i=0; i<count; i++) {
                NSString *key = [NSString stringWithUTF8String:property_getName(plist[i])];
                [self setValue:[coder decodeObjectForKey:key] forKey:key];
            }
        }
        currentClass = class_getSuperclass(currentClass);
        free(plist);
    }
    return self;
}
//+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
//{
//    return @{@"futureArr" : @"future"};
//}
@end











































