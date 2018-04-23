//
//  CityTableViewController.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/23.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProvinceModel.h"

@interface CityTableViewController : UITableViewController
@property(nonatomic, strong)NSArray<NSString *> *cityDataSource;
@property(nonatomic, strong)NSArray<ProvinceModel *> *model;
@end
