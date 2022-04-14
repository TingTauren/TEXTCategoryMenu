//
//  NextViewController.m
//  TEXTCategoryMenu
//
//  Created by Mac on 2022/3/5.
//

#import "NextViewController.h"

#import "TGTNSegmentedBaseTitleView.h"
#import "TGTNSegmentedIndicatorLineView.h"
#import "TGTNSegmentedIndicatorBackLineView.h"
#import "TGTNSegmentedIndicatorImageView.h"

#define K_ViewControllerCollectionCell @"ViewControllerCollectionCellIdentify"

@interface NextViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/// 返回按钮
@property (nonatomic, strong) UIButton *backButton;

/// 分段视图
@property (nonatomic, strong) TGTNSegmentedBaseTitleView *segmentView;
/// 列表视图
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation NextViewController

#pragma mark ------ get
- (UIButton *)backButton {
    if (_backButton) return _backButton;
    _backButton = [UIButton new];
    [_backButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
    [_backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_backButton setTitle:@"返回" forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    return _backButton;
}
- (TGTNSegmentedBaseTitleView *)segmentView {
    if (_segmentView) return _segmentView;
    _segmentView = [TGTNSegmentedBaseTitleView new];
    _segmentView.frame = CGRectMake(0.0, 88.0, [UIScreen mainScreen].bounds.size.width, 64.0);
    _segmentView.backgroundColor = [UIColor blackColor];
    /// 默认标题颜色(默认:whiteColor)
    _segmentView.normalTitleColor = [UIColor whiteColor];
    /// 选中标题颜色(默认:blackColor)
    _segmentView.selectTitleColor = [UIColor brownColor];
    if ([_typeStr isEqualToString:@"少量"]) {
        /// 是否宽度变化
        _segmentView.isCellWidthZoom = NO;
        _segmentView.titleList = @[@"螃蟹", @"麻辣小龙虾", @"鱼"];
        _segmentView.isAverageCellSpacingEnabled = YES;
    } else {
        _segmentView.titleList = @[@"螃蟹", @"麻辣小龙虾", @"鱼", @"波斯顿大龙虾", @"东星斑", @"深海巨物帝王蟹"];
    }
    _segmentView.contentScrollView = self.collectionView;
    
    id line;
    if ([_typeStr isEqualToString:@"固定长度"]) {
        TGTNSegmentedIndicatorLineView *lineView = [TGTNSegmentedIndicatorLineView new];
        lineView.backgroundColor = [UIColor redColor];
        lineView.lineWidth = 30.0;
        lineView.lineHeight = 6.0;
        lineView.incrementMargin = 5.0;
        line = lineView;
    } else if ([_typeStr isEqualToString:@"cell同宽"]) {
        TGTNSegmentedIndicatorLineView *lineView = [TGTNSegmentedIndicatorLineView new];
        lineView.backgroundColor = [UIColor redColor];
        lineView.lineHeight = 6.0;
        lineView.incrementMargin = 5.0;
        line = lineView;
    } else if ([_typeStr isEqualToString:@"延长线条"]) {
        TGTNSegmentedIndicatorLineView *lineView = [TGTNSegmentedIndicatorLineView new];
        lineView.backgroundColor = [UIColor redColor];
        lineView.lineHeight = 6.0;
        lineView.incrementMargin = 5.0;
        lineView.scrollType = TGTNSegmentedIndicatorLineScrollTypeLengthen;
        line = lineView;
    } else if ([_typeStr isEqualToString:@"延长+偏移"]) {
        TGTNSegmentedIndicatorLineView *lineView = [TGTNSegmentedIndicatorLineView new];
        lineView.backgroundColor = [UIColor redColor];
        lineView.lineHeight = 6.0;
        lineView.incrementMargin = 5.0;
        lineView.scrollType = TGTNSegmentedIndicatorLineScrollTypeLengthenOffset;
        line = lineView;
    } else if ([_typeStr isEqualToString:@"椭圆型"]) {
        TGTNSegmentedIndicatorLineView *lineView = [TGTNSegmentedIndicatorLineView new];
        lineView.backgroundColor = [UIColor redColor];
        lineView.lineHeight = 30.0;
        lineView.incrementWidth = 20.0;
        lineView.type = TGTNSegmentedIndicatorLineTypeCenter;
        line = lineView;
    } else if ([_typeStr isEqualToString:@"椭圆型边框"]) {
        TGTNSegmentedIndicatorLineView *lineView = [TGTNSegmentedIndicatorLineView new];
        lineView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0];
        lineView.layer.borderColor = [UIColor redColor].CGColor;
        lineView.layer.borderWidth = 2.0;
        lineView.lineHeight = 30.0;
        lineView.incrementWidth = 20.0;
        lineView.type = TGTNSegmentedIndicatorLineTypeCenter;
        line = lineView;
    }
    if ([_typeStr isEqualToString:@"渐变色"]) {
        TGTNSegmentedIndicatorBackLineView *lineView = [TGTNSegmentedIndicatorBackLineView new];
        lineView.backColors = @[[UIColor redColor], [UIColor orangeColor], [UIColor yellowColor], [UIColor blueColor], [UIColor cyanColor], [UIColor greenColor], [UIColor purpleColor]];
        lineView.lineHeight = 6.0;
        line = lineView;
    }
    if ([_typeStr isEqualToString:@"少量"]) {
        TGTNSegmentedIndicatorLineView *lineView = [TGTNSegmentedIndicatorLineView new];
        lineView.backgroundColor = [UIColor redColor];
        lineView.lineWidth = 30.0;
        lineView.lineHeight = 6.0;
        lineView.incrementMargin = 5.0;
        line = lineView;
    }
    if ([_typeStr isEqualToString:@"图片"]) {
        TGTNSegmentedIndicatorImageView *lineView = [TGTNSegmentedIndicatorImageView new];
        lineView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0];
        lineView.image = [UIImage imageNamed:@"pic_xuanze"];
        lineView.lineWidth = 40.0;
        lineView.lineHeight = 5.0;
        lineView.incrementMargin = 5.0;
        line = lineView;
    }
    _segmentView.lineViews = @[line];
    return _segmentView;
}
- (UICollectionView *)collectionView {
    if (_collectionView) return _collectionView;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    NSInteger count = 1;
    float leftMargin = 0.0;
    float itemMargin = 0.0;
    float collectionWidth = [UIScreen mainScreen].bounds.size.width - leftMargin * 2.0 - itemMargin * (count - 1);
    float diff = (int)(collectionWidth)%count * 1.0;
    leftMargin += diff/2.0;
    float itemWidth = (collectionWidth - diff) / count;
    float itemHeight = [UIScreen mainScreen].bounds.size.height - 88.0 - 64.0;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    layout.minimumLineSpacing = itemMargin;
    layout.minimumInteritemSpacing = itemMargin;
    layout.sectionInset = UIEdgeInsetsMake(0.0, leftMargin, 0.0, leftMargin);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0, 88.0 + 64.0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 88.0 - 64.0) collectionViewLayout:layout];
    _collectionView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.pagingEnabled = YES;
    _collectionView.bounces = NO;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:K_ViewControllerCollectionCell];
    // 滚动视图适配
    if (@available(iOS 10.0, *)) {
        _collectionView.prefetchingEnabled = NO;
    }
    if ([self respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _collectionView;
}

#pragma mark ------ set

#pragma mark ------ init

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.backButton];
    _backButton.frame = CGRectMake(20.0, 44.0, 80.0, 50.0);
    
    [self.view addSubview:self.segmentView];
    [self.view addSubview:self.collectionView];
    __weak typeof(self) weakSelef = self;
    // 列表点击
    _segmentView.cellDidSelectConfig = ^(NSInteger index) {
        __strong typeof(weakSelef) self = weakSelef;
        [self.collectionView setContentOffset:CGPointMake(CGRectGetWidth(self.collectionView.bounds) * index, 0.0) animated:YES];
    };
    
    [_segmentView tgtnSetSelectIndex:4];
}

#pragma mark ------ UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _segmentView.titleList.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:K_ViewControllerCollectionCell forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    
    return cell;
}
#pragma mark ------ UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    for (TGTNSegmentedIndicatorLineView *lineView in _segmentView.lineViews) {
        if (lineView.type == TGTNSegmentedIndicatorLineTypeDefault) {
            lineView.type = TGTNSegmentedIndicatorLineTypeTop;
        } else {
            lineView.type = TGTNSegmentedIndicatorLineTypeDefault;
        }
    }
    [_segmentView tgtnReloadDataAndView];
}

#pragma mark ------ Click
- (void)backButtonClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
