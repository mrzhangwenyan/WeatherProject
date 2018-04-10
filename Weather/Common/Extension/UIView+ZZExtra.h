//
//  UIView+ZZExtra.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/10.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZZExtra)
/**
 *  返回UIView及其子类的位置和尺寸。分别为左、右边界在X轴方向上的距离，上、下边界在Y轴上的距离，View的宽和高。
 */
@property(nonatomic, assign) CGFloat left;
@property(nonatomic, assign) CGFloat right;
@property(nonatomic, assign) CGFloat top;
@property(nonatomic, assign) CGFloat bottom;
@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;
@property(nonatomic, assign) CGFloat centerX;
@property(nonatomic, assign) CGFloat centerY;
@property(nonatomic, assign) CGSize size;
@property(nonatomic, assign) CGPoint origin;

/*!
 *  @brief  设置视图圆角
 */
- (void)setCornerRadius:(CGFloat)cornerRadius;
/*!
 *  @brief  设置边框
 */
- (void)setBorderWidth:(CGFloat)borderWidth;
/*!
 *  @brief  设置边框颜色
 */
- (void)setBorderColor:(UIColor *)borderColor;

/**
 *  @brief  移除所有子视图
 */
- (void)removeAllSubviews;

/**
 *  @brief 获取viewcontroller
 */
- (UIViewController *)viewController;
@end
