//
//  TGTNSegmentedBaseIndicatorView.m
//  TGTN
//
//  Created by TGTN on 2022/3/4.
//

#import "TGTNSegmentedBaseIndicatorView.h"

@implementation TGTNSegmentedBaseIndicatorView

#pragma mark ------ get

#pragma mark ------ set

#pragma mark ------ init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _tgtnInitView];
        [self _tgtnInitEvent];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self _tgtnInitView];
        [self _tgtnInitEvent];
    }
    return self;
}
/// 初始化视图
- (void)_tgtnInitView {
    self.userInteractionEnabled = NO;
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0];
    
    /// 线条宽度
    _lineWidth = -1.0;
    /// 线条高度
    _lineHeight = -1.0;
    /// 线条圆角
    _lineRadius = -1.0;
    /// 补偿宽度
    _incrementWidth = 0.0;
    /// 补偿边距
    _incrementMargin = 0.0;
}
/// 添加事件
- (void)_tgtnInitEvent {
}

#pragma mark ------ Private

#pragma mark ------ Public
- (float)tgtnLineWidthValue:(CGRect) cellFrame {
    if (_lineWidth == -1.0) {
        return cellFrame.size.width + _incrementWidth;
    }
    return _lineWidth;
}
- (float)tgtnLineHeightValue:(CGRect) cellFrame {
    if (_lineHeight == -1.0) {
        return cellFrame.size.height;
    }
    return _lineHeight;
}
- (float)tgtnLineRadiusValue:(CGRect) cellFrame {
    if (_lineRadius == -1.0) {
        return [self tgtnLineHeightValue:cellFrame]/2.0;
    }
    return _lineRadius;
}

#pragma mark ------ Public
/// 设置线条位置
/// @param frame 位置大小
- (void)tgtnSetLineFrame:(CGRect) frame {
    float selectLineWidth = [self tgtnLineWidthValue:frame];
    float x = CGRectGetMinX(frame)  + (CGRectGetWidth(frame) - selectLineWidth)/2.0;
    float y = CGRectGetHeight(frame) - [self tgtnLineHeightValue:frame];
    y = y - self.incrementMargin;
    self.frame = CGRectMake(x, y, selectLineWidth, [self tgtnLineHeightValue:frame]);
}
/// 改变线条位置
/// @param leftFrame 左边大小
/// @param rightFrame 右边大小
/// @param ratio 比例
- (void)tgtnChangeLineViewFrameWithLeftFrame:(CGRect) leftFrame rightFrame:(CGRect) rightFrame ratio:(float) ratio {
    float targetX = CGRectGetMinX(leftFrame);
    float targetWidth = [self tgtnLineWidthValue:leftFrame];
    
    float leftWidth = targetWidth;
    float rightWidth = [self tgtnLineWidthValue:rightFrame];
    float leftX = CGRectGetMinX(leftFrame) + (CGRectGetWidth(leftFrame) - leftWidth)/2.0;
    float rightX = CGRectGetMinX(rightFrame) + (CGRectGetWidth(rightFrame) - rightWidth)/2.0;
    
    targetX = [UIColor tgtnInterpolationFrom:leftX to:rightX percent:ratio];
    targetWidth = [UIColor tgtnInterpolationFrom:leftWidth to:rightWidth percent:ratio];
    
    CGRect lineFrame = self.frame;
    lineFrame.origin.x = targetX;
    lineFrame.size.width = targetWidth;
    self.frame = lineFrame;
}

@end
