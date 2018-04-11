//
//  CityGroupTableViewController.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/11.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityGroup.h"
typedef void (^myBlock)(NSString *cityName);
@interface CityGroupTableViewController : UITableViewController

/// block传值
@property(nonatomic, copy)myBlock block;
@end
