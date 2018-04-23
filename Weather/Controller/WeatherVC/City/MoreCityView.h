//
//  MoreCityView.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/23.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^callBack)(void);

@interface MoreCityView : UIView
@property (nonatomic, copy)callBack block;
@end
