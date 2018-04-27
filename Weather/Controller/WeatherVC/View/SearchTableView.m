//
//  SearchTableView.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/12.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "SearchTableView.h"

@interface SearchTableView()<UITableViewDelegate, UITableViewDataSource>

@end
@implementation SearchTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createdUI];
    }
    return self;
}

- (void)createdUI {
    self.titleLabel = [UILabel labelWithTitle:@"添加您想关注的城市" fontSize:16 textColor:CustomGray];
    [self.tableView addSubview:self.titleLabel];
    [self addSubview:self.tableView];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"identifier"];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.mas_top).mas_offset(200);
        make.centerX.equalTo(self.tableView);
    }];
}

#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cityNameArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
    cell.textLabel.text = self.cityNameArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(searchTableViewDidSelectedWithName:)]) {
        [self.delegate searchTableViewDidSelectedWithName:self.cityNameArr[indexPath.row]];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end















































