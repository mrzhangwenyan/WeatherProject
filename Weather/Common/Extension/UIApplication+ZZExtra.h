//
//  UIApplication+ZZExtra.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/10.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (ZZExtra)
/// "Documents" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL    *documentsURL;
@property (nonatomic, readonly) NSString *documentsPath;

/// "Caches" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL    *cachesURL;
@property (nonatomic, readonly) NSString *cachesPath;

/// "Library" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL    *libraryURL;
@property (nonatomic, readonly) NSString *libraryPath;
@end
