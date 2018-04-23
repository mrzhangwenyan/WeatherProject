//
//  HotCityView.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/23.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "HotCityHeaderView.h"

@implementation HotCityHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI {
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 0, 0)];
    titleLable.textColor = CustomBlack;
    titleLable.text = @"国内热门城市";
    titleLable.font = [UIFont systemFontOfSize:16];
    titleLable.textAlignment = NSTextAlignmentLeft;
    [titleLable sizeToFit];
    titleLable.centerY = self.centerY;
    [self addSubview:titleLable];
}

@end
