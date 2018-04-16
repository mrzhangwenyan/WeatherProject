//
//  SharedView.h
//  Weather
//
//  Created by zhangwenyan on 2018/4/13.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^SharedBtnBlock)(UIButton *button);
typedef void(^CancelBlock)(void);
@interface SharedView : UIView
@property (nonatomic ,copy)SharedBtnBlock callBack;
@property (nonatomic, copy)CancelBlock cancelBlock;
@end
