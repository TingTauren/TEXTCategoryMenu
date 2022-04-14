//
//  TGTNSegmentedBaseTitleCellModel.h
//  TGTN
//
//  Created by TGTN on 2022/3/3.
//

#import "TGTNSegmentedBaseLineCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGTNSegmentedBaseTitleCellModel : TGTNSegmentedBaseLineCellModel

/// 标题
@property (nonatomic, strong) NSString *title;
/// 标题大小
@property (nonatomic, strong) UIFont *titleFont;
/// 标题选中大小
@property (nonatomic, strong) UIFont *titleSelectFont;

/// 默认标题颜色(默认:whiteColor)
@property (nonatomic, strong) UIColor *normalTitleColor;
/// 选中标题颜色(默认:blackColor)
@property (nonatomic, strong) UIColor *selectTitleColor;

@end

NS_ASSUME_NONNULL_END
