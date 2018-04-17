//
//  SharedView.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/13.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "SharedView.h"
@interface SharedView()
@property (nonatomic ,strong) UIButton *wechatFriendBtn;
@property (nonatomic ,strong) UIButton *wechatCircleBtn;
@property (nonatomic ,strong) UIButton *weiboBtn;
@property (nonatomic ,strong) UIButton *qqBtn;
@property (nonatomic ,strong) UIButton *cancelBtn;
@end

@implementation SharedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI {
    _wechatFriendBtn = [UIButton buttonWithImageName:@"share_weixin" title:@"微信好友"];
    _wechatFriendBtn.tag = 101;
    _wechatCircleBtn = [UIButton buttonWithImageName:@"share_friend" title:@"朋友圈"];
    _wechatCircleBtn.tag = 102;
    _weiboBtn = [UIButton buttonWithImageName:@"share_weibo" title:@"新浪微博"];
    _weiboBtn.tag = 103;
    _qqBtn = [UIButton buttonWithImageName:@"share_qq" title:@"QQ"];
    _qqBtn.tag = 104;
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.7] forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _cancelBtn.layer.borderWidth = 1;
    _cancelBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
    _cancelBtn.layer.masksToBounds = YES;
    _cancelBtn.layer.cornerRadius = 3;
    
    [_wechatFriendBtn addTarget:self action:@selector(btnClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    [_wechatCircleBtn addTarget:self action:@selector(btnClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    [_weiboBtn addTarget:self action:@selector(btnClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    [_qqBtn addTarget:self action:@selector(btnClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_wechatFriendBtn];
    [self addSubview:_wechatCircleBtn];
    [self addSubview:_weiboBtn];
    [self addSubview:_qqBtn];
    [self addSubview:_cancelBtn];
}
- (void)cancelBtnAction {
    if (_cancelBlock) {
        _cancelBlock();
    }
}
- (void)btnClickedAction: (UIButton *)button {
    if (_callBack) {
        _callBack(button);
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat btnWith = SCREENWIDTH / 4;
    [_wechatFriendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(btnWith, btnWith));
    }];
    [_wechatCircleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.wechatFriendBtn.mas_right);
        make.size.equalTo(self.wechatFriendBtn);
    }];
    [_weiboBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.wechatCircleBtn.mas_right);
        make.size.equalTo(self.wechatCircleBtn);
    }];
    [_qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.weiboBtn.mas_right);
        make.size.equalTo(self.weiboBtn);
    }];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.weiboBtn.mas_bottom);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(160, 35));
    }];
    [_wechatFriendBtn ZZ_imagePositionStyle:ZZImagePositionStyleTop spacing:10];
    [_wechatCircleBtn ZZ_imagePositionStyle:ZZImagePositionStyleTop spacing:10];
    [_weiboBtn ZZ_imagePositionStyle:ZZImagePositionStyleTop spacing:10];
    [_qqBtn ZZ_imagePositionStyle:ZZImagePositionStyleTop spacing:10];
}

@end
































