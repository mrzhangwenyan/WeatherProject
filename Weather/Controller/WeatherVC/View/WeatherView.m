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
#import "TodayWeatherView.h"

@interface WeatherView()<UICollectionViewDataSource>

@property(nonatomic, strong)UIImageView *windImgView;
@property(nonatomic, strong)UIImageView *airQualityImgView;
@property(nonatomic, strong)UIImageView *humidityImgView;
@property(nonatomic, strong)UILabel *cityNameLabel;
@property(nonatomic, strong)UILabel *windLabel;
@property(nonatomic, strong)UILabel *airConditionLabel;
@property(nonatomic, strong)UILabel *humidityLabel;
@property(nonatomic, strong)UIView  *lineView;
@property(nonatomic, strong)UIView  *lineBottomView;
@property(nonatomic, strong)TodayWeatherView *todayView;
@property(nonatomic, strong)TodayWeatherView *tomorrowView;
@property(nonatomic, assign)BOOL isHideDashedLine;
@end

@implementation WeatherView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUserInteractionEnabled:YES];
        [self creatUI];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)creatUI {
    /// 默认
    _isHideDashedLine = YES;
    _windImgView = [UIImageView imageViewWithName:@"windSpeed"];
    _airQualityImgView = [UIImageView imageViewWithName:@"airQuality"];
    _humidityImgView = [UIImageView imageViewWithName:@"humidity"];
    
    _cityNameLabel = [UILabel labelWithTitle:@"" fontSize:30 textColor:nil];
    _cityNameLabel.textColor = RGBCOLOR(0x773f07);
    
    _windLabel = [UILabel labelWithTitle:@"" fontSize:18 textColor:CustomBlack];
    _airConditionLabel = [UILabel labelWithTitle:@"" fontSize:18 textColor:CustomBlack];
    _humidityLabel = [UILabel labelWithTitle:@"" fontSize:18 textColor:CustomBlack];
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = CustomGray;
    _lineBottomView = [[UIView alloc] init];
    _lineBottomView.backgroundColor = CustomGray;
    
    /// UI布局第二版
    _todayView = [[TodayWeatherView alloc] initWithFrame:CGRectZero];
    _tomorrowView = [[TodayWeatherView alloc] initWithFrame:CGRectZero];
    
    [self addSubview:_todayView];
    [self addSubview:_tomorrowView];
    
    
    /// 添加到view上
    [self addSubview:_windImgView];
    [self addSubview:_airQualityImgView];
    [self addSubview:_humidityImgView];
    
    [self addSubview:_cityNameLabel];
    [self addSubview:_windLabel];
    [self addSubview:_airConditionLabel];
    [self addSubview:_humidityLabel];
    [self addSubview:_lineView];
    [self addSubview:_lineBottomView];
    [self addSubview:self.collectionView];
    [self makeConstraints];
    
}
- (UICollectionView *)collectionView {
    if(!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 1;
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.itemSize = CGSizeMake(100, 170);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[WeatherCollectionCell class] forCellWithReuseIdentifier:@"identifier"];
    }
    return _collectionView;
}
- (void)makeConstraints {
    
    [_cityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.centerX.equalTo(self);
    }];
    [_todayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self.cityNameLabel.mas_bottom).offset(20);
        make.height.equalTo(@230);
    }];
    [_tomorrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.todayView.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(@230);
    }];
    
    [_airQualityImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tomorrowView.mas_bottom);
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
        make.top.equalTo(self.airQualityImgView.mas_bottom).mas_offset(@10);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH, 1));
    }];
    [_lineBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH, 1));
    }];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@170);
    }];
}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (_isHideDashedLine) return;
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    /// 设置虚线颜色
    CGContextSetStrokeColorWithColor(currentContext, CustomGray.CGColor);
    /// 设置虚线宽度
    CGContextSetLineWidth(currentContext, 1);
    /// 设置虚线绘制起点
    CGContextMoveToPoint(currentContext, 0, CGRectGetMaxY(self.todayView.frame));
    /// 设置虚线绘制的终点
    CGContextAddLineToPoint(currentContext, SCREENWIDTH, CGRectGetMaxY(self.todayView.frame));
    //设置虚线排列的宽度间隔:下面的arr中的数字表示先绘制3个点再绘制1个点
    CGFloat arr[] = {3,1};
    //下面最后一个参数“2”代表排列的个数。
    CGContextSetLineDash(currentContext, 0, arr, 2);
    CGContextDrawPath(currentContext, kCGPathStroke);
}
- (void)setModel:(WeatherModel *)model {
    _model = model;
    _isHideDashedLine = NO;
    [self setNeedsDisplay];
    _cityNameLabel.text = model.city;
    _todayView.model = model.future.firstObject;
    _todayView.title = [NSString stringWithFormat:@"%@ %@",model.pollutionIndex,model.airCondition];
    _todayView.currenDayLabel.text = @"今天";
    _todayView.currenDayLabel.hidden = NO;
    
    _tomorrowView.model = model.future[1];
    _tomorrowView.pollutionLabel.hidden = YES;
    _tomorrowView.currenDayLabel.text = @"明天";
    _tomorrowView.currenDayLabel.hidden = NO;
    
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













































