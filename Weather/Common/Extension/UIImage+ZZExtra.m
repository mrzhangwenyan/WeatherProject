//
//  UIImage+ZZExtra.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/17.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "UIImage+ZZExtra.h"

@implementation UIImage (ZZExtra)
+ (UIImage *)screenCaptureShareWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
