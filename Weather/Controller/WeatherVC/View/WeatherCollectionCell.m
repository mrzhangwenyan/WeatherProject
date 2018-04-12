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
    _weekLabel = [UILabel labelWithTitle:@"星期一" fontSize:20 textColor:CustomGray];
    _temScopeLabel = [UILabel labelWithTitle:@"13°-23°" fontSize:15 textColor:CustomGray];
    
    [self addSubview:_weatherImgView];
    [self addSubview:_weekLabel];
    [self addSubview:_temScopeLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [_weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@25);
        make.centerX.equalTo(self);
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
    _weatherImgView.image = [NSString imageWithWeatherStr:model.dayTime];
    _temScopeLabel.text = model.temperature;
}
@end


































