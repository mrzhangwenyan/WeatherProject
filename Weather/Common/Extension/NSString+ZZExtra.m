//
//  NSString+ZZExtra.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/9.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "NSString+ZZExtra.h"

@implementation NSString (ZZExtra)
/**
 *  @brief @"yyyy-MM-dd 00:00:00"
 */
+ (NSString *)stringFromInterval:(NSString *)interval {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[interval longLongValue]/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}
+ (NSString *)stringExactFromInterval:(NSString *)interval{
    NSCalendar *calendar = [NSCalendar new];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[interval longLongValue]/1000];
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }else {
        calendar = [NSCalendar currentCalendar];
    }
    NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
    NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:date];
    NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    BOOL isToday = NO;
    BOOL isYesterday = NO;
    if ([cmp1 day] == [cmp2 day]) { // 今天
        formatter.dateFormat = @" HH:mm";
        isToday = YES;
    } else if ([cmp1 year] == [cmp2 year]) { // 今年
        if ([cmp2 day] - [cmp1 day] == 1) {
            formatter.dateFormat = @" HH:mm";
            isYesterday = YES;
        }else {
            formatter.dateFormat = @"MM-dd HH:mm";
        }
    } else {
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    }
    NSString *timeString = [formatter stringFromDate:date];
    if (isToday) {
        return [NSString stringWithFormat:@"今天 %@",timeString];
    }else if (isYesterday){
        return [NSString stringWithFormat:@"昨天 %@",timeString];
    }else {
        return timeString;
    }
}

- (NSCalendar *)currentCalendar {
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }
    return [NSCalendar currentCalendar];
}

- (NSString *)toDateWithFormatterType:(NSString *)formatterStr {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self longLongValue]/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatterStr];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}
/// 验证手机号码的格式
- (BOOL)isMobileNumberWithCode:(NSString *)areaCode {
    
    if ([areaCode isEqualToString:@"+86"]) {
        NSString * MOBILE = @"^[1]\\d{10}$";
        NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        if ([regextestcm evaluateWithObject:self] == YES) {
            return YES;
        } else {
            return NO;
        }
    }else {
        NSString * MOBILE = @"^[0-9]{6,20}$";
        NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        if ([regextestcm evaluateWithObject:self] == YES) {
            return YES;
        } else {
            return NO;
        }
    }
}

-(BOOL)isChinese{
    
    NSString *str = self;
    
    if ([str lengthOfBytesUsingEncoding:NSASCIIStringEncoding] == 0) {
        return YES;
    }else{
        return NO;
    }
}
- (BOOL)isPassword {
    
    NSString * password = @"^[0-9a-zA-Z_#]{6,18}$";
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", password];
    /// evaluateWithObject 通过一个对象来计算谓词的结果
    if ([regextestcm evaluateWithObject:self] == YES) {
        return  YES;
    }else {
        return NO;
    }
}

- (BOOL)isLetterOrNum {
    
    NSString * password = @"[a-zA-Z\\u4e00-\\u9fa5][a-zA-Z0-9\\u4e00-\\u9fa5]+";
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", password];
    
    if ([regextestcm evaluateWithObject:self] == YES) {
        return  YES;
    }else {
        return NO;
    }
}

- (BOOL)isEmail {
    
    NSString * password = @"^[A-Za-z0-9\\u4e00-\\u9fa5]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", password];
    if ([regextestcm evaluateWithObject:self] == YES) {
        return  YES;
    }else {
        return NO;
    }
}

