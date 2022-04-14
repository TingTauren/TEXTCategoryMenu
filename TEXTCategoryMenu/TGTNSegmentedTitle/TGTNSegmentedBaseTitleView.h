//
//  TGTNSegmentedBaseTitleView.h
//  TGTN
//
//  Created by TGTN on 2022/3/3.
//

#import "TGTNSegmentedBaseLineView.h"

#import "TGTNSegmentedCollectionBaseTitleCell.h"
#import "TGTNSegmentedBaseTitleCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGTNSegmentedBaseTitleView : TGTNSegmentedBaseLineView

/// 标题
@property (nonatomic, strong) NSArray *titleList;

/// 默认背景颜色(默认:clearColor)
@property (nonatomic, strong) UIColor *normalBackColor;
/// 选中背景颜色(默认:grayColor)
@property (nonatomic, strong) UIColor *selectBackColor;

/// 默认标题颜色(默认:whiteColor)
@property (nonatomic, strong) UIColor *normalTitleColor;
/// 选中标题颜色(默认:blackColor)
@property (nonatomic, strong) UIColor *selectTitleColor;

/// 默认标题大小(默认:18)
@property (nonatomic, strong) UIFont *normalTitleFont;
/// 选中标题大小(默认:22)
@property (nonatomic, strong) UIFont *selectTitleFont;

@end

NS_ASSUME_NONNULL_END
