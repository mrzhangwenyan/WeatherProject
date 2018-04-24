//
//  ZZNavigationController.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/11.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "ZZNavigationController.h"

@interface ZZNavigationController ()

@end

@implementation ZZNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setTranslucent:YES];
    [[UINavigationBar appearance] setBarTintColor:CustomBlack];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:21], NSFontAttributeName, nil]];
//    UINavigationBar *bar = self.navigationBar;
//    [bar setTranslucent:YES];
//    bar.barTintColor = [UIColor lightGrayColor];
//    bar.tintColor = [UIColor whiteColor];
//    bar.titleTextAttributes = @{NSForegroundColorAttributeName :UIColor.whiteColor,
//                                NSFontAttributeName: [UIFont systemFontOfSize:18]
//                                };
    [UINavigationBar.appearance setBackIndicatorImage:[UIImage imageNamed:@"back"]];
    [UINavigationBar.appearance setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back"]];
    [UIBarButtonItem.appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(-600, 0) forBarMetrics:UIBarMetricsDefault];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
