//
//  WeatherCollectionCell.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/11.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "WeatherCollectionCell.h"

@interface WeatherCollectionCell()
@property(nonatomic, strong)UIImageView *weatherImgView;
@property(nonatomic, strong)UILabel *weekLabel;
@property(nonatomic, strong)UILabel *temScopeLabel;
@property(nonatomic, strong)UILabel *dateLabel;
@end

@implementation WeatherCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self creatUI];
    }
    return  self;
}
- (void)creatUI{
    _weatherImgView = [UIImageView imageViewWithName:@"cloud"];
    _weekLabel = [UILabel labelWithTitle:@"" fontSize:20 textColor:CustomBlack];
    _temScopeLabel = [UILabel labelWithTitle:@"" fontSize:15 textColor:CustomBlack];
    _dateLabel = [UILabel labelWithTitle:@"" fontSize:15 textColor:CustomGray];
    
    [self addSubview:_weatherImgView];
    [self addSubview:_weekLabel];
    [self addSubview:_temScopeLabel];
    [self addSubview:_dateLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [_weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@25);
        make.centerX.equalTo(self);
    }];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.weekLabel.mas_bottom).offset(4);
        make.centerX.equalTo(self.weekLabel);
    }];
    [_weatherImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).mas_offset(@-3);
        make.top.equalTo(self.weekLabel.mas_bottom).mas_offset(@37);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
    [_temScopeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.weatherImgView.mas_bottom).mas_offset(@30);
    }];
}
- (void)setModel:(FutureModel *)model {
    _model = model;
    _weekLabel.text = model.week;
    _dateLabel.text = model.date;
    _weatherImgView.image = [NSString imageWithWeatherStr:model.dayTime];
    _temScopeLabel.text = model.temperature;
}
@end


































