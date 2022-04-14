//
//  TGTNSegmentedIndicatorLineView.m
//  TGTN
//
//  Created by TGTN on 2022/3/4.
//

#import "TGTNSegmentedIndicatorLineView.h"

@implementation TGTNSegmentedIndicatorLineView

#pragma mark ------ Public
/// 设置线条位置
/// @param frame 位置大小
- (void)tgtnSetLineFrame:(CGRect) frame {
    float selectLineWidth = [self tgtnLineWidthValue:frame];
    float x = CGRectGetMinX(frame)  + (CGRectGetWidth(frame) - selectLineWidth)/2.0;
    float y = (CGRectGetHeight(frame) - [self tgtnLineHeightValue:frame]);
    if (_type == TGTNSegmentedIndicatorLineTypeCenter) {
        y = (CGRectGetHeight(frame) - [self tgtnLineHeightValue:frame])/2.0;
    }
    if (_type == TGTNSegmentedIndicatorLineTypeTop) {
        y = 0 + self.incrementMargin;
    } else if (_type == TGTNSegmentedIndicatorLineTypeDefault) {
        y = y - self.incrementMargin;
    }
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
    
    if (_scrollType == TGTNSegmentedIndicatorLineScrollTypeDefault) {
        [super tgtnChangeLineViewFrameWithLeftFrame:leftFrame rightFrame:rightFrame ratio:ratio];
    } else if (_scrollType == TGTNSegmentedIndicatorLineScrollTypeLengthen) {
        float maxWidth = rightX - leftX + rightWidth;
        
        if (ratio <= 0.5) {
            targetX = leftX;
            targetWidth = [UIColor tgtnInterpolationFrom:leftWidth to:maxWidth percent:ratio*2.0];
        } else {
            targetX = [UIColor tgtnInterpolationFrom:leftX to:rightX percent:(ratio - 0.5)*2.0];
            targetWidth = [UIColor tgtnInterpolationFrom:maxWidth to:rightWidth percent:(ratio - 0.5)*2.0];
        }
        
        CGRect lineFrame = self.frame;
        lineFrame.origin.x = targetX;
        lineFrame.size.width = targetWidth;
        self.frame = lineFrame;
    } else if (_scrollType == TGTNSegmentedIndicatorLineScrollTypeLengthenOffset) {
        float offsetX = 20.0;
        float maxWidth = rightX - leftX + rightWidth - offsetX * 2.0;
        
        if (ratio <= 0.5) {
            targetX = [UIColor tgtnInterpolationFrom:leftX to:leftX + offsetX percent:ratio*2.0];
            targetWidth = [UIColor tgtnInterpolationFrom:leftWidth to:maxWidth percent:ratio*2.0];
        } else {
            targetX = [UIColor tgtnInterpolationFrom:(leftX + offsetX) to:rightX percent:(ratio - 0.5)*2.0];
            targetWidth = [UIColor tgtnInterpolationFrom:maxWidth to:rightWidth percent:(ratio - 0.5)*2.0];
        }
        
        CGRect lineFrame = self.frame;
        lineFrame.origin.x = targetX;
        lineFrame.size.width = targetWidth;
        self.frame = lineFrame;
    }
}

@end
