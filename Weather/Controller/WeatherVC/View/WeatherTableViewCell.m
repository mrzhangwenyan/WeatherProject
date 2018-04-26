//
//  WeatherTableViewCell.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/16.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "WeatherTableViewCell.h"

@interface WeatherTableViewCell()

@end

@implementation WeatherTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _promptLabel = [UILabel labelWithTitle:@"" fontSize:12 textColor:CustomBlack];
    _dataShowLabel = [UILabel labelWithTitle:@"" fontSize:16 textColor:CustomBlack];
    
    [self.contentView addSubview:_promptLabel];
    [self.contentView addSubview:_dataShowLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [_promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(@20);
        make.top.equalTo(self).mas_offset(@7);
    }];
    [_dataShowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.promptLabel);
        make.top.mas_equalTo(self.promptLabel.mas_bottom).mas_offset(@5);
    }];
    self.textLabel.height = self.height - 2;
}
// 自绘分割线
//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
//    CGContextFillRect(context, rect);
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0xE2/255.0f green:0xE2/255.0f blue:0xE2/255.0f alpha:1].CGColor);
//    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - 1, rect.size.width, 1));
//}
//- (void)setFrame:(CGRect)frame {
//    frame.size.height -= 1;
//    [super setFrame:frame];
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self createUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
