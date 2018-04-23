//
//  SearchCityTableViewController.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/20.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^callBlock)(NSString *cityName);
@interface SearchCityTableViewController : UITableViewController
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, copy)callBlock block;
@end
