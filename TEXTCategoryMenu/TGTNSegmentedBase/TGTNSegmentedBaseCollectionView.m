//
//  TGTNSegmentedBaseCollectionView.m
//  TGTN
//
//  Created by TGTN on 2022/3/5.
//

#import "TGTNSegmentedBaseCollectionView.h"

@implementation TGTNSegmentedBaseCollectionView

- (void)setLineViews:(NSArray<UIView *> *)lineViews {
    for (UIView *view in _lineViews) {
        // 移除之前添加的view
        [view removeFromSuperview];
    }
    
    _lineViews = lineViews;
    
    for (UIView *view in _lineViews) {
        // 添加视图
        [self addSubview:view];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (UIView *view in _lineViews) {
        [self sendSubviewToBack:view];
    }
}

@end
