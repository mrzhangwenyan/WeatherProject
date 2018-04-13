//
//  CityGroupTableViewController.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/11.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "CityGroupTableViewController.h"
#import <IQKeyboardManager.h>
#import "SearchTableView.h"

@interface CityGroupTableViewController ()<UISearchBarDelegate,ZZCityNameDelegate>
@property (nonatomic, strong)NSArray *cityGroupArray;
@property (nonatomic, strong)UISearchBar *searchBar;
@property (nonatomic, strong)UIView *shadeView;
@property (nonatomic, strong)SearchTableView *searchTableView;

/// 搜索数组
@property (nonatomic, strong)NSMutableArray *searchResultArray;
/// 所有的城市数组
@property (nonatomic, strong)NSMutableArray *cityArray;
@end

@implementation CityGroupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(clickBackItem)];
    self.navigationItem.leftBarButtonItem = backItem;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"identifier"];
    self.navigationItem.titleView = self.searchBar;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickScreen:) name:UIKeyboardWillHideNotification object:nil];

}
- (void)clickBackItem {
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSMutableArray *)searchResultArray {
    if (!_searchResultArray) {
        _searchResultArray = [NSMutableArray array];
    }
    return _searchResultArray;
}

- (NSMutableArray *)cityArray {
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
    }
    return _cityArray;
}
/// 获取城市模型
- (NSArray *)cityGroupArray {
    if (!_cityGroupArray) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"cityGroups.plist" ofType:nil];
        NSArray *cityGroupArray = [NSArray arrayWithContentsOfFile:plistPath];
        ///所有字典对象转成模型对象
        NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in cityGroupArray) {
            NSArray *cities = dic[@"cities"];
            for (NSString *str in cities) {
                [self.cityArray addObject:str];
            }
            /// 声明一个空的对象
            CityGroup *cityGroup = [[CityGroup alloc] init];
            /// kvc绑定模型对象属性和字典key关系
            [cityGroup setValuesForKeysWithDictionary:dic];
            [mutableArray addObject:cityGroup];
        }
        _cityGroupArray = mutableArray;
    }
    return _cityGroupArray;
}
/// 搜索栏
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(75, 11, SCREENWIDTH-100, 25)];
        if (@available(iOS 11.0, *)) {
            CGFloat a = 44;
            [[_searchBar.heightAnchor constraintEqualToConstant:a] setActive:YES];
        }
        _searchBar.tintColor = CustomGray;
        UITextField *searchTF = [_searchBar valueForKey:@"searchField"];
        searchTF.backgroundColor = [UIColor whiteColor];
        searchTF.font = [UIFont systemFontOfSize:16];
//        UIButton *clearBtn = [searchTF valueForKey:@"_clearButton"];
//        [clearBtn addTarget:self action:@selector(clearBtnClick) forControlEvents:UIControlEventTouchUpInside];
        searchTF.clearButtonMode = UITextFieldViewModeAlways;
        _searchBar.placeholder = @"搜索城市";
        _searchBar.delegate = self;
    }
    return _searchBar;
}
//- (void)clearBtnClick {
//    NSLog(@"删除");
//}
- (void)addShadeViewToWindow {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self.shadeView];
}

- (void)addSearchTableViewToWindow {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self.searchTableView];
    [self.searchTableView bringSubviewToFront:self.shadeView];
}

- (void)clickScreen:(NSNotification *)notification {
    NSString *name = [notification name];
    if ([name isEqualToString:@"UIKeyboardWillHideNotification"]) {
        [self.shadeView removeFromSuperview];
    }
}
/// 搜索结果展示
- (SearchTableView *)searchTableView {
    if (!_searchTableView) {
        _searchTableView = [[SearchTableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT)];
        if (@available(iOS 11.0,*)) {
            _searchTableView.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _searchTableView.tableView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _searchTableView.delegate = self;
        _searchTableView.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _searchTableView.hidden = YES;
    }
    return _searchTableView;
}
/// 遮罩View
- (UIView *)shadeView {
    if (!_shadeView) {
        _shadeView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT)];
        _shadeView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.7];
        
    }
    return _shadeView;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = true;
    manager.shouldResignOnTouchOutside = true;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchBar removeFromSuperview];
    [self.shadeView removeFromSuperview];
    [self.searchTableView removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cityGroupArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CityGroup *cityGroup = self.cityGroupArray[section];
    return cityGroup.cities.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
    CityGroup *cityGroup = self.cityGroupArray[indexPath.section];
    cell.textLabel.text = cityGroup.cities[indexPath.row];
    return  cell;
}
/// 返回section的头部
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    CityGroup *cityGroup = self.cityGroupArray[section];
    return cityGroup.title;
}
/// 返回tableViewIndex数组
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self.cityGroupArray valueForKey:@"title"];
}
/// 选中哪一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CityGroup *cityGroup = self.cityGroupArray[indexPath.section];
    NSString *name = cityGroup.cities[indexPath.row];
    if (_block != nil) {
        _block(name);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -ZZCityNameDelegate
- (void)searchTableViewDidSelectedWithName:(NSString *)cityName {
    if (_block) {
        _block(cityName);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self addShadeViewToWindow];
    [self.searchBar becomeFirstResponder];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText isEqualToString:@""]) {
        [self.searchTableView removeFromSuperview];
        self.searchTableView.hidden = YES;
    }
    else {
        
        [self addSearchTableViewToWindow];
        self.searchTableView.hidden = NO;
        [self.searchResultArray removeAllObjects];
        /// 加个多线程 否则数据量很大 有卡顿现象
        dispatch_queue_t global = dispatch_get_global_queue(0, 0);
        dispatch_async(global, ^{
            NSLog(@"%lu",self.cityArray.count);
            if (searchText !=nil && searchText.length > 0) {
                for (NSString *str in self.cityArray) {
                    NSString *pingyin = [NSString transformToPinyin:str];
                    if ([pingyin rangeOfString:searchText options:NSCaseInsensitiveSearch].length > 0) {
                        [self.searchResultArray addObject:str];
                    }
                }
            }
            /// 回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                self.searchTableView.cityNameArr = self.searchResultArray;
                if (self.searchResultArray.count > 0) {                
                    [self.searchTableView.tableView reloadData];
                }
            });
        });
    }
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"点击了");
}

@end



























