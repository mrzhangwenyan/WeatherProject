//
//  ZZHttpTool.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/10.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 如果需要每个属性或每个方法都去指定nonnull和nullable，是一件非常繁琐的事。苹果为了减轻我们的工作量，专门提供了两个宏：NS_ASSUME_NONNULL_BEGIN，NS_ASSUME_NONNULL_END。在这两个宏之间的代码，所有简单指针对象都被假定为nonnull，因此我们只需要去指定那些nullable的指针。
 */
@interface ZZHttpTool : NSObject
NS_ASSUME_NONNULL_BEGIN

+ (void)GET:(NSString *)URLString parameters:(id)paramaters success: (void (^)(NSDictionary *responseDic))success failure: (void (^)(NSError *error))failure;
NS_ASSUME_NONNULL_END
@end
