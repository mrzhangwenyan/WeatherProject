//
//  JxbScaleButton.m
//  JxbScaleButton
//
//  Created by Peter on 15/8/7.
//  Copyright (c) 2015年 Peter. All rights reserved.
//

#import "JxbScaleButton.h"

@implementation JxbScaleSetting
@end

@implementation JxbScaleButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)scale:(JxbScaleSetting*)setting {
    self.titleLabel.transform = CGAffineTransformMakeScale(1, 1);
    self.titleLabel.alpha     = 1;
    [self setTitleColor:setting.colorTitle ? setting.colorTitle : [UIColor blackColor] forState:UIControlStateNormal];
    [self setTitleColor:setting.colorTitle ? setting.colorTitle : [UIColor blackColor] forState:UIControlStateDisabled];
    /// 倒计时60s
    if (setting.indexStart > 0)
    {
        self.backgroundColor = setting.colorDisable ? setting.colorDisable : [UIColor whiteColor];
//        [self setEnabled:NO];
        /// 用户交互关闭
        self.userInteractionEnabled = NO;
        NSString* title = [NSString stringWithFormat:@"   %@%d%@   ",(setting.strPrefix ? setting.strPrefix : @""),setting.indexStart,(setting.strSuffix ? setting.strSuffix : @"")];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateDisabled];
        /// 防止循环引用
        __weak typeof (self) wSelf = self;
        /// 动画效果
        [UIView animateWithDuration:1 animations:^{
            self.titleLabel.transform = CGAffineTransformMakeScale(1.01, 1.01);
//            self.titleLabel.alpha     = 0.0;
        } completion:^(BOOL b){
            setting.indexStart--;
            [wSelf scale:setting];
        }];
    }
    else {
        self.backgroundColor = setting.colorCommon ? setting.colorCommon : [UIColor clearColor];
//        [self setEnabled:YES];
        /// 用户交互打开
        self.userInteractionEnabled = YES;
        [self setTitle:setting.strCommon forState:UIControlStateNormal];
    }
}

#pragma mark - 启动函数
- (void)startWithSetting:(JxbScaleSetting *)setting {
    [self scale:setting];
}

@end
