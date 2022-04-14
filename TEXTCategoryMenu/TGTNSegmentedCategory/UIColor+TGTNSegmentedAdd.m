//
//  UIColor+TGTNSegmentedAdd.m
//  TGTN
//
//  Created by TGTN on 2022/2/24.
//

#import "UIColor+TGTNSegmentedAdd.h"

@implementation UIColor (TGTNSegmentedAdd)

- (CGFloat)tgtnSegmentedRed {
    CGFloat r = 0, g, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return r;
}
- (CGFloat)tgtnSegmentedGreen {
    CGFloat r, g = 0, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return g;
}
- (CGFloat)tgtnSegmentedBlue {
    CGFloat r, g, b = 0, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return b;
}
- (CGFloat)tgtnSegmentedAlpha {
    return CGColorGetAlpha(self.CGColor);
}

#pragma mark ------ Public
/// 过度颜色值
/// @param from 目标颜色值
/// @param to 过度颜色值
/// @param percent 过度百分比
+ (CGFloat)tgtnInterpolationFrom:(CGFloat) from to:(CGFloat) to percent:(CGFloat) percent {
    percent = MAX(0, MIN(1, percent));
    return from + (to - from) * percent;
}
/// 过度颜色
/// @param fromColor 目标颜色
/// @param toColor 过度颜色
/// @param percent 过度百分比
+ (UIColor *)tgtnInterpolationColorFrom:(UIColor *) fromColor to:(UIColor *) toColor percent:(CGFloat) percent {
    CGFloat red = [self tgtnInterpolationFrom:fromColor.tgtnSegmentedRed to:toColor.tgtnSegmentedRed percent:percent];
    CGFloat green = [self tgtnInterpolationFrom:fromColor.tgtnSegmentedGreen to:toColor.tgtnSegmentedGreen percent:percent];
    CGFloat blue = [self tgtnInterpolationFrom:fromColor.tgtnSegmentedBlue to:toColor.tgtnSegmentedBlue percent:percent];
    CGFloat alpha = [self tgtnInterpolationFrom:fromColor.tgtnSegmentedAlpha to:toColor.tgtnSegmentedAlpha percent:percent];
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
