//
//  TGTNSegmentedBaseView.m
//  TGTN
//
//  Created by TGTN on 2022/2/23.
//

#import "TGTNSegmentedBaseView.h"

#import "UIColor+TGTNSegmentedAdd.h"

#import "TGTNSegmentedCollectionBaseCell.h"

#define K_TGTNSegmentedBaseCollectionCell @"TGTNSegmentedBaseCollectionCellIdentify"

@interface TGTNSegmentedBaseView()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    BOOL _isFirstLayoutSubViews;
    CGPoint _lastContentScrollViewOffset;
}
/// 列表视图
@property (nonatomic, strong, readwrite) TGTNSegmentedBaseCollectionView *collectionView;
/// 计时器
@property (nonatomic, strong) CADisplayLink *disPlayLink;
/// 计时器百分比
@property (nonatomic, assign) CGFloat linkRatio;
/// 计时器计数
@property (nonatomic, assign) CFTimeInterval linkTime;
/// 计时器时间
@property (nonatomic, assign) NSTimeInterval linkDuration;
/// 计时器跳转位置
@property (nonatomic, assign) NSInteger linkIndex;
@end

@implementation TGTNSegmentedBaseView

#pragma mark ------ get
- (void)setDefaultSelectIndex:(NSInteger) defaultSelectIndex {
    _defaultSelectIndex = defaultSelectIndex;
    
    self.selectIndex = defaultSelectIndex;
}
- (float)getContentEdgeInsetLeft {
    if (_contentEdgeInsetLeft == -1) {
        return _cellCurrentSpacing;
    }
    return _contentEdgeInsetLeft;
}
- (float)getContentEdgeInsetRight {
    if (_contentEdgeInsetRight == -1) {
        return _cellCurrentSpacing;
    }
    return _contentEdgeInsetRight;
}
- (CADisplayLink *)disPlayLink {
    if (_disPlayLink) return _disPlayLink;
    _disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(disPlayLinkClick:)];
    return _disPlayLink;
}

#pragma mark ------ set
- (void)setContentScrollView:(UIScrollView *)contentScrollView {
    if (_contentScrollView != nil) {
        [_contentScrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    _contentScrollView = contentScrollView;
    
    self.contentScrollView.scrollsToTop = NO;
    [self.contentScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark ------ init
- (void)dealloc {
    if (self.contentScrollView) {
        [self.contentScrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect targetFrame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.bounds), floor(CGRectGetHeight(self.bounds)));
    if (!CGRectIsEmpty(self.frame) && _isFirstLayoutSubViews) {
        _collectionView.frame = targetFrame;
        _isFirstLayoutSubViews = NO;
        // 刷新数据源和视图
        [self tgtnReloadDataAndView];
    } else {
        if (!CGRectEqualToRect(_collectionView.frame, targetFrame)) {
            _collectionView.frame = targetFrame;
            [_collectionView.collectionViewLayout invalidateLayout];
            [_collectionView reloadData];
            
            // 刷新视图大小
            [self tgtnReloadViewFrame];
        }
    }
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self tgtnInitData];
        [self tgtnInitView];
        [self tgtnInitEvent];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self tgtnInitData];
        [self tgtnInitView];
        [self tgtnInitEvent];
    }
    return self;
}
/// 初始化数据
- (void)tgtnInitData {
    _isFirstLayoutSubViews = YES;
    /// 左边距(默认:等于间距)
    _contentEdgeInsetLeft = -1;
    /// 右边距(默认:等于间距)
    _contentEdgeInsetRight = -1;
    /// 列表宽度补偿(默认:0)
    _cellWidthIncrement = 0.0;
    /// 间距(默认:20)
    _cellSpacing = 20.0;
    /// 当前间距
    _cellCurrentSpacing = _cellSpacing;
    
    /// 计时器时间
    _linkDuration = 0.2;
    /// 是否宽度变化
    _isCellWidthZoom = YES;
    /// 是否标题大小变化
    _isTitleFontZoom = YES;
    
    /// 滚动是否动画
    _scrollAnimation = YES;
    /// 点击是否动画
    _clickAnimation = YES;
    
    /// 数据源
    _dataSource = [NSMutableArray array];
}
/// 添加事件
- (void)tgtnInitEvent {
}

#pragma mark ------ UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataSource.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self preferredCellClass]) forIndexPath:indexPath];
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    TGTNSegmentedBaseCellModel *model = [_dataSource objectAtIndex:indexPath.row];
    [(TGTNSegmentedCollectionBaseCell *)cell tgtnSetModel:model];
}
#pragma mark ------ UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.defaultSelectIndex) {
        return;
    }
    if (_cellDidSelectConfig) {
        _cellDidSelectConfig(indexPath.row);
    }
    if (_disPlayLink) {
        // 结束动画
        [self _tgtn_endAnimation];
    }
    
    _linkIndex = indexPath.row;
    _linkRatio = self.defaultSelectIndex;
    
    if (_clickAnimation) {
        // 添加计时器
        [self _tgtn_addDisplayLink];
    } else {
        // 结束动画
        [self _tgtn_endAnimation];
    }
}

