//
//  UILabel+ZZExtra.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/10.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "UILabel+ZZExtra.h"
#import "UIView+ZZExtra.h"

@implementation UILabel (ZZExtra)
- (void)widthToFit {
    UILabel *label = [[UILabel alloc] initWithFrame:self.frame];
    label.text = self.text;
    label.font = self.font;
    [label sizeToFit];
    self.width = label.width;
}
+ (UILabel *)labelWithTitle:(NSString *)title fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor {
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = textColor;
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    return  label;
}
@end
