//
//  UIImageView+ZZExtra.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/11.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "UIImageView+ZZExtra.h"

@implementation UIImageView (ZZExtra)

+ (UIImageView *)imageViewWithName:(NSString *)imageName {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.contentMode = UIViewContentModeScaleToFill;
    return imageView;
}
@end