#pragma mark ------ UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0.0, [self getContentEdgeInsetLeft], 0.0, [self getContentEdgeInsetRight]);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    TGTNSegmentedBaseCellModel *model = [_dataSource objectAtIndex:indexPath.row];
    return CGSizeMake(model.currentCellWidth, CGRectGetHeight(_collectionView.bounds));
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return _cellCurrentSpacing;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return _cellCurrentSpacing;
}

#pragma mark ------ KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint contentOffset = [change[NSKeyValueChangeNewKey] CGPointValue];
        if (self.contentScrollView.isTracking || self.contentScrollView.isDecelerating) {
            // 只处理用户滚动的情况
            [self contentOffsetOfContentScrollViewDidChanged:contentOffset];
        }
        _lastContentScrollViewOffset = contentOffset;
    }
}

#pragma mark ------ Click
/// 计时器回调 一秒60帧 动画时间0.3秒 1帧加0.0556
- (void)disPlayLinkClick:(CADisplayLink *)playLink {
    if (_linkTime == 0) {
        _linkTime = playLink.timestamp;
        return;
    }
    
    CGFloat offRatio = 0.0;
    if (_defaultSelectIndex > _linkIndex) {
        offRatio = 1.0;
    }
    _linkRatio = (playLink.timestamp - _linkTime)/_linkDuration;
    if (offRatio > 0.0) {
        _linkRatio = offRatio - _linkRatio;
    }
    _linkRatio = fmax(0.0, fmin(1.0, _linkRatio));
    
    // 到达时间了
    if (_linkRatio == 1.0 || _linkRatio == 0.0) {
        // 结束动画
        [self _tgtn_endAnimation];
    } else {
        // 更新数据
        [self tgtnReloadDataAndCellFromIndex:MIN(_defaultSelectIndex, _linkIndex) toIndex:MAX(_defaultSelectIndex, _linkIndex) ratio:_linkRatio];
        // 更新线条位置
        [self tgtnClickChangeLineAnimationLeftIndex:MIN(_defaultSelectIndex, _linkIndex) rightIndex:MAX(_defaultSelectIndex, _linkIndex) ratio:_linkRatio];
    }
}

#pragma mark ------ Function
/// 改变数据源和视图
/// @param fromIndex 目标索引
/// @param toIndex 改变索引
/// @param ratio 比例
- (void)tgtnReloadDataAndCellFromIndex:(NSInteger) fromIndex toIndex:(NSInteger) toIndex ratio:(float) ratio {
    TGTNSegmentedBaseCellModel *leftModel = [_dataSource objectAtIndex:fromIndex];
    TGTNSegmentedBaseCellModel *rightModel = [_dataSource objectAtIndex:toIndex];
    
    /// 刷新数据
    [self tgtnReloadLeftModel:leftModel rightModel:rightModel ratio:ratio];
    
    TGTNSegmentedCollectionBaseCell *leftCell = (TGTNSegmentedCollectionBaseCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:fromIndex inSection:0]];
    [leftCell tgtnSetModel:leftModel];
    TGTNSegmentedCollectionBaseCell *rightCell = (TGTNSegmentedCollectionBaseCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:toIndex inSection:0]];
    [rightCell tgtnSetModel:rightModel];
    
    [_collectionView.collectionViewLayout invalidateLayout];
}
/// 改变选中状态
/// @param oldIndex 上一次选中索引
/// @param selectIndex 这一次选中索引
- (void)tgtnChangeSelectStatus:(NSInteger) oldIndex selectIndex:(NSInteger) selectIndex {
    TGTNSegmentedBaseCellModel *oldModel = [_dataSource objectAtIndex:oldIndex];
    TGTNSegmentedBaseCellModel *model = [_dataSource objectAtIndex:selectIndex];
    
    // 结束刷新数据
    [self tgtnSelectDidChangeLeftModel:oldModel rightModel:model];
    
    TGTNSegmentedCollectionBaseCell *oldCell = (TGTNSegmentedCollectionBaseCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:oldIndex inSection:0]];
    [oldCell tgtnSetModel:oldModel];
    TGTNSegmentedCollectionBaseCell *cell = (TGTNSegmentedCollectionBaseCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:selectIndex inSection:0]];
    [cell tgtnSetModel:model];
    
    [_collectionView.collectionViewLayout invalidateLayout];
}

