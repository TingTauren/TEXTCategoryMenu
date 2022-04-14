//
//  TGTNSegmentedIndicatorImageView.m
//  TGTN
//
//  Created by TGTN on 2022/3/10.
//

#import "TGTNSegmentedIndicatorImageView.h"

@interface TGTNSegmentedIndicatorImageView()
/// 图片
@property (nonatomic, strong) UIImageView *imageView;

/// 是否第一次
@property (nonatomic, assign) BOOL isFirstLayoutSubViews;
@end

@implementation TGTNSegmentedIndicatorImageView

#pragma mark ------ get
- (UIImageView *)imageView {
    if (_imageView) return _imageView;
    _imageView = [UIImageView new];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    return _imageView;
}

#pragma mark ------ set
- (void)setImage:(UIImage *)image {
    _image = image;
    
    self.imageView.image = _image;
}

#pragma mark ------ init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _tgtnInitView];
    }
    return self;
}
/// 初始化视图
- (void)_tgtnInitView {
    _isFirstLayoutSubViews = YES;
    
    [self addSubview:self.imageView];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect targetFrame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.bounds), floor(CGRectGetHeight(self.bounds)));
    if (!CGRectIsEmpty(self.frame) && _isFirstLayoutSubViews) {
        _imageView.frame = targetFrame;
        _isFirstLayoutSubViews = NO;
    } else {
        if (!CGRectEqualToRect(_imageView.frame, targetFrame)) {
            _imageView.frame = targetFrame;
        }
    }
}

#pragma mark ------ Private

#pragma mark ------ Public
/// 设置线条位置
/// @param frame 位置大小
- (void)tgtnSetLineFrame:(CGRect) frame {
    [super tgtnSetLineFrame:frame];
    
    _imageView.frame = self.bounds;
}
/// 改变线条位置
/// @param leftFrame 左边大小
/// @param rightFrame 右边大小
/// @param ratio 比例
- (void)tgtnChangeLineViewFrameWithLeftFrame:(CGRect) leftFrame rightFrame:(CGRect) rightFrame ratio:(float) ratio {
    [super tgtnChangeLineViewFrameWithLeftFrame:leftFrame rightFrame:rightFrame ratio:ratio];
    
    _imageView.frame = self.bounds;
}

@end
