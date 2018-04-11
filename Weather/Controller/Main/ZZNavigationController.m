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
    UINavigationBar *bar = self.navigationBar;
    [bar setTranslucent:NO];
    bar.barTintColor = [UIColor lightGrayColor];
    bar.tintColor = [UIColor whiteColor];
    bar.titleTextAttributes = @{NSForegroundColorAttributeName :UIColor.whiteColor,
                                NSFontAttributeName: [UIFont systemFontOfSize:18]
                                };
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
