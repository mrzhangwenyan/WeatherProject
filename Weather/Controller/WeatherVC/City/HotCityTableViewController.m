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
#import "HotCityTableViewCell.h"
#import "ProvinceTableViewController.h"
#import "WeatherViewController.h"

@interface HotCityTableViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic, strong)UIImageView *headerImgView;
@property (nonatomic, strong)UIView *headerView;
@property (nonatomic, strong)UIButton *backBtn;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)HotCityHeaderView *hotHeaderView;
@property (nonatomic, strong)MoreCityView *moreView;
@property (nonatomic, strong)ProvinceTableViewController *pronvinceVC;
@property (nonatomic, strong)UISearchBar *searchBar;
@end

@implementation HotCityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self createHeaderImgView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.searchBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
/// 搜索栏
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(35, 120, SCREENWIDTH-70, 40)];
        if (@available(iOS 11.0, *)) {
            CGFloat a = 44;
            [[_searchBar.heightAnchor constraintEqualToConstant:a] setActive:YES];
        }
        _searchBar.tintColor = CustomGray;
        _searchBar.backgroundColor = [UIColor clearColor];
        _searchBar.backgroundImage = [UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(1, 1)];
        UITextField *searchTF = [_searchBar valueForKey:@"searchField"];
        searchTF.backgroundColor = [UIColor whiteColor];
        searchTF.font = [UIFont systemFontOfSize:16];
        //        UIButton *clearBtn = [searchTF valueForKey:@"_clearButton"];
        //        [clearBtn addTarget:self action:@selector(clearBtnClick) forControlEvents:UIControlEventTouchUpInside];
        searchTF.clearButtonMode = UITextFieldViewModeAlways;
        _searchBar.placeholder = @"搜索城市";
        searchTF.layer.cornerRadius = 17;
        searchTF.layer.masksToBounds = YES;
        [_searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
        /// 设置取消的颜色和字体
        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:18],NSFontAttributeName, nil] forState:UIControlStateNormal];
        _searchBar.delegate = self;
    }
    return _searchBar;
}
- (ProvinceTableViewController *)pronvinceVC {
    if (!_pronvinceVC) {
        _pronvinceVC = [[ProvinceTableViewController alloc] init];
    }
    return _pronvinceVC;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 230, SCREENWIDTH, SCREENHEIGHT-230) style:UITableViewStyleGrouped];
        [_tableView registerClass:[HotCityTableViewCell class] forCellReuseIdentifier:@"identifier"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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
        __weak typeof(self) weakSelf = self;
        [_moreView setBlock:^{
            [weakSelf.navigationController pushViewController:weakSelf.pronvinceVC animated:YES];
        }];
    }
    return _moreView;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view endEditing:YES];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)createHeaderImgView {
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, SCREENWIDTH, 250)];
    self.headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 250)];
    self.headerImgView.image = [UIImage imageNamed:@"background"];
    self.headerImgView.userInteractionEnabled = YES;
    [_headerView addSubview:self.headerImgView];
    self.backBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 40, 40, 40)];
    self.backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:self.backBtn];
    [self.view addSubview:_headerView];
}
- (void)headerImgViewMoveUp {
    [UIView animateWithDuration: 0.5 animations:^{
        self.headerView.height = 150;
        self.headerImgView.height = 150;
        
        self.tableView.height = SCREENHEIGHT-130;
        self.tableView.top = 130;
        self.searchBar.top = 60;
    }];
}
- (void)headerImgViewMoveDown {
    
}
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HotCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
    [cell setBlock:^(NSString *cityName) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"districtName" object:nil userInfo:@{@"name":cityName}];
        [self.navigationController setNavigationBarHidden:NO];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsZero;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 321;
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

#pragma mark UISearchBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    ZZLog(@"cancelBtn");
    self.searchBar.text = @"";
    [self.searchBar setShowsCancelButton:YES animated:NO];
    [self.searchBar resignFirstResponder];
    /// 处理结束搜索的事情
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:YES animated:YES];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    if ([self.searchBar.text isEqualToString:@""]) {
        [self.searchBar setShowsCancelButton:YES animated:NO];
    }else {
        [self.searchBar setShowsCancelButton:YES animated:YES];
    }
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    /// 处理搜索事情
}
@end




































