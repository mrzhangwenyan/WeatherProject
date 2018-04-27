//
//  ZZFMDBManager.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/27.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "ZZFMDBManager.h"
#import <FMDB.h>

@interface ZZFMDBManager()
@property(nonatomic, strong)FMDatabaseQueue *queue;
@end

@implementation ZZFMDBManager
+ (instancetype)sharedManager {
    static ZZFMDBManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZZFMDBManager alloc] init];
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fileName = [doc stringByAppendingPathComponent:@"city.sqlite"];
        NSLog(@"%@",fileName);
        instance.queue = [FMDatabaseQueue databaseQueueWithPath:fileName];
    });
    return instance;
}
- (void)clearDatabase {
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        NSString *sql = [NSString stringWithFormat:@"delete from t_city"];
        BOOL flag = [db executeUpdate:sql];
        if (flag) {
            ZZLog(@"删除成功");
        }
    }];
}
- (BOOL)createDataBase {
    __block BOOL flag;
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
//        NSString *sql = @"CREATE TABLE IF NOT EXISTS t_city (id integer key AUTOINCREMENT, 'name' text NOT NULL);";
        NSString *sql = [NSString stringWithFormat:@"create table if not exists t_city ('name' TEXT)"];
        flag = [db executeUpdate:sql];
        if (flag) {
            ZZLog(@"成功");
        }else {
            ZZLog(@"失败");
        }
    }];
    return flag;
}
- (void)insertData:(NSArray *)dataSource {
    if ([self createDataBase]) {
        [self.queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
            for (NSString *str in dataSource) {
                NSString *sql = [NSString stringWithFormat:@"insert into t_city (name) values ('%@');",str];
                [db executeUpdate:sql];
            }
        }];
    }
}
- (NSArray *)queryData:(NSString *)text {

    __block NSMutableArray *resultArr = [NSMutableArray array];
    if (text.length != 0 || text) {
//        NSString *sql = [NSString stringWithFormat:@"select *from t_city"];
        NSString *sql = [NSString stringWithFormat:@"select *from t_city where name like '%%%@%%'",text];
        [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
            FMResultSet *set = [db executeQuery:sql];
            while ([set next]) {
                NSString *name = [set stringForColumn:@"name"];
                [resultArr addObject:name];
            }
        }];
    }else {
        return nil;
    }
    return [resultArr valueForKeyPath:@"@distinctUnionOfObjects.self"];
}
@end




































