//
//  UIButton+ZZExtra.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/10.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    /// 图片在左，文字在右
    ZZImagePositionStyleDefault,
    /// 图片在右，文字在左
    ZZImagePositionStyleRight,
    /// 图片在上，文字在下
    ZZImagePositionStyleTop,
    /// 图片在下，文字在上
    ZZImagePositionStyleBottom,
} ZZImagePositionStyle;

typedef void(^ZZCountdownCompletionBlock)(void);
@interface UIButton (ZZExtra)

+ (UIButton *)buttonWithImageName: (NSString *)imageName title: (NSString *)title;
/**
 *  设置图片与文字样式
 *
 *  @param imagePositionStyle     图片位置样式
 *  @param spacing                图片与文字之间的间距
 */
- (void)ZZ_imagePositionStyle:(ZZImagePositionStyle)imagePositionStyle spacing:(CGFloat)spacing;

/**
 *  设置图片与文字样式（推荐使用）
 *
 *  @param imagePositionStyle     图片位置样式
 *  @param spacing                图片与文字之间的间距
 *  @param imagePositionBlock     在此 Block 中设置按钮的图片、文字以及 contentHorizontalAlignment 属性
 */
- (void)ZZ_imagePositionStyle:(ZZImagePositionStyle)imagePositionStyle spacing:(CGFloat)spacing imagePositionBlock:(void (^)(UIButton *button))imagePositionBlock;

/** 倒计时，s倒计 */
- (void)ZZ_countdownWithSec:(NSInteger)time;
/** 倒计时，s倒计,带有回调 */
- (void)ZZ_countdownWithSec:(NSInteger)sec completion:(ZZCountdownCompletionBlock)block;


@end

//typedef void(^ZZButtonActionCallBack)(UIButton *button);
//
//@interface UIButton (ZZExtra)
///// bool 类型YES不允许点击 NO允许点击 设置是否执行点UI方法
//@property(nonatomic, assign) BOOL isIgnoreEvent;
///// 设置点击时间间隔
//@property(nonatomic, assign) NSTimeInterval timeInterval;
///// 用于设置单个按钮不需要被Hook
//@property(nonatomic, assign) BOOL isIgnore;
///**
// *  @brief replace the method 'addTarget:forControlEvents:'
// *  @warning executed this method, the property 'enabled' is 'NO'
// */
//- (void)addZZCallBackAction:(ZZButtonActionCallBack)callBack forControlEvents:(UIControlEvents)controlEvents;
//@end
