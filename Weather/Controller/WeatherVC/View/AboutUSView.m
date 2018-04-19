//
//  AboutUSView.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/19.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "AboutUSView.h"
@interface AboutUSView()
@property (nonatomic, strong)UIImageView *iconImgView;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *versionLabel;
@property (nonatomic, strong)UIButton *qqBtn;
@end
static NSString *addQQFriends = @"mqq://im/chat?chat_type=wpa&uin=782069614&version=1&src_type=web";

@implementation AboutUSView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = infoDic[@"CFBundleShortVersionString"];
    NSString *versionTitle = [NSString stringWithFormat:@"%@版本",currentVersion];
    _iconImgView = [UIImageView imageViewWithName:@"weatherIcon"];
    _iconImgView.layer.cornerRadius = 10;
    _iconImgView.layer.masksToBounds = YES;
    _titleLabel = [UILabel labelWithTitle:@"叮叮天气" fontSize:18 textColor:CustomBlack];
    _versionLabel = [UILabel labelWithTitle:versionTitle fontSize:13 textColor:CustomBlack];
    _qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_qqBtn setTitle:@"加入QQ咨询" forState:UIControlStateNormal];
    [_qqBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _qqBtn.backgroundColor = CustomGray;
    _qqBtn.layer.cornerRadius = 15;
    _qqBtn.layer.masksToBounds = YES;
    _qqBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_qqBtn addTarget:self action:@selector(qqBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview: _iconImgView];
    [self addSubview: _titleLabel];
    [self addSubview: _versionLabel];
    [self addSubview: _qqBtn];
}
- (void)qqBtnAction {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:addQQFriends] options:@{} completionHandler:nil];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(95, 95));
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImgView.mas_bottom).mas_offset(10);
        make.centerX.equalTo(self);
    }];
    [_versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(5);
        make.centerX.equalTo(self);
    }];
    [_qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.versionLabel).mas_offset(50);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(150, 35));
    }];
}
@end
















































