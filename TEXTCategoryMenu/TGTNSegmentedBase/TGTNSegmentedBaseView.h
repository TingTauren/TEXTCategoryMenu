//
//  TGTNSegmentedBaseView.h
//  TGTN
//
//  Created by TGTN on 2022/2/23.
//

#import <UIKit/UIKit.h>

#import "UIColor+TGTNSegmentedAdd.h"

#import "TGTNSegmentedBaseCollectionView.h"
#import "TGTNSegmentedBaseCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGTNSegmentedBaseView : UIView

/// 点击列表回调
@property (nonatomic, copy) void(^ _Nullable cellDidSelectConfig)(NSInteger index);

/// 列表视图
@property (nonatomic, strong, readonly) TGTNSegmentedBaseCollectionView *collectionView;

/// 左边距(默认:等于间距)
@property (nonatomic, assign) float contentEdgeInsetLeft;
/// 获取左边距
- (float)getContentEdgeInsetLeft;
/// 右边距(默认:等于间距)
@property (nonatomic, assign) float contentEdgeInsetRight;
/// 获取右边距
- (float)getContentEdgeInsetRight;
/// 列表宽度补偿(默认:0)
@property (nonatomic, assign) float cellWidthIncrement;
/// 间距(默认:20)
@property (nonatomic, assign) float cellSpacing;
/// 当前间距(默认:间距)
@property (nonatomic, assign) float cellCurrentSpacing;

/// 是否宽度变化
@property (nonatomic, assign) BOOL isCellWidthZoom;
/// 是否标题大小变化
@property (nonatomic, assign) BOOL isTitleFontZoom;

/// 滚动是否动画
@property (nonatomic, assign) BOOL scrollAnimation;
/// 点击是否动画
@property (nonatomic, assign) BOOL clickAnimation;

/// 当列表宽度不够宽度时是否均分距离
@property (nonatomic, assign) BOOL isAverageCellSpacingEnabled;

/// 选中位置
@property (nonatomic, assign) NSInteger selectIndex;
/// 默认选中位置
@property (nonatomic, assign) NSInteger defaultSelectIndex;

/// 数据源
@property (nonatomic, strong) NSArray<TGTNSegmentedBaseCellModel *> *dataSource;

/// 滚动视图
@property (nonatomic, strong) UIScrollView *contentScrollView;

#pragma mark ------ init
/// 初始化数据
- (void)tgtnInitData;
/// 添加事件
- (void)tgtnInitEvent;

#pragma mark ------ Public
/// 刷新数据源和视图
- (void)tgtnReloadDataAndView;
/// 设置滚动到指定位置
/// @param selectIndex 指定位置
- (void)tgtnSetSelectIndex:(NSInteger) selectIndex;

@end

#pragma mark ------ 分割线

@interface TGTNSegmentedBaseView (TGTNSegmentedBaseViewAdd)

/// 初始化datasource数据
- (void)initDataSource;
/// 刷新datasource数据
- (void)refreshDataSourece;
/// 初始化视图
- (void)tgtnInitView NS_REQUIRES_SUPER;

/// 返回自定义cell的class
- (Class)preferredCellClass;

/// 设置模型数据
/// @param cellModel 数据模型
/// @param index 索引
- (void)tgtnRefreshModel:(TGTNSegmentedBaseCellModel *) cellModel index:(NSInteger) index;

/// 列表宽度
/// @param index 索引
- (float)preferredCellWidthAtIndex:(NSInteger) index;

/// 滚动改变
/// @param contentOffset 偏移
- (void)contentOffsetOfContentScrollViewDidChanged:(CGPoint) contentOffset;

/// 刷新数据
/// @param leftModel 滚动左边数据
/// @param rightModel 滚动右边数据
/// @param ratio 滚动比例
- (void)tgtnChildReloadLeftModel:(TGTNSegmentedBaseCellModel *) leftModel rightModel:(TGTNSegmentedBaseCellModel *) rightModel ratio:(float) ratio;

/// 结束刷新数据
/// @param oldModel 滚动左边数据
/// @param selectModel 滚动右边数据
- (void)tgtnChildSelectDidChangeLeftModel:(TGTNSegmentedBaseCellModel *) oldModel rightModel:(TGTNSegmentedBaseCellModel *) selectModel;

/// 点击线条改变位置
/// @param index 索引
- (void)tgtnClickLineAnimationIndex:(NSInteger) index;
/// 点击线条动画回调
/// @param leftIndex 左边位置
/// @param rightIndex 右边位置
/// @param ratio 变化比例
- (void)tgtnClickChangeLineAnimationLeftIndex:(NSInteger) leftIndex rightIndex:(NSInteger) rightIndex ratio:(float) ratio;

/// 刷新视图大小
- (void)tgtnReloadViewFrame;

@end

NS_ASSUME_NONNULL_END