- (NSString *)takeSpellFromString{
    NSMutableString *pinyin = [self mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    return [pinyin uppercaseString];
}

- (NSString *)stingTimeToStringAgo {
    
    NSString *result = self;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter  dateFromString:self];
    
    NSTimeInterval nowDate = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval serverDate = [date timeIntervalSince1970];
    
    if (nowDate - serverDate < 60) {
        result = [NSString stringWithFormat:@"%.0f秒前", nowDate - serverDate];//秒
    }else if (nowDate - serverDate < 60*60) {
        result = [NSString stringWithFormat:@"%.0f分前", (nowDate - serverDate)/60];
    }else if (nowDate - serverDate < 60*60*24) {
        result = [NSString stringWithFormat:@"%.0f小时前", (nowDate - serverDate)/60/60];
    }else if (nowDate - serverDate < 60*60*24*2) {
        result = @"昨天";
    }else if (nowDate - serverDate < 60*60*24*3) {
        result = @"前天";
    }
    
    return result;
}
//oss图片拼接
- (NSString *)imageTailoringWithWidth:(int)width {
    if (![self containsString:@"@"] && ![self containsString:@".png"] && ![self containsString:@"x-oss-process"]) {
        return [NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_%d",self,width];
    }
    return self;
}

- (NSString *)trim {
    NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *str = [[NSString alloc]initWithString:[self stringByTrimmingCharactersInSet:whiteSpace]];
    if ([str isEqualToString:@""]) {
        return nil;
    }
    return str;
}

- (NSString *)toCurrency {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:self.floatValue]];
    return formattedNumberString;
}
//判断中英混合的的字符串长度
- (int)lengthToInt{
    int strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

- (CGSize)sizeWithMaxWidth:(CGFloat)maxWidth andFont:(UIFont *)font{
    //计算文本的最大区域
    CGSize maxSize=CGSizeMake(maxWidth, CGFLOAT_MAX);
    //计算文本使用的字体
    NSDictionary *attr=@{NSFontAttributeName:font};
    //文本的实际大小   NSStringDrawingUsesLineFragmentOrigin 整个文本将以每行组成的矩形为单位计算整个文本的尺寸
    CGSize textSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    return textSize;
}

- (CGSize)sizeWithMaxHeight:(CGFloat)maxHeight andFont:(UIFont *)font {
    CGSize maxSize = CGSizeMake(MAXFLOAT, maxHeight);
    NSDictionary *attr = @{NSFontAttributeName:font};
    CGSize textSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    return textSize;
}

- (CGSize)sizeWithFont:(UIFont *)font {
    return [self sizeWithMaxWidth:MAXFLOAT andFont:font];
}

/// 根据天气返回图片
+ (UIImage *)imageWithWeatherStr:(NSString *)weather {
    if ([weather containsString:@"多云"]) {
        return [UIImage imageNamed:@"moreCloudy"];
    }
    else if ([weather containsString:@"少云"]) {
        return [UIImage imageNamed:@"littleCloudy"];
    }
    else if ([weather containsString:@"阴"]) {
        return [UIImage imageNamed:@"shade"];
    }
    else if ([weather containsString:@"霾"]) {
        return [UIImage imageNamed:@"haze"];
    }
    else if ([weather containsString:@"晴"]) {
        return [UIImage imageNamed:@"sunshine"];
    }
    else if ([weather containsString:@"阵雨"]) {
        return [UIImage imageNamed:@"thunderRain"];
    }
    else if ([weather containsString:@"雷阵雨"]) {
        return [UIImage imageNamed:@"thunderShower"];
    }
    else if ([weather containsString:@"小雨"]) {
        return [UIImage imageNamed:@"smallRain"];
    }
    else if ([weather containsString:@"中雨"]) {
        return [UIImage imageNamed:@"middleRain"];
    }
    else if ([weather containsString:@"零散阵雨"]) {
        return [UIImage imageNamed:@"thunderRain"];
    }
    else if ([weather containsString:@"零散雷雨"]) {
        return [UIImage imageNamed:@"thunderShower"];
    }
    else if ([weather containsString:@"大雨"]) {
        return [UIImage imageNamed:@"rain_b_h"];
    }
    else if ([weather containsString:@"暴雨"]) {
        return [UIImage imageNamed:@"rain_b_hh"];
    }
    else if ([weather containsString:@"雨"]) {
        return [UIImage imageNamed:@"middleRain"];
    }
    
    
    else if ([weather containsString:@"雨夹雪"]) {
        return [UIImage imageNamed:@"rainWithSnow"];
    }
    else if ([weather containsString:@"阵雪"]) {
        return [UIImage imageNamed:@"thunderSnow"];
    }
    else if ([weather containsString:@"小雪"]) {
        return [UIImage imageNamed:@"smallSnow"];
    }
    else if ([weather containsString:@"中雪"]) {
        return [UIImage imageNamed:@"snow_b_m"];
    }
    else if ([weather containsString:@"大雪"]) {
        return [UIImage imageNamed:@"snow_b_h"];
    }
    return [UIImage imageNamed:@""];
}
+ (NSString *)transformToWeek:(NSString *)string {
    if ([string isEqualToString:@"星期一"]) {
        return @"周一";
    }
    else if([string isEqualToString:@"星期二"]) {
        return @"周二";
    }
    else if([string isEqualToString:@"星期三"]) {
        return @"周三";
    }
    else if([string isEqualToString:@"星期四"]) {
        return @"周四";
    }
    else if([string isEqualToString:@"星期五"]) {
        return @"周五";
    }
    else if([string isEqualToString:@"星期六"]) {
        return @"周六";
    }
    else if([string isEqualToString:@"星期日"]) {
        return @"周日";
    }
    return string;
}

/// 截取字符串
+ (NSString *)subStringFromString:(NSString *)string ByLoc:(NSInteger)loc length:(NSInteger)length {
    NSString *str = [string substringWithRange:NSMakeRange(loc, length)];
    return str;
}

//获取汉字转成拼音字符串  通讯录模糊搜索 支持拼音检索 首字母 全拼 汉字 搜索
+ (NSString *)transformToPinyin:(NSString *)aString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    NSArray *pinyinArray = [str componentsSeparatedByString:@" "];
    NSMutableString *allString = [NSMutableString new];
    int count = 0;
    for (int  i = 0; i < pinyinArray.count; i++)
    {
        for(int i = 0; i < pinyinArray.count;i++)
        {
            if (i == count) {
                [allString appendString:@"#"];//区分第几个字母
            }
            [allString appendFormat:@"%@",pinyinArray[i]];
        }
        [allString appendString:@","];
        count ++;
    }
    NSMutableString *initialStr = [NSMutableString new];//拼音首字母
    for (NSString *s in pinyinArray)
    {
        if (s.length > 0)
        {
            [initialStr appendString:  [s substringToIndex:1]];
        }
    }
    [allString appendFormat:@"#%@",initialStr];
    [allString appendFormat:@",#%@",aString];
    return allString;
}
@end
