//
//  ZZFMDBManager.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/27.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZFMDBManager : NSObject
+ (instancetype)sharedManager;
- (void)insertData:(NSArray *)dataSource;
- (NSArray *)queryData:(NSString *)text;
- (void)clearDatabase;
@end
