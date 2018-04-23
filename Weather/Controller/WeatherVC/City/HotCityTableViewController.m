//
//  HotCityTableViewController.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/20.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "HotCityTableViewController.h"
#import "HotCityHeaderView.h"
#import "MoreCityView.h"

@interface HotCityTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UIImageView *headerImgView;
@property (nonatomic, strong)UIButton *backBtn;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)HotCityHeaderView *hotHeaderView;
@property (nonatomic, strong)MoreCityView *moreView;
@end

@implementation HotCityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self createHeaderImgView];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 230, SCREENWIDTH, SCREENHEIGHT-230) style:UITableViewStyleGrouped];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"identifier"];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (HotCityHeaderView *)hotHeaderView {
    if (!_hotHeaderView) {
        _hotHeaderView = [[HotCityHeaderView alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    }
    return _hotHeaderView;
}
- (MoreCityView *)moreView {
    if (!_moreView) {
        _moreView = [[MoreCityView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
    }
    return _moreView;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)createHeaderImgView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, SCREENWIDTH, 250)];
    self.headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 250)];
    self.headerImgView.image = [UIImage imageNamed:@"background"];
    [headerView addSubview:self.headerImgView];
    self.backBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 40, 40, 40)];
    self.backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.backBtn];
    [self.view addSubview:headerView];
}
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view data source
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat y = scrollView.contentOffset.y;
//    if (y < 0) {
//        CGFloat totalOffset = 200 + ABS(y);
//        CGFloat f = totalOffset / 200;
//        self.headerImgView.frame = CGRectMake(-(SCREENWIDTH*f - SCREENWIDTH)/2, y, SCREENWIDTH*f, totalOffset);
//    }
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
    cell.textLabel.text = @"ues";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.hotHeaderView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return self.moreView;
}
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
//    if ([view isMemberOfClass:[UITableViewHeaderFooterView class]]) {
//        ((UITableViewHeaderFooterView *)view).backgroundView.backgroundColor = [UIColor whiteColor];;
//    }
//}
@end




































