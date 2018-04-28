//
//  TodayWeatherView.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/28.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "TodayWeatherView.h"
@interface TodayWeatherView()
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UILabel *dateLabel;
@property (nonatomic, strong)UILabel *temperatureLabel;
@property (nonatomic, strong)UILabel *weatherLabel;
@property (nonatomic, assign)CGFloat width;

@end

@implementation TodayWeatherView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _imageView = [UIImageView imageViewWithName:@""];
    
    _currenDayLabel = [[UILabel alloc] init];
    _currenDayLabel.text = @"";
    _currenDayLabel.textAlignment = NSTextAlignmentCenter;
    _currenDayLabel.font = [UIFont systemFontOfSize:18];
    _currenDayLabel.textColor = [UIColor whiteColor];
    _currenDayLabel.layer.cornerRadius = 5;
    _currenDayLabel.layer.masksToBounds = YES;
    _currenDayLabel.backgroundColor = [[UIColor brownColor] colorWithAlphaComponent:0.4];
    _currenDayLabel.hidden = YES;
    
    _dateLabel = [UILabel labelWithTitle:@"" fontSize:18 textColor:CustomGray];
    
    _temperatureLabel = [UILabel labelWithTitle:@"" fontSize:0 textColor:RGBCOLOR(0x3d250d)];
    _temperatureLabel.font = [UIFont fontWithName:@"Heiti SC" size:28];
    _weatherLabel = [UILabel labelWithTitle:@"" fontSize:28 textColor:RGBCOLOR(0x3d250d)];

    _pollutionLabel = [[UILabel alloc] init];
    _pollutionLabel.backgroundColor = [UIColor colorWithRed:235/255.0 green:128/255.0 blue:42/255.0 alpha:1];
    _pollutionLabel.textAlignment = NSTextAlignmentCenter;
    _pollutionLabel.font = [UIFont systemFontOfSize:18];
    _pollutionLabel.textColor = [UIColor whiteColor];
    _pollutionLabel.layer.cornerRadius = 5;
    _pollutionLabel.layer.masksToBounds = YES;
    
    
    
    [self addSubview:self.imageView];
    [self addSubview:self.currenDayLabel];
    [self addSubview:self.dateLabel];
    [self addSubview:self.temperatureLabel];
    [self addSubview:self.weatherLabel];
    [self addSubview:self.pollutionLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(35);
        make.size.mas_equalTo(CGSizeMake(110, 110));
        make.top.equalTo(self).offset(35);
    }];
    [self.currenDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(35);
        make.left.equalTo(self.imageView.mas_right).offset(50);
        make.width.equalTo(@47);
        make.height.equalTo(@27);
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.currenDayLabel.mas_right).offset(3);
        make.centerY.equalTo(self.currenDayLabel);
    }];
    [self.temperatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.currenDayLabel.mas_left);
        make.top.equalTo(self.currenDayLabel.mas_bottom).offset(10);
    }];
    [self.weatherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.temperatureLabel.mas_left);
        make.top.equalTo(self.temperatureLabel.mas_bottom).offset(8);
    }];
    
}
- (void)setTitle:(NSString *)title {
    _title = title;
    _pollutionLabel.text = title;
    self.width = [title sizeWithMaxHeight:27 andFont:[UIFont systemFontOfSize:18]].width + 15;
    [self.pollutionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.temperatureLabel.mas_left);
        make.top.equalTo(self.weatherLabel.mas_bottom).offset(13);
        make.height.equalTo(@30);
        make.width.mas_equalTo(self.width);
    }];
}
- (void)setModel:(FutureModel *)model {
    _model = model;
    self.imageView.image = [NSString imageWithWeatherStr:model.dayTime];
    self.dateLabel.text = [NSString stringWithFormat:@"%@ %@",model.date,model.week];
    self.temperatureLabel.text = [model.temperature stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    if ([model.dayTime isEqualToString:model.night]) {
        self.weatherLabel.text = [NSString stringWithFormat:@"%@",model.dayTime];
    }
    else {
        self.weatherLabel.text = [NSString stringWithFormat:@"%@到%@",model.dayTime,model.night];
    }
}

@end












































