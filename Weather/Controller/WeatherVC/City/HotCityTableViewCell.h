//
//  HotCityTableViewCell.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/23.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CallBack)(NSString *cityName);
@interface HotCityTableViewCell : UITableViewCell
@property (nonatomic, copy)CallBack block;
@end
