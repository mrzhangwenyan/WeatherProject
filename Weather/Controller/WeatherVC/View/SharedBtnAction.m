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
    
    UIImage *image = [self saveLongImage:self.tableView];
    [self sharePlatform:SSDKPlatformSubTypeWechatSession image:image];
}
/// 微信朋友圈
- (void)wechatCircle {
    
    UIImage *image = [self saveLongImage:self.tableView];
    [self sharePlatform:SSDKPlatformSubTypeWechatTimeline image:image];
}
/// 新浪微博
- (void)weibo {
    
    UIImage *image = [self saveLongImage:self.tableView];
    [self sharePlatform:SSDKPlatformTypeSinaWeibo image:image];
}
/// QQ
- (void)qq {
    
    UIImage *image = [self saveLongImage:self.tableView];
    [self sharePlatform:SSDKPlatformTypeQQ image:image];
}
- (void)sharePlatform:(SSDKPlatformType)platform image:(UIImage *)image {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters SSDKSetupShareParamsByText:@"天气预报" images:image url:nil title:@"目前天气" type:SSDKContentTypeImage];
    __weak typeof (self)weakSelf = self;
    [ShareSDK share:platform parameters:parameters onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        switch (state) {
            case SSDKResponseStateSuccess:
            weakSelf.block(@"分享成功");
            break;
            case SSDKResponseStateFail:
            weakSelf.block(@"分享失败");
            break;
            default:
            break;
        }
    }];
}
- (UIImage *)saveLongImage:(UITableView *)table {
    UIImage *image = nil;
    UIGraphicsBeginImageContextWithOptions(table.contentSize, YES, [UIScreen mainScreen].scale);
    CGPoint saveContentOffset = table.contentOffset;
    CGRect saveFrame = table.frame;
    table.contentOffset = CGPointZero;
    table.frame = CGRectMake(0, 0, table.contentSize.width, table.contentSize.height);
    [table.layer renderInContext:UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    table.contentOffset = saveContentOffset;
    table.frame = saveFrame;
    UIGraphicsEndImageContext();
    if(image != nil) {
        return image;
// UIImageWriteToSavedPhotosAlbum(image,self,@selector(image:didFinishSavingWithError:contextInfo:),NULL);
    }
    return nil;
}
// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void*) contextInfo{
    if(error != NULL){
        NSLog(@"保存图片失败");
    }else{
        NSLog(@"保存图片成功");
    }
}
@end





















