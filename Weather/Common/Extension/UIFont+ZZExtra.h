//
//  UIFont+ZZExtra.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/10.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  安全设置字体的方法 方式ios9以下版本对平方字体的不支持
 */
@interface UIFont (ZZExtra)
+ (UIFont *)ZZFontWithName: (NSString *)fontName size:(CGFloat)fontsize;
@end
