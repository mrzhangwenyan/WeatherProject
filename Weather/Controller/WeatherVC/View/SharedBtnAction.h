//
//  SharedBtnAction.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/16.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^callBack)(NSString *);
@interface SharedBtnAction : NSObject
- (void)sharedBtnRespond:(UIButton *)button;
+ (instancetype)sharedInstance;
@property (nonatomic, copy)callBack block;
@end
