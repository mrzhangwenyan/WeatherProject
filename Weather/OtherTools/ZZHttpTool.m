//
//  ZZHttpTool.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/10.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "ZZHttpTool.h"
#import <AFNetworking/AFNetworking.h>

@implementation ZZHttpTool
+ (AFHTTPSessionManager *)sharedTools {
    static AFHTTPSessionManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [AFHTTPSessionManager manager];
        instance.responseSerializer = [AFJSONResponseSerializer serializer];
        instance.requestSerializer.timeoutInterval = 60;
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    });
    return instance;
}

+ (void)GET:(NSString *)URLString parameters:(id)paramaters success:(void (^)(NSDictionary * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    AFHTTPSessionManager *manager = [self sharedTools];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [manager GET:URLString parameters:paramaters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (success) {success((NSDictionary *)responseObject);}
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (failure) {failure(error);}
    }];
}
@end
