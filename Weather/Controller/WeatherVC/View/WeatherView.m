//
//  WeatherView.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/11.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "WeatherView.h"
#import "UILabel+ZZExtra.h"
#import "UIImageView+ZZExtra.h"

@interface WeatherView()
@property(nonatomic, strong)UIImageView *weatherImgView;
@property(nonatomic, strong)UIImageView *windImgView;
@property(nonatomic, strong)UIImageView *airQualityImgView;
@property(nonatomic, strong)UIImageView *humidityImgView;
@property(nonatomic, strong)UILabel *cityNameLabel;
@property(nonatomic, strong)UILabel *weatherLabel;
@property(nonatomic, strong)UIButton *temperatureBtn;
@property(nonatomic, strong)UILabel *dateLabel;
@property(nonatomic, strong)UILabel *windLabel;
@property(nonatomic, strong)UILabel *airConditionLabel;
@property(nonatomic, strong)UILabel *humidityLabel;
@property(nonatomic, strong)UIView  *lineView;
@end

@implementation WeatherView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUserInteractionEnabled:NO];
        [self creatUI];
    }
    return self;
}
- (void)creatUI {
    /// 默认
    _weatherImgView = [UIImageView imageViewWithName:@"sun_b"];
    _windImgView = [UIImageView imageViewWithName:@"windspeed"];
    _airQualityImgView = [UIImageView imageViewWithName:@"ok"];
    _humidityImgView = [UIImageView imageViewWithName:@"shidu"];
    
    _cityNameLabel = [UILabel labelWithTitle:@"上海" fontSize:18 textColor:CustomDark];
    _weatherLabel = [UILabel labelWithTitle:@"晴天" fontSize:15 textColor:CustomGray];
    
    _temperatureBtn = [[UIButton alloc] init];
    _temperatureBtn.userInteractionEnabled = NO;
    [_temperatureBtn setTitle:@"23" forState:UIControlStateNormal];
    [_temperatureBtn setTitleColor:CustomGray forState:UIControlStateNormal];
    _temperatureBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _temperatureBtn.titleLabel.font = [UIFont fontWithName:@"Heiti SC" size:180];
    _temperatureBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, -40, 0);
    
    _dateLabel = [UILabel labelWithTitle:@"2018-4-11 12:38:03发布" fontSize:16 textColor:CustomGray];
    _windLabel = [UILabel labelWithTitle:@"4级" fontSize:14 textColor:CustomGray];
    _airConditionLabel = [UILabel labelWithTitle:@"良好" fontSize:14 textColor:CustomGray];
    _humidityLabel = [UILabel labelWithTitle:@"25" fontSize:14 textColor:CustomGray];
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = CustomGray;
    
    /// 添加到view上
    [self addSubview:_weatherImgView];
    [self addSubview:_windImgView];
    [self addSubview:_airQualityImgView];
    [self addSubview:_humidityImgView];
    
    [self addSubview:_cityNameLabel];
    [self addSubview:_weatherLabel];
    [self addSubview:_temperatureBtn];
    [self addSubview:_dateLabel];
    [self addSubview:_windLabel];
    [self addSubview:_airConditionLabel];
    [self addSubview:_humidityLabel];
    [self addSubview:_lineView];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [_weatherImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.left.equalTo(@35);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_cityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.centerX.equalTo(self);
    }];
    [_weatherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cityNameLabel.mas_bottom).mas_offset(@15);
        make.centerX.equalTo(self);
    }];
    [_temperatureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.weatherLabel.mas_bottom).mas_offset(@50);
        make.size.mas_equalTo(CGSizeMake(220, 220));
    }];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.temperatureBtn.mas_bottom).mas_offset(@-5);
        make.centerX.equalTo(self);
    }];
    
    
    [_airQualityImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lineView.mas_top).mas_offset(@(-15));
        make.centerX.equalTo(self).mas_offset(@-15);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    [_airConditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.airQualityImgView);
        make.left.equalTo(self.airQualityImgView.mas_right).mas_offset(@6);
    }];
    [_windImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.airQualityImgView);
        make.right.equalTo(self.airQualityImgView.mas_left).mas_offset(@(-120));
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    [_windLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.windImgView);
        make.left.equalTo(self.windImgView.mas_right).mas_offset(@6);
    }];
    [_humidityImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.airQualityImgView);
        make.left.equalTo(self.airQualityImgView.mas_right).mas_offset(@120);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    [_humidityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.humidityImgView);
        make.left.equalTo(self.humidityImgView.mas_right).mas_offset(@6);
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH, 1));
    }];
}
@end













































