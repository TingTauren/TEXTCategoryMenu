//
//  TGTNSegmentedBaseIndicatorView.h
//  TGTN
//
//  Created by TGTN on 2022/3/4.
//

#import <UIKit/UIKit.h>

#import "UIColor+TGTNSegmentedAdd.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGTNSegmentedBaseIndicatorView : UIView

/// 选中位置
@property (nonatomic, assign) NSInteger selectIndex;
/// 左边位置
@property (nonatomic, assign) NSInteger leftIndex;
/// 右边位置
@property (nonatomic, assign) NSInteger rightIndex;

/// 线条宽度
@property (nonatomic, assign) float lineWidth;
/// 线条高度
@property (nonatomic, assign) float lineHeight;
/// 线条圆角
@property (nonatomic, assign) float lineRadius;

/// 补偿宽度
@property (nonatomic, assign) float incrementWidth;
/// 补偿边距 (上 下)
@property (nonatomic, assign) float incrementMargin;

/// 线条宽度
/// @param cellFrame 列表大小
- (float)tgtnLineWidthValue:(CGRect) cellFrame;
/// 线条高度
/// @param cellFrame 列表大小
- (float)tgtnLineHeightValue:(CGRect) cellFrame;
/// 线条圆角
/// @param cellFrame 列表大小
- (float)tgtnLineRadiusValue:(CGRect) cellFrame;

#pragma mark ------ Public
/// 设置线条位置
/// @param frame 位置大小
- (void)tgtnSetLineFrame:(CGRect) frame;
/// 改变线条位置
/// @param leftFrame 左边大小
/// @param rightFrame 右边大小
/// @param ratio 比例
- (void)tgtnChangeLineViewFrameWithLeftFrame:(CGRect) leftFrame rightFrame:(CGRect) rightFrame ratio:(float) ratio;

@end

NS_ASSUME_NONNULL_END
