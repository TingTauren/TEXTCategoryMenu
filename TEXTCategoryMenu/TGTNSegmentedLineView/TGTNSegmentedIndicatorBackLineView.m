//
//  TGTNSegmentedIndicatorBackLineView.m
//  TGTN
//
//  Created by TGTN on 2022/3/5.
//

#import "TGTNSegmentedIndicatorBackLineView.h"

@implementation TGTNSegmentedIndicatorBackLineView

/// 设置线条位置
/// @param frame 位置大小
- (void)tgtnSetLineFrame:(CGRect) frame {
    [super tgtnSetLineFrame:frame];
    
    NSInteger colorIndex = self.selectIndex % _backColors.count;
    self.backgroundColor = [_backColors objectAtIndex:colorIndex];
}
/// 改变线条位置
/// @param leftFrame 左边大小
/// @param rightFrame 右边大小
/// @param ratio 比例
- (void)tgtnChangeLineViewFrameWithLeftFrame:(CGRect) leftFrame rightFrame:(CGRect) rightFrame ratio:(float) ratio {
    [super tgtnChangeLineViewFrameWithLeftFrame:leftFrame rightFrame:rightFrame ratio:ratio];
    
    NSInteger leftColorIndex = self.leftIndex % _backColors.count;
    NSInteger rightColorIndex = self.rightIndex % _backColors.count;
    UIColor *leftColor = [_backColors objectAtIndex:leftColorIndex];
    UIColor *rightColor = [_backColors objectAtIndex:rightColorIndex];
    UIColor *color = [UIColor tgtnInterpolationColorFrom:leftColor to:rightColor percent:ratio];
    
    self.backgroundColor = color;
}

@end
