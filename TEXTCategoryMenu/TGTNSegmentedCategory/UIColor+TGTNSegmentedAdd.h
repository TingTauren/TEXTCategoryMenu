//
//  UIColor+TGTNSegmentedAdd.h
//  TGTN
//
//  Created by TGTN on 2022/2/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (TGTNSegmentedAdd)

/// 红
@property (nonatomic, assign, readonly) CGFloat tgtnSegmentedRed;
/// 绿
@property (nonatomic, assign, readonly) CGFloat tgtnSegmentedGreen;
/// 蓝
@property (nonatomic, assign, readonly) CGFloat tgtnSegmentedBlue;
/// 透明度
@property (nonatomic, assign, readonly) CGFloat tgtnSegmentedAlpha;

/// 过度颜色值
/// @param from 目标颜色值
/// @param to 过度颜色值
/// @param percent 过度百分比
+ (CGFloat)tgtnInterpolationFrom:(CGFloat) from to:(CGFloat) to percent:(CGFloat) percent;
/// 过度颜色
/// @param fromColor 目标颜色
/// @param toColor 过度颜色
/// @param percent 过度百分比
+ (UIColor *)tgtnInterpolationColorFrom:(UIColor *) fromColor to:(UIColor *) toColor percent:(CGFloat) percent;

@end

NS_ASSUME_NONNULL_END
