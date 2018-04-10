//
//  UIButton+ZZExtra.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/10.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ZZButtonActionCallBack)(UIButton *button);

@interface UIButton (ZZExtra)
/// bool 类型YES不允许点击 NO允许点击 设置是否执行点UI方法
@property(nonatomic, assign) BOOL isIgnoreEvent;
/// 设置点击时间间隔
@property(nonatomic, assign) NSTimeInterval timeInterval;
/// 用于设置单个按钮不需要被Hook
@property(nonatomic, assign) BOOL isIgnore;
/**
 *  @brief replace the method 'addTarget:forControlEvents:'
 *  @warning executed this method, the property 'enabled' is 'NO'
 */
- (void)addZZCallBackAction:(ZZButtonActionCallBack)callBack forControlEvents:(UIControlEvents)controlEvents;
@end
