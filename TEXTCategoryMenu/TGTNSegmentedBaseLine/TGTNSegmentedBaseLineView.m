//
//  TGTNSegmentedBaseLineView.m
//  TGTN
//
//  Created by TGTN on 2022/3/3.
//

#import "TGTNSegmentedBaseLineView.h"

@implementation TGTNSegmentedBaseLineView

#pragma mark ------ set
- (void)setLineViews:(NSArray<TGTNSegmentedBaseIndicatorView *> *)lineViews {
    _lineViews = lineViews;
    
    self.collectionView.lineViews = _lineViews;
}

#pragma mark ------ init
/// 初始化数据
- (void)tgtnInitData {
    [super tgtnInitData];
}
/// 初始化视图
- (void)tgtnInitView {
    [super tgtnInitView];
}
/// 刷新数据源
- (void)refreshDataSourece {
    [super refreshDataSourece];
    
    // 初始化线条位置
    [self _tgtnSetLineFrame:self.defaultSelectIndex];
}
/// 返回自定义cell的class
- (Class)preferredCellClass {
    return [TGTNSegmentedCollectionBaseLineCell class];
}

#pragma mark ------ Function
/// 获取指定cell的大小
/// @param targetIndex 索引
- (CGRect)_tgtnGetTargetCellFrame:(NSInteger) targetIndex {
    float x = [self getContentEdgeInsetLeft];
    for (NSInteger i = 0; i < targetIndex; i++) {
        TGTNSegmentedBaseLineCellModel *cellModel = (TGTNSegmentedBaseLineCellModel *)[self.dataSource objectAtIndex:i];
        float cellWidth = cellModel.currentCellWidth;
        x += cellWidth + self.cellCurrentSpacing;
    }
    float width;
    TGTNSegmentedBaseLineCellModel *cellModel = (TGTNSegmentedBaseLineCellModel *)[self.dataSource objectAtIndex:targetIndex];
    width = cellModel.currentCellWidth;
    return CGRectMake(x, 0, width, self.collectionView.bounds.size.height);
}
/// 设置模型数据
/// @param cellModel 数据模型
/// @param index 索引
- (void)tgtnRefreshModel:(TGTNSegmentedBaseCellModel *) cellModel index:(NSInteger) index {
}

#pragma mark ------ Private
/// 设置线条位置
/// @param selectIndex 选中位置
- (void)_tgtnSetLineFrame:(NSInteger) selectIndex {
    CGRect selectFrame = [self _tgtnGetTargetCellFrame:selectIndex];
    
    for (TGTNSegmentedBaseIndicatorView *view in _lineViews) {
        view.selectIndex = selectIndex;
        // 设置线条位置大小
        [view tgtnSetLineFrame:selectFrame];
        view.layer.cornerRadius = [view tgtnLineRadiusValue:selectFrame];
        view.layer.masksToBounds = YES;
    }
}
/// 线条改变
/// @param leftIndex 左边位置
/// @param rightIndex 右边位置
- (void)_tgtnChangeLineViewFrameWithLeftIndex:(NSInteger) leftIndex rightIndex:(NSInteger) rightIndex ratio:(float) ratio {
    CGRect rightCelFrame = [self _tgtnGetTargetCellFrame:rightIndex];
    CGRect leftCelFrame = [self _tgtnGetTargetCellFrame:leftIndex];
    // 改变线条位置
    for (TGTNSegmentedBaseIndicatorView *view in _lineViews) {
        view.leftIndex = leftIndex;
        view.rightIndex = rightIndex;
        // 设置线条位置大小
        [view tgtnChangeLineViewFrameWithLeftFrame:leftCelFrame rightFrame:rightCelFrame ratio:ratio];
    }
}

#pragma mark ------ super
/// 滚动偏移
/// @param contentOffset 偏移大小
- (void)contentOffsetOfContentScrollViewDidChanged:(CGPoint)contentOffset {
    [super contentOffsetOfContentScrollViewDidChanged:contentOffset];
    
    float ratio = contentOffset.x / CGRectGetWidth(self.contentScrollView.bounds);
    if (ratio > self.dataSource.count - 1 || ratio < 0) {
        // 边界限制
        return;
    }
    ratio = MAX(0, MIN(self.dataSource.count - 1, ratio));
    NSInteger baseIndex = floor(ratio);
    if (baseIndex + 1 >= self.dataSource.count) {
        // 右边越界了, 不需要处理
        return;
    }
    float remainderRatio = ratio - baseIndex;
    
    if (remainderRatio == 0) {
        // 设置线条位置大小
        [self _tgtnSetLineFrame:baseIndex];
    } else {
        // 更新线条位置
        [self _tgtnChangeLineViewFrameWithLeftIndex:baseIndex rightIndex:baseIndex+1 ratio:remainderRatio];
        
        if (fabs(ratio - self.defaultSelectIndex) > 1) {
            NSInteger targetIndex = baseIndex;
            if (ratio < self.defaultSelectIndex) {
                targetIndex = baseIndex + 1;
            }
            // 设置线条位置大小
            [self _tgtnSetLineFrame:baseIndex];
        }
    }
}
/// 点击线条改变位置
/// @param index 索引
- (void)tgtnClickLineAnimationIndex:(NSInteger) index {
    // 设置线条位置大小
    [self _tgtnSetLineFrame:index];
}
/// 点击线条动画回调
/// @param leftIndex 左边位置
/// @param rightIndex 右边位置
/// @param ratio 变化比例
- (void)tgtnClickChangeLineAnimationLeftIndex:(NSInteger) leftIndex rightIndex:(NSInteger) rightIndex ratio:(float) ratio {
    // 更新线条位置
    [self _tgtnChangeLineViewFrameWithLeftIndex:leftIndex rightIndex:rightIndex ratio:ratio];
}
/// 刷新视图大小
- (void)tgtnReloadViewFrame {
    // 初始化线条位置
    [self _tgtnSetLineFrame:self.defaultSelectIndex];
}

@end