#pragma mark ------ Private
/// 滚动到指定位置
/// @param index 索引
- (void)_tgtnScrollSelectItemAtIndex:(NSInteger) index {
    if (index < 0 || index >= self.dataSource.count) {
        return;
    }
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    NSInteger oldIndex = self.defaultSelectIndex;
    self.defaultSelectIndex = index;
    // 改变选中状态
    [self tgtnChangeSelectStatus:oldIndex selectIndex:self.defaultSelectIndex];
}
/// 添加计时器
- (void)_tgtn_addDisplayLink {
    [self.disPlayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}
/// 删除计时器
- (void)_tgtn_removeDisplayLink {
    [_disPlayLink invalidate];
    _disPlayLink = nil;
}
/// 结束动画
- (void)_tgtn_endAnimation {
    // 删除计时器
    [self _tgtn_removeDisplayLink];
    // 滚动到指定位置
    [self _tgtnScrollSelectItemAtIndex:_linkIndex];
    // 设置线条位置
    [self tgtnClickLineAnimationIndex:_linkIndex];
    _linkIndex = -1;
    _linkTime = 0.0;
    _linkRatio = -0.0;
}
/// 获取指定cell的大小
/// @param targetIndex 索引
- (CGRect)_tgtnGetTargetCellFrame:(NSInteger) targetIndex {
    float x = [self getContentEdgeInsetLeft];
    for (NSInteger i = 0; i < targetIndex; i++) {
        TGTNSegmentedBaseCellModel *cellModel = (TGTNSegmentedBaseCellModel *)[_dataSource objectAtIndex:i];
        float cellWidth = cellModel.currentCellWidth;
        x += cellWidth + _cellCurrentSpacing;
    }
    float width;
    TGTNSegmentedBaseCellModel *cellModel = (TGTNSegmentedBaseCellModel *)[_dataSource objectAtIndex:targetIndex];
    width = cellModel.currentCellWidth;
    return CGRectMake(x, 0, width, _collectionView.bounds.size.height);
}
/// 刷新数据
/// @param leftModel 滚动左边数据
/// @param rightModel 滚动右边数据
/// @param ratio 滚动比例
- (void)tgtnReloadLeftModel:(TGTNSegmentedBaseCellModel *) leftModel rightModel:(TGTNSegmentedBaseCellModel *) rightModel ratio:(float) ratio {
    if (_isTitleFontZoom) {
        leftModel.titleCurrentZoomScale = [UIColor tgtnInterpolationFrom:leftModel.titleSelectZoomScale to:1.0 percent:ratio];
        rightModel.titleCurrentZoomScale = [UIColor tgtnInterpolationFrom:1.0 to:leftModel.titleSelectZoomScale percent:ratio];
    }
    if (_isCellWidthZoom) {
        leftModel.currentCellWidth = leftModel.cellWidth * leftModel.titleCurrentZoomScale;
        rightModel.currentCellWidth = rightModel.cellWidth * rightModel.titleCurrentZoomScale;
    }
    
    // 子类实现滚动数据变化
    [self tgtnChildReloadLeftModel:leftModel rightModel:rightModel ratio:ratio];
}
/// 结束刷新数据
/// @param oldModel 滚动左边数据
/// @param selectModel 滚动右边数据
- (void)tgtnSelectDidChangeLeftModel:(TGTNSegmentedBaseCellModel *) oldModel rightModel:(TGTNSegmentedBaseCellModel *) selectModel {
    oldModel.isSelect = NO;
    oldModel.titleCurrentZoomScale = oldModel.titleNormalZoomScale;
    if (oldModel.isSelect) {
        oldModel.titleCurrentZoomScale = oldModel.titleSelectZoomScale;
    }
    if (_isCellWidthZoom) {
        oldModel.currentCellWidth = oldModel.cellWidth * oldModel.titleCurrentZoomScale;
    }
    
    selectModel.isSelect = YES;
    selectModel.titleCurrentZoomScale = selectModel.titleNormalZoomScale;
    if (selectModel.isSelect) {
        selectModel.titleCurrentZoomScale = selectModel.titleSelectZoomScale;
    }
    if (_isCellWidthZoom) {
        selectModel.currentCellWidth = selectModel.cellWidth * selectModel.titleCurrentZoomScale;
    }
    
    // 之类实现刷新结束数据
    [self tgtnChildSelectDidChangeLeftModel:oldModel rightModel:selectModel];
}

#pragma mark ------ Public
/// 刷新数据源和视图
- (void)tgtnReloadDataAndView {
    // 刷新数据源
    [self reloadDataSource];
    
    [_collectionView.collectionViewLayout invalidateLayout];
    [_collectionView reloadData];
}
/// 刷新数据源
- (void)reloadDataSource {
    // 初始化datasource数据
    [self initDataSource];
    // 刷新datasource数据
    [self refreshDataSourece];
    
    if (_selectIndex > 0) {
        // 滚动主视图
        if (_cellDidSelectConfig) {
            _cellDidSelectConfig(_selectIndex);
        }
        // 滚动到指定位置
        [self _tgtnScrollSelectItemAtIndex:_selectIndex];
    }
}
/// 设置滚动到指定位置
/// @param selectIndex 指定位置
- (void)tgtnSetSelectIndex:(NSInteger) selectIndex {
    if (_dataSource.count > selectIndex) {
        // 滚动到指定位置
        [self _tgtnScrollSelectItemAtIndex:selectIndex];
    } else {
        self.defaultSelectIndex = selectIndex;
    }
}
/// 列表宽度
/// @param index 索引
- (float)tgtnCellWidthAtIndex:(NSInteger) index {
    return [self preferredCellWidthAtIndex:index] + _cellWidthIncrement;
}

@end

#pragma mark ------ 分割线

@implementation TGTNSegmentedBaseView (TGTNSegmentedBaseViewAdd)

- (TGTNSegmentedBaseCollectionView *)collectionView {
    if (_collectionView) return _collectionView;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[TGTNSegmentedBaseCollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerClass:[self preferredCellClass] forCellWithReuseIdentifier:NSStringFromClass([self preferredCellClass])];
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

/// 初始化datasource数据
- (void)initDataSource {
}
/// 刷新datasource数据
- (void)refreshDataSourece {
    if (self.selectIndex < 0 || self.selectIndex >= self.dataSource.count) {
        self.defaultSelectIndex = 0;
    }
    
    if (_isAverageCellSpacingEnabled) {
        _cellCurrentSpacing = _cellSpacing;
    }
    
    float totalItemWidth = [self getContentEdgeInsetLeft];
    // 总的cell宽度
    float totalCellWidth = 0.0;
    for (NSInteger i = 0; i < self.dataSource.count; i++) {
        TGTNSegmentedBaseCellModel *cellModel = self.dataSource[i];
        cellModel.index = i;
        cellModel.titleNormalZoomScale = 1.0;
        cellModel.isSelect = NO;
        cellModel.titleCurrentZoomScale = cellModel.titleNormalZoomScale;
        
        // 子类实现自定义数据赋值
        [self tgtnRefreshModel:cellModel index:i];
        
        if (i == self.selectIndex) {
            cellModel.isSelect = YES;
            cellModel.titleCurrentZoomScale = cellModel.titleSelectZoomScale;
        }
        cellModel.cellWidth = [self tgtnCellWidthAtIndex:i];
        if (_isCellWidthZoom) {
            cellModel.currentCellWidth = cellModel.cellWidth * cellModel.titleCurrentZoomScale;
        } else {
            cellModel.currentCellWidth = cellModel.cellWidth;
        }
        
        // 累加总宽度
        totalCellWidth += cellModel.cellWidth;
        if (i == self.dataSource.count - 1) {
            totalItemWidth += cellModel.cellWidth + [self getContentEdgeInsetRight];
        } else if (i == 0) {
            totalItemWidth += cellModel.cellWidth;
        } else {
            totalItemWidth += cellModel.cellWidth + _cellCurrentSpacing;
        }
    }
    
    totalCellWidth = ceilf(totalCellWidth);
    float selfWidth = self.bounds.size.width;
    if (totalItemWidth < selfWidth && self.isAverageCellSpacingEnabled) {
        NSInteger cellSpacingItemCount = self.dataSource.count - 1;
        float totalCellSpacingWidth = selfWidth - totalCellWidth;
        
        if (self.contentEdgeInsetLeft == -1) {
            cellSpacingItemCount += 1;
        } else {
            totalCellSpacingWidth -= self.contentEdgeInsetLeft;
        }
        if (self.contentEdgeInsetRight == -1) {
            cellSpacingItemCount += 1;
        } else {
            totalCellSpacingWidth -= self.contentEdgeInsetRight;
        }
        
        float cellSpacing = 0;
        if (cellSpacingItemCount > 0) {
            cellSpacing = totalCellSpacingWidth / cellSpacingItemCount;
        }
        _cellCurrentSpacing = cellSpacing;
    }
}
/// 初始化视图
- (void)tgtnInitView {
    [self addSubview:self.collectionView];
}

/// 返回自定义cell的class
- (Class)preferredCellClass {
    return TGTNSegmentedCollectionBaseCell.class;
}

/// 刷新数据源
/// @param cellModel 数据模型
/// @param index 索引
- (void)tgtnRefreshModel:(TGTNSegmentedBaseCellModel *) cellModel index:(NSInteger) index {
}

/// 列表宽度
/// @param index 索引
- (float)preferredCellWidthAtIndex:(NSInteger) index {
    return 0;
}

/// 滚动改变
/// @param contentOffset 偏移
- (void)contentOffsetOfContentScrollViewDidChanged:(CGPoint) contentOffset {
    float ratio = contentOffset.x / CGRectGetWidth(_contentScrollView.bounds);
    if (ratio > self.dataSource.count - 1 || ratio < 0) {
        // 边界限制
        return;
    }
    if (contentOffset.x == 0 && self.selectIndex == 0 && _lastContentScrollViewOffset.x == 0) {
        // 滚动到最左边，并且选中了第一个，且上一次x = 0
        return;
    }
    if (_disPlayLink) {
        // 结束动画
        [self _tgtn_endAnimation];
        return;
    }
    float maxContentOffsetX = _contentScrollView.contentSize.width - CGRectGetWidth(_contentScrollView.bounds);
    if (contentOffset.x == maxContentOffsetX && self.selectIndex == self.dataSource.count -1 && _lastContentScrollViewOffset.x == maxContentOffsetX) {
        // 滚动到最右边，并且选中了最后一个，且上一次x = maxContentOffsetX
        return;
    }
    ratio = MAX(0, MIN(self.dataSource.count - 1, ratio));
    NSInteger baseIndex = floor(ratio);
    float remainderRatio = ratio - baseIndex;
    
    if (remainderRatio == 0) {
        // 快速滑动翻页，用户一直在拖拽视图，需要更新选中状态
        // 滑动一小段距离，然后放开回到原位
        if (!(_lastContentScrollViewOffset.x == contentOffset.x && self.selectIndex == baseIndex)) {
            // 滚动到指定位置
            [self _tgtnScrollSelectItemAtIndex:baseIndex];
        }
    } else {
        if (_scrollAnimation) {
            // 更新数据
            [self tgtnReloadDataAndCellFromIndex:baseIndex toIndex:baseIndex+1 ratio:remainderRatio];
        }
        
        if (fabs(ratio - self.selectIndex) > 1) {
            NSInteger targetIndex = baseIndex;
            if (ratio < self.selectIndex) {
                targetIndex = baseIndex + 1;
            }
            // 滚动到指定位置
            [self _tgtnScrollSelectItemAtIndex:targetIndex];
        }
    }
}

/// 刷新数据
/// @param leftModel 滚动左边数据
/// @param rightModel 滚动右边数据
/// @param ratio 滚动比例
- (void)tgtnChildReloadLeftModel:(TGTNSegmentedBaseCellModel *) leftModel rightModel:(TGTNSegmentedBaseCellModel *) rightModel ratio:(float) ratio {
}

/// 结束刷新数据
/// @param oldModel 滚动左边数据
/// @param selectModel 滚动右边数据
- (void)tgtnChildSelectDidChangeLeftModel:(TGTNSegmentedBaseCellModel *) oldModel rightModel:(TGTNSegmentedBaseCellModel *) selectModel {
}
/// 点击线条改变位置
/// @param index 索引
- (void)tgtnClickLineAnimationIndex:(NSInteger) index {
}
/// 点击线条动画回调
/// @param leftIndex 左边位置
/// @param rightIndex 右边位置
/// @param ratio 变化比例
- (void)tgtnClickChangeLineAnimationLeftIndex:(NSInteger) leftIndex rightIndex:(NSInteger) rightIndex ratio:(float) ratio {
}
/// 刷新视图大小
- (void)tgtnReloadViewFrame {
}

@end
