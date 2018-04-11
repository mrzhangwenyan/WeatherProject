//
//  ZZTabBarController.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/11.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "ZZTabBarController.h"
#import "ZZNavigationController.h"
#import "WeatherViewController.h"
#import "MailViewController.h"
#import "CookingViewController.h"
#import "NumQueryViewController.h"


@interface ZZTabBarController ()

@end

@implementation ZZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar setTintColor:[UIColor whiteColor]];
    [self.tabBar setBarTintColor:[UIColor lightGrayColor]];
    [self loadSubviewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 添加子控制器
 */
- (void)loadSubviewController {
    
    UIViewController *weatherVC = [self loadChildControllerWithVC:[[WeatherViewController alloc] init] withTitle:@"天气" withImageName:@"tab_recent_nor"];
    UIViewController *mailVC = [self loadChildControllerWithVC:[[MailViewController alloc] init] withTitle:@"邮箱" withImageName:@"tab_buddy_nor"];
    UIViewController *cookingVC = [self loadChildControllerWithVC:[[CookingViewController alloc] init] withTitle:@"菜谱" withImageName:@"tab_qworld_nor"];
    UIViewController *IphoneVC = [self loadChildControllerWithVC:[[NumQueryViewController alloc] init] withTitle:@"归属地" withImageName:@"tab_me_nor"];
    self.viewControllers = @[weatherVC,mailVC,cookingVC,IphoneVC];
}
/**
 创建子控制器 设置内容
 */
- (UIViewController *)loadChildControllerWithVC:(UIViewController *)VC withTitle: (NSString *)title withImageName:(NSString *)imageName {
    VC.title = title;
    VC.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ZZNavigationController *navVc = [[ZZNavigationController alloc] initWithRootViewController:VC];
    return navVc;
}
@end
