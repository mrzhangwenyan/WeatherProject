//
//  WeatherView.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/11.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherModel.h"

@interface WeatherView : UIView
@property (nonatomic, strong)WeatherModel *model;
@property (nonatomic, strong)UICollectionView *collectionView;
@end
