//
//  AppDelegate.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/9.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "AppDelegate.h"
#import "ZZTabBarController.h"
#import "WeatherViewController.h"
#import "ZZNavigationController.h"
#import "ZZLocalFile.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
#import "WeiboSDK.h"
#import "ZZUserDefaults.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    if ([self isFirstLaunch]) {
//        ZZLog(@"第一次启动");
//    }else {
//        ZZLog(@"不是第一次启动");
//    }
    /// 暂时
    [self registerShareSDK];
//    [[ZZLocalFile sharedLocalFile] netRequestWithCityName:@"上海"];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    ZZTabBarController *tabBarVC = [[ZZTabBarController alloc] init];
    WeatherViewController *weatherVC = [[WeatherViewController alloc] init];
    ZZNavigationController *nav = [[ZZNavigationController alloc] initWithRootViewController:weatherVC];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)registerShareSDK {
    
    [ShareSDK registerActivePlatforms:@[@(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ),
                                        @(SSDKPlatformTypeSinaWeibo)
                                        ] onImport:^(SSDKPlatformType platformType) {
                                            switch (platformType) {
                                                case SSDKPlatformTypeWechat:
                                                [ShareSDKConnector connectWeChat:[WXApi class]];
                                                break;
                                                case SSDKPlatformTypeQQ:
                                                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                                                break;
                                                case SSDKPlatformTypeSinaWeibo:
                                                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                                                break;
                                                default:
                                                break;
                                            }
                                        } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                                            switch (platformType) {
                                                case SSDKPlatformTypeWechat:
                                                [appInfo SSDKSetupWeChatByAppId:@"" appSecret:@"" backUnionID:NO];
                                                break;
                                                case SSDKPlatformTypeQQ:
                                                [appInfo SSDKSetupQQByAppId:@"1106772401" appKey:@"VnoGcA525qIMYYpd" authType:SSDKAuthTypeBoth useTIM:YES backUnionID:NO];
                                                break;
                                                case SSDKPlatformTypeSinaWeibo:
                                                [appInfo SSDKSetupSinaWeiboByAppKey:@"1126351654" appSecret:@"e55f4a70c8df001a0b248150616133fb" redirectUri:@"http://weibo.com" authType:SSDKAuthTypeBoth];
                                                break;
                                                default:
                                                break;
                                            }
                                        }];
}
- (BOOL)isFirstLaunch {
    NSString *key = (NSString *)kCFBundleVersionKey;
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    NSString *saveVersion = [ZZUserDefaults objectForKey:key];
    if ([version isEqualToString:saveVersion]) {
        return NO;
    }else {
        [ZZUserDefaults setObject:version forKey:key];
        return YES;
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
