//
//  AboutUSViewController.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/19.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "AboutUSViewController.h"
#import "AboutUSView.h"

@interface AboutUSViewController ()
@property (nonatomic, strong)AboutUSView *showView;

@end

@implementation AboutUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"关于我们";
    [self.view addSubview:self.showView];
}
- (AboutUSView *)showView {
    if (!_showView) {
        _showView = [[AboutUSView alloc] initWithFrame:CGRectMake(0, 150, SCREENWIDTH, 230)];
    }
    return _showView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
