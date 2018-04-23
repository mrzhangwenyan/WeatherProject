//
//  MoreCityView.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/23.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "MoreCityView.h"

@implementation MoreCityView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"更多国内城市" forState:UIControlStateNormal];
    [button setTitleColor:CustomBlack forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button sizeToFit];
    button.centerX = self.centerX;
    button.centerY = self.centerY;
    [button addTarget:self action:@selector(btnClickAction) forControlEvents:UIControlEventTouchUpInside];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-1, SCREENWIDTH, 1)];
    lineView.backgroundColor = [CustomGray colorWithAlphaComponent:0.2];
    [self addSubview:lineView];
    [self addSubview:button];
}
- (void)btnClickAction {
    if (_block) {
        _block();
    }
}

@end
