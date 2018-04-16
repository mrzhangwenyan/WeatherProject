//
//  SharedBtnAction.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/16.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "SharedBtnAction.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>

@implementation SharedBtnAction
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static SharedBtnAction *instance;
    dispatch_once(&onceToken, ^{
        instance = [[SharedBtnAction alloc] init];
    });
    return instance;
}
- (void)sharedBtnRespond:(UIButton *)button {
    switch (button.tag) {
        case 101:
        [self wechatFriend];
        break;
        case 102:
        [self wechatCircle];
        break;
        case 103:
        [self weibo];
        break;
        case 104:
        [self qq];
        break;
        default:
        break;
    }
}
/// 微信好友
- (void)wechatFriend {
    NSLog(@"微信好友");
}
/// 微信朋友圈
- (void)wechatCircle {
    NSLog(@"微信朋友圈");
}
/// 新浪微博
- (void)weibo {
    NSLog(@"新浪微博");
}
/// QQ
- (void)qq {
    NSLog(@"QQ");
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"分享内容" images:nil url:nil title:@"分享标题" type:SSDKContentTypeText];
    [shareParams SSDKEnableUseClientShare];
    __weak typeof(self) weakSelf = self;
    [ShareSDK share:SSDKPlatformTypeQQ parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        switch (state) {
            case SSDKResponseStateSuccess:
            weakSelf.block(@"分享成功");
            break;
            case SSDKResponseStateFail:
            weakSelf.block(@"分享失败");
            default:
            break;
        }
    }];
}
@end





















