//
//  TGTNSegmentedBaseCellModel.h
//  TGTN
//
//  Created by TGTN on 2022/2/23.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "NSString+TGTNSegmentedAdd.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGTNSegmentedBaseCellModel : NSObject

/// 索引
@property (nonatomic, assign) NSInteger index;

/// 标题默认缩放比例
@property (nonatomic, assign) float titleNormalZoomScale;
/// 标题选中缩放比例
@property (nonatomic, assign) float titleSelectZoomScale;
/// 标题当前缩放比例
@property (nonatomic, assign) float titleCurrentZoomScale;

/// 默认背景颜色
@property (nonatomic, strong) UIColor *normalBackColor;
/// 选中背景颜色
@property (nonatomic, strong) UIColor *selectBackColor;

/// 列表宽度
@property (nonatomic, assign) float cellWidth;
/// 当前列表宽度
@property (nonatomic, assign) float currentCellWidth;

/// 是否选中
@property (nonatomic, assign) BOOL isSelect;

@end

NS_ASSUME_NONNULL_END
