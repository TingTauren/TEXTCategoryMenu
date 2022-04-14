//
//  TGTNSegmentedBaseTitleView.m
//  TGTN
//
//  Created by TGTN on 2022/3/3.
//

#import "TGTNSegmentedBaseTitleView.h"

@implementation TGTNSegmentedBaseTitleView

#pragma mark ------ init
/// 初始化数据
- (void)tgtnInitData {
    [super tgtnInitData];
    
    /// 默认背景颜色(默认:clearColor)
    _normalBackColor = [UIColor clearColor];
    /// 选中背景颜色(默认:grayColor)
    _selectBackColor = [UIColor clearColor];
    /// 默认标题颜色(默认:whiteColor)
    _normalTitleColor = [UIColor whiteColor];
    /// 选中标题颜色(默认:blackColor)
    _selectTitleColor = [UIColor blackColor];
    /// 默认标题大小(默认:18)
    _normalTitleFont = [UIFont systemFontOfSize:18.0];
    /// 选中标题大小(默认:22)
    _selectTitleFont = [UIFont systemFontOfSize:22.0];
}
/// 初始化视图
- (void)tgtnInitView {
    [super tgtnInitView];
}
/// 添加事件
- (void)tgtnInitEvent {
    [super tgtnInitEvent];
}
/// 初始化datasource数据
- (void)initDataSource {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSInteger i = 0; i < _titleList.count; i++) {
        TGTNSegmentedBaseTitleCellModel *cellModel = [TGTNSegmentedBaseTitleCellModel new];
        [tempArray addObject:cellModel];
    }
    self.dataSource = [NSMutableArray arrayWithArray:tempArray];
}
/// 返回自定义cell的class
- (Class)preferredCellClass {
    return [TGTNSegmentedCollectionBaseTitleCell class];
}

#pragma mark ------ super
/// 返回列表宽度
/// @param index 索引
- (float)preferredCellWidthAtIndex:(NSInteger)index {
    NSString *title = [_titleList objectAtIndex:index];
    return [title tgtnBoundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) font:_normalTitleFont withlineSpacing:0.0 withKernSpacing:0.0].width;
}
/// 刷新数据源
/// @param cellModel 数据模型
/// @param index 索引
- (void)tgtnRefreshModel:(TGTNSegmentedBaseCellModel *) cellModel index:(NSInteger) index {
    TGTNSegmentedBaseTitleCellModel *dataModel = (TGTNSegmentedBaseTitleCellModel *)cellModel;
    dataModel.title = [_titleList objectAtIndex:index];
    dataModel.titleFont = _normalTitleFont;
    dataModel.titleSelectFont = _selectTitleFont;
    dataModel.normalBackColor = _normalBackColor;
    dataModel.selectBackColor = _selectBackColor;
    dataModel.normalTitleColor = _normalTitleColor;
    dataModel.selectTitleColor = _selectTitleColor;
    dataModel.titleSelectZoomScale = dataModel.titleSelectFont.pointSize/dataModel.titleFont.pointSize;
}
/// 刷新数据
/// @param leftModel 滚动左边数据
/// @param rightModel 滚动右边数据
/// @param ratio 滚动比例
- (void)tgtnChildReloadLeftModel:(TGTNSegmentedBaseCellModel *)leftModel rightModel:(TGTNSegmentedBaseCellModel *)rightModel ratio:(float)ratio {
    TGTNSegmentedBaseTitleCellModel *leftReloadModel = (TGTNSegmentedBaseTitleCellModel *)leftModel;
    TGTNSegmentedBaseTitleCellModel *rightReloadModel = (TGTNSegmentedBaseTitleCellModel *)rightModel;
    
    if (leftReloadModel.isSelect) {
        leftReloadModel.selectBackColor = [UIColor tgtnInterpolationColorFrom:self.selectBackColor to:self.normalBackColor percent:ratio];
        leftReloadModel.normalBackColor = self.normalBackColor;
        leftReloadModel.selectTitleColor = [UIColor tgtnInterpolationColorFrom:self.selectTitleColor to:self.normalTitleColor percent:ratio];
        leftReloadModel.normalTitleColor = self.normalTitleColor;
    } else {
        leftReloadModel.normalBackColor = [UIColor tgtnInterpolationColorFrom:self.selectBackColor to:self.normalBackColor percent:ratio];
        leftReloadModel.selectBackColor = self.selectBackColor;
        leftReloadModel.normalTitleColor = [UIColor tgtnInterpolationColorFrom:self.selectTitleColor to:self.normalTitleColor percent:ratio];
        leftReloadModel.selectTitleColor = self.selectTitleColor;
    }
    if (rightReloadModel.isSelect) {
        rightReloadModel.selectBackColor = [UIColor tgtnInterpolationColorFrom:self.normalBackColor to:self.selectBackColor percent:ratio];
        rightReloadModel.normalBackColor = self.normalBackColor;
        rightReloadModel.selectTitleColor = [UIColor tgtnInterpolationColorFrom:self.normalTitleColor to:self.selectTitleColor percent:ratio];
        rightReloadModel.normalTitleColor = self.normalTitleColor;
    } else {
        rightReloadModel.normalBackColor = [UIColor tgtnInterpolationColorFrom:self.normalBackColor to:self.selectBackColor percent:ratio];
        rightReloadModel.selectBackColor = self.selectBackColor;
        rightReloadModel.normalTitleColor = [UIColor tgtnInterpolationColorFrom:self.normalTitleColor to:self.selectTitleColor percent:ratio];
        rightReloadModel.selectTitleColor = self.selectTitleColor;
    }
}
/// 结束刷新数据
/// @param oldModel 滚动左边数据
/// @param selectModel 滚动右边数据

- (void)tgtnChildSelectDidChangeLeftModel:(TGTNSegmentedBaseCellModel *)oldModel rightModel:(TGTNSegmentedBaseCellModel *)selectModel {
    TGTNSegmentedBaseTitleCellModel *oldDataModel = (TGTNSegmentedBaseTitleCellModel *)oldModel;
    oldDataModel.selectBackColor = _selectBackColor;
    oldDataModel.normalBackColor = _normalBackColor;
    oldDataModel.selectTitleColor = _selectTitleColor;
    oldDataModel.normalTitleColor = _normalTitleColor;
    
    TGTNSegmentedBaseTitleCellModel *selectDataModel = (TGTNSegmentedBaseTitleCellModel *)selectModel;
    selectDataModel.selectBackColor = _selectBackColor;
    selectDataModel.normalBackColor = _normalBackColor;
    selectDataModel.selectTitleColor = _selectTitleColor;
    selectDataModel.normalTitleColor = _normalTitleColor;
}

@end
