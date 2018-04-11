//
//  UILabel+ZZExtra.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/10.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ZZExtra)
- (void)widthToFit;
+ (UILabel *)labelWithTitle:(NSString *)title fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor;
@end
