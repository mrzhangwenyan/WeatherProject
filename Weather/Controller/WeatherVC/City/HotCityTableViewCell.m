//
//  HotCityTableViewCell.m
//  Weather
//
//  Created by zhangwenyan on 2018/4/23.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "HotCityTableViewCell.h"
#import "HotCollectionViewCell.h"

@interface HotCityTableViewCell()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *mutableArr;
@end

@implementation HotCityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.collectionView];
    }
    return self;
}
- (NSMutableArray *)mutableArr {
    if (!_mutableArr) {
        NSArray *arr = @[@"北京",@"上海",@"广州",@"沈阳",@"西安",@"成都",@"合肥",
                         @"昆明",@"武汉",@"杭州",@"青岛",@"天津",@"重庆",@"哈尔滨",
                         @"石家庄",@"深圳",@"苏州",@"台湾",@"厦门",@"丽江",@"南京"
                         ];
        _mutableArr = [[NSMutableArray alloc] initWithArray:arr];
    }
    return _mutableArr;
}
- (UICollectionView *)collectionView {
    if(!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 1;
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.itemSize = CGSizeMake((SCREENWIDTH-2)/3, 45);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [CustomGray colorWithAlphaComponent:0.2];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[HotCollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
    }
    return _collectionView;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.mutableArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    cell.title = self.mutableArr[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%lu-----%lu",indexPath.section,indexPath.row);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end





































