//
//  HotCollectionViewCell.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/23.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "HotCollectionViewCell.h"
@interface HotCollectionViewCell()

@end

@implementation HotCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)createUI {
    self.textLabel = [UILabel labelWithTitle:@"" fontSize:14 textColor:CustomBlack];
    [self.contentView addSubview:self.textLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self);
    }];
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.textLabel.text = title;
}
@end
