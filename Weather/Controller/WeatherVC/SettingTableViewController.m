//
//  SettingTableViewController.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/19.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "SettingTableViewController.h"
#import "SharedView.h"
#import "SharedBtnAction.h"
#import "AboutUSViewController.h"

@interface SettingTableViewController ()
@property (nonatomic, strong)SharedView *sharedView;
@property (nonatomic, strong)UIView *shadeView;
@property (nonatomic, strong)AboutUSViewController *aboutVC;
@end


@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"identifier"];
    self.tableView.tableFooterView = [[UIView alloc] init];
}
- (AboutUSViewController *)aboutVC {
    if (!_aboutVC) {
        _aboutVC = [[AboutUSViewController alloc] init];
    }
    return _aboutVC;
}
- (UIView *)shadeView {
    if(!_shadeView) {
        _shadeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _shadeView.backgroundColor = [[UIColor brownColor] colorWithAlphaComponent:0.1];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelSharedView)];
        [_shadeView addGestureRecognizer:tap];
    }
    return _shadeView;
}

- (SharedView *)sharedView {
    if (!_sharedView) {
        
        CGFloat height = (SCREENWIDTH / 4) + 40;
        _sharedView = [[SharedView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, height)];
        _sharedView.backgroundColor = [UIColor whiteColor];
        __weak typeof(self) weakSelf = self;
        _sharedView.cancelBlock = ^{
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.sharedView.top = SCREENHEIGHT;
                [weakSelf.shadeView removeFromSuperview];
            } completion:nil];
        };
        [_sharedView setCallBack:^(UIButton *button) {
            [weakSelf performSelector:@selector(cancelSharedView) withObject:nil afterDelay:0.5];
            [[SharedBtnAction sharedInstance] sharedBtnRespond:button];
        }];
    }
    return _sharedView;
}
- (void)addShadeViewToWindow {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self.shadeView];
    [window addSubview:self.sharedView];
    [self.sharedView bringSubviewToFront:self.shadeView];
}
- (void)cancelSharedView {
    [UIView animateWithDuration:0.5 animations:^{
        self.sharedView.top = SCREENHEIGHT;
        [self.shadeView removeFromSuperview];
    } completion:nil];
}
/// 分享
- (void)sharedAction {
    [SharedBtnAction sharedInstance].tableView = self.weatherTabelView;
    [self addShadeViewToWindow];
    CGFloat height = (SCREENWIDTH / 4) + 40;
    CGFloat Y = SCREENHEIGHT-height;
    [UIView animateWithDuration:0.5 animations:^{
        self.sharedView.top = Y;
    }];
}
- (void)shareSuccess {
    [[SharedBtnAction sharedInstance] setBlock:^(NSString *title,BOOL isInstall) {
        NSString *message = nil;
        if (isInstall) {
            if ([title isEqualToString:@"分享成功"]) {
                message = @"成功";
            }else {
                message = @"失败";
            }
        }else {
            message = @"去AppStore下载";
        }
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:sure];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString *imageName = nil;
    NSString *title = nil;
    switch (indexPath.row) {
        case 0:
            imageName = @"settingComment";
            title = @"AppStore评论";
            break;
        case 1:
            imageName = @"settingAbout";
            title = @"关于我们";
            break;
        case 2:
            imageName = @"settingShare";
            title = @"分享";
            break;
        default:
            break;
    }
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsZero;
    UIImage *image = [UIImage imageNamed:imageName];
    CGSize imageSize = CGSizeMake(25, 25);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, imageSize.width, imageSize.height);
    [image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    cell.textLabel.text = title;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            NSLog(@"AppStore评论");
            break;
        case 1:
            [self.navigationController pushViewController:self.aboutVC animated:YES];
            break;
        case 2:
            [self sharedAction];
            break;
        default:
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

@end






















