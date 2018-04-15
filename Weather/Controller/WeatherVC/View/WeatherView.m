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
#import "WeatherCollectionCell.h"

@interface WeatherView()<UICollectionViewDataSource>
@property(nonatomic, strong)UIImageView *weatherImgView;
@property(nonatomic, strong)UIImageView *windImgView;
@property(nonatomic, strong)UIImageView *airQualityImgView;
@property(nonatomic, strong)UIImageView *humidityImgView;
@property(nonatomic, strong)UILabel *cityNameLabel;
@property(nonatomic, strong)UILabel *weatherLabel;
@property(nonatomic, strong)UIButton *temperatureBtn;
@property(nonatomic, strong)UILabel *degreesLabel;
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
    
    _cityNameLabel = [UILabel labelWithTitle:@"上海" fontSize:30 textColor:CustomDark];
    _weatherLabel = [UILabel labelWithTitle:@"晴天" fontSize:20 textColor:CustomGray];
    
    _temperatureBtn = [[UIButton alloc] init];
    _temperatureBtn.userInteractionEnabled = NO;
    [_temperatureBtn setTitle:@"23" forState:UIControlStateNormal];
    [_temperatureBtn setTitleColor:CustomGray forState:UIControlStateNormal];
    _temperatureBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _temperatureBtn.titleLabel.font = [UIFont fontWithName:@"Heiti SC" size:180];
//    _temperatureBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, -10, 0);
    _degreesLabel = [UILabel labelWithTitle:@"℃" fontSize:30 textColor:CustomGray];
    
    _dateLabel = [UILabel labelWithTitle:@"2018-4-11 12:38:03发布" fontSize:16 textColor:CustomGray];
    _windLabel = [UILabel labelWithTitle:@"1级" fontSize:18 textColor:CustomGray];
    _airConditionLabel = [UILabel labelWithTitle:@"良好" fontSize:18 textColor:CustomGray];
    _humidityLabel = [UILabel labelWithTitle:@"25" fontSize:18 textColor:CustomGray];
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
    [self addSubview:_degreesLabel];
    [self addSubview:_dateLabel];
    [self addSubview:_windLabel];
    [self addSubview:_airConditionLabel];
    [self addSubview:_humidityLabel];
    [self addSubview:_lineView];
    [self addSubview:self.collectionView];
}
- (UICollectionView *)collectionView {
    if(!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 1;
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.itemSize = CGSizeMake(100, 250);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        /// CGRectMake(0, CGRectGetMaxY(_weatherView.frame), SCREENWIDTH, 250)
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        [_collectionView registerClass:[WeatherCollectionCell class] forCellWithReuseIdentifier:@"identifier"];
    }
    return _collectionView;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [_weatherImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.left.equalTo(@35);
        make.size.mas_equalTo(CGSizeMake(50, 50));
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
    [_degreesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.temperatureBtn.mas_top).mas_offset(@25);
        make.right.equalTo(self.temperatureBtn.mas_right).mas_offset(@10);
    }];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.temperatureBtn.mas_bottom).mas_offset(@-25);
        make.centerX.equalTo(self);
    }];
    
    
    [_airQualityImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lineView.mas_top).mas_offset(@(-15));
        make.centerX.equalTo(self).mas_offset(@-15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [_airConditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.airQualityImgView);
        make.left.equalTo(self.airQualityImgView.mas_right).mas_offset(@6);
    }];
    [_windImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.airQualityImgView);
        make.right.equalTo(self.airQualityImgView.mas_left).mas_offset(@(-100));
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [_windLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.windImgView);
        make.left.equalTo(self.windImgView.mas_right).mas_offset(@6);
    }];
    [_humidityImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.airQualityImgView);
        make.left.equalTo(self.airQualityImgView.mas_right).mas_offset(@100);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [_humidityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.humidityImgView);
        make.left.equalTo(self.humidityImgView.mas_right).mas_offset(@6);
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH, 1));
    }];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@250);
    }];
}
- (void)setModel:(WeatherModel *)model {
    _model = model;
    _cityNameLabel.text = model.city;
    _weatherLabel.text = model.weather;
    _weatherImgView.image = [NSString imageWithWeatherStr:model.weather];
    [_temperatureBtn setTitle:[NSString subStringFromString:model.temperature ByLoc:0 length:2] forState:UIControlStateNormal];
    NSString *publishStr = [NSString stringWithFormat:@"%@ %@发布",model.date,model.time];
    _dateLabel.text = publishStr;
    _windLabel.text = [model.wind substringFromIndex:model.wind.length -2];
    _airConditionLabel.text = model.airCondition;
    _humidityLabel.text = [model.humidity substringFromIndex:model.humidity.length - 3];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.future.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WeatherCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    cell.model = self.model.future[indexPath.row];
    return cell;
}
@end













































