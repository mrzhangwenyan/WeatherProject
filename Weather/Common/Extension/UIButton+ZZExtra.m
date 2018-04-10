//
//  UIButton+ZZExtra.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/10.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "UIButton+ZZExtra.h"
#import <objc/runtime.h>

/**
 *  @brief add action callback to uibutton
 */
@interface UIButton (ZZAddCallBackBlock)
- (void)setZZCallBack: (ZZButtonActionCallBack)callBack;
- (ZZButtonActionCallBack)zZCallBack;
@end

@implementation UIButton (ZZAddCallBackBlock)
static ZZButtonActionCallBack _callBack;
- (void)setZZCallBack:(ZZButtonActionCallBack)callBack {
    objc_setAssociatedObject(self, &_callBack, callBack, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(ZZButtonActionCallBack)zZCallBack {
    return (ZZButtonActionCallBack)objc_getAssociatedObject(self, &_callBack);
}

@end;

/// 默认的按钮点击时间
static const NSTimeInterval defaultDuration = 0.5f;
@implementation UIButton (ZZExtra)
/**
 *  @brief replace the method 'addTarget:forControlEvents:'
 *  @warning executed this method, the property 'enabled' is 'NO'
 */
- (void)addZZCallBackAction:(ZZButtonActionCallBack)callBack forControlEvents:(UIControlEvents)controlEvents {
    self.zZCallBack = callBack;
    [self addTarget:self action:@selector(zzButtonAction:) forControlEvents:controlEvents];
}
- (void)zzButtonAction:(UIButton *)btn{
    self.zZCallBack(btn);
}
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selA = @selector(sendAction:to:forEvent:);
        SEL selB = @selector(mySendAction:to:forEvent:);
        Method methodA = class_getClassMethod(self, selA);
        Method methodB = class_getClassMethod(self, selB);
        //将 methodB的实现 添加到系统方法中 也就是说 将 methodA方法指针添加成 方法methodB的  返回值表示是否添加成功
        BOOL isAdd = class_addMethod(self, selA, method_getImplementation(methodB), method_getTypeEncoding(methodB));
        if (isAdd) {
            class_replaceMethod(self, selB, method_getImplementation(methodA), method_getTypeEncoding(methodA));
        }else {
            //添加失败了 说明本类中 有methodB的实现，此时只需要将 methodA和methodB的IMP互换一下即可。
            method_exchangeImplementations(methodA, methodB);
        }
    });
}
- (NSTimeInterval)timeInterval {
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}
- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    objc_setAssociatedObject(self, @selector(timeInterval), @(timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//当我们按钮点击事件 sendAction 时  将会执行  mySendAction
- (void)mySendAction: (SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (self.isIgnore) {
        /// 不需要被hook
        [self mySendAction:action to:target forEvent:event];
        return;
    }
    if ([NSStringFromClass(self.class) isEqualToString:@"UIButton"]) {
        self.timeInterval = self.timeInterval == 0 ? defaultDuration : self.timeInterval;
        if (self.isIgnoreEvent) {
            return;
        }else if (self.timeInterval > 0) {
            [self performSelector: @selector(resetState) withObject:nil afterDelay:self.timeInterval];
        }
    }
    //此处 methodA和methodB方法IMP互换了，实际上执行 sendAction；所以不会死循环
    self.isIgnoreEvent = YES;
    [self mySendAction:action to:target forEvent:event];
}
/// runtime动态绑定 属性
- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent {
    // 注意BOOL类型 需要用OBJC_ASSOCIATION_RETAIN_NONATOMIC 不要用错，否则set方法会赋值出错
    objc_setAssociatedObject(self, @selector(isIgnoreEvent), @(isIgnoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isIgnoreEvent {
    //_cmd == @select(isIgnoreEvent); 和set方法里一致
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setIsIgnore:(BOOL)isIgnore {
    // 注意BOOL类型 需要用OBJC_ASSOCIATION_RETAIN_NONATOMIC 不要用错，否则set方法会赋值出错
    objc_setAssociatedObject(self, @selector(isIgnore), @(isIgnore), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isIgnore {
    //_cmd == @select(isIgnore); 和set方法里一致
    return objc_getAssociatedObject(self, _cmd);
}
- (void)resetState {
    [self setIsIgnoreEvent:NO];
}
@end















































