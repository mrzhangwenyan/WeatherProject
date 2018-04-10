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
@end
