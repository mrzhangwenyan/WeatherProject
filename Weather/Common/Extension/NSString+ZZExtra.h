//
//  NSString+ZZExtra.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/9.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (ZZExtra)

/// 时间戳转时间字符串
+ (NSString *)stringFromInterval: (NSString *)interval;
- (NSString *)toDateWithFormatterType: (NSString *)formatterStr;
+ (NSString *)stringExactFromInterval: (NSString *)interval;

/// 判断是不是手机号  areaCode区号
- (BOOL)isMobileNumberWithCode: (NSString *)areaCode;

/// 判断是否是中文
- (BOOL)isChinese;

/// 判断是否是6-18位数字加字母加密
- (BOOL)isPassword;

/// 判断是否是邮箱
- (BOOL)isLetterOrNum;

/// 返回时间几秒前
- (NSString *)stingTimeToStringAgo;

/// OSS压缩图片
- (NSString *)imageTailoringWithWidth:(int)width;

/// 去除首尾空格
- (NSString *)trim;

/// 转成货币,逗号分隔
- (NSString *)toCurrency;

/// 判断中英混合的的字符串长度
- (int)lengthToInt;

/// 根据最大宽度和字体返回字符串的尺寸大小
- (CGSize) sizeWithMaxWidth:(CGFloat)maxWidth andFont:(UIFont *)font;
- (CGSize) sizeWithMaxHeight:(CGFloat)maxHeight andFont:(UIFont *)font;
- (CGSize) sizeWithFont: (UIFont *)font;

/// 根据天气返回图片
+ (UIImage *)imageWithWeatherStr: (NSString *)weather;
/// 截取字符串
+ (NSString *)subStringFromString:(NSString *)string ByLoc:(NSInteger)loc length:(NSInteger)length;

@end


















