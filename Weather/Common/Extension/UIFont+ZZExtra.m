//
//  UIFont+ZZExtra.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/10.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "UIFont+ZZExtra.h"

@implementation UIFont (ZZExtra)
+ (UIFont *)ZZFontWithName:(NSString *)fontName size:(CGFloat)fontsize {
    /// 当前系统版本号
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
    /// 忽略大小写判断包含字符串 localizedCaseInsensitiveContainsString
    if (systemVersion.floatValue >= 9.0 || ![fontName localizedCaseInsensitiveContainsString:@"PingFang"]) {
        return [UIFont fontWithName:fontName size:fontsize];
    }else {
        return  [UIFont systemFontOfSize:fontsize];
    }
}
@end
