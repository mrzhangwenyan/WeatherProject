//
//  SearchTableView.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/12.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZZCityNameDelegate <NSObject>
- (void) searchTableViewDidSelectedWithName: (NSString *)cityName;
@end

@interface SearchTableView : UIView
@property (nonatomic, strong)NSArray *cityNameArr;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, weak)id<ZZCityNameDelegate> delegate;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, assign) BOOL isHidden;
@end
