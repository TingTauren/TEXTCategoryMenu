//
//  SpeciallyViewTableCell.m
//  TEXTCategoryMenu
//
//  Created by Mac on 2022/3/8.
//

#import "SpeciallyViewTableCell.h"

#import "SpeciallyTableCellCollectionCell.h"

@interface SpeciallyViewTableCell()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/// 列表视图
@property (nonatomic, strong) UICollectionView *collectionView;

/// 是否首次加载
@property (nonatomic, assign) BOOL isFirstLoad;
@end

@implementation SpeciallyViewTableCell

#pragma mark ------ get
- (UICollectionView *)collectionView {
    if (_collectionView) return _collectionView;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.pagingEnabled = YES;
    _collectionView.bounces = NO;
    [_collectionView registerClass:[SpeciallyTableCellCollectionCell class] forCellWithReuseIdentifier:@"SpeciallyTableCellCollectionIdentify"];
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
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _tgtnInitView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect targetFrame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.bounds), floor(CGRectGetHeight(self.bounds)));
    if (!CGRectIsEmpty(self.frame) && _isFirstLoad) {
        _collectionView.frame = targetFrame;
        _isFirstLoad = NO;
        
        [_collectionView.collectionViewLayout invalidateLayout];
        [_collectionView reloadData];
    } else {
        if (!CGRectEqualToRect(_collectionView.frame, targetFrame)) {
            _collectionView.frame = targetFrame;
            [_collectionView.collectionViewLayout invalidateLayout];
            [_collectionView reloadData];
        }
    }
}
/// 初始化视图
- (void)_tgtnInitView {
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0];
    
    _isFirstLoad = YES;
    
    [self.contentView addSubview:self.collectionView];
}

#pragma mark ------ UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SpeciallyTableCellCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SpeciallyTableCellCollectionIdentify" forIndexPath:indexPath];
    __weak typeof(self) weakSelf = self;
    __weak typeof(cell) weakCell = cell;
    cell.childScrollDidScrollConfig = ^(UIScrollView * _Nonnull scrollView) {
        __strong typeof(weakSelf) self = weakSelf;
        __strong typeof(weakCell) cell = weakCell;
        NSInteger index = [self.collectionView indexPathForCell:cell].row;
        if (self.childScrollDidScrollConfig) {
            self.childScrollDidScrollConfig(scrollView, index);
        }
    };
    
    return cell;
}
#pragma mark ------ UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}
#pragma mark ------ UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.bounds.size;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

#pragma mark ------ Private

#pragma mark ------ Public
- (UIScrollView *)tgtnGetScrollView {
    return _collectionView;
}

@end
