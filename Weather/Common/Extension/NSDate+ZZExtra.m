//
//  NSDate+ZZExtra.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/10.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "NSDate+ZZExtra.h"

@implementation NSDate (ZZExtra)
+ (NSString *)weekdayFromDate:(NSDate *)date {
    NSArray *weekdays = @[[NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[[NSTimeZone alloc] initWithName:@"Asia/Beijing"]];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitWeekday fromDate:date];
    return [weekdays objectAtIndex:dateComponents.weekday];
}
@end
