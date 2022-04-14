//
//  TGTNSegmentedCollectionBaseTitleCell.m
//  TGTN
//
//  Created by TGTN on 2022/3/3.
//

#import "TGTNSegmentedCollectionBaseTitleCell.h"

@interface TGTNSegmentedCollectionBaseTitleCell()
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation TGTNSegmentedCollectionBaseTitleCell

#pragma mark ------ get
- (UILabel *)titleLabel {
    if (_titleLabel) return _titleLabel;
    _titleLabel = [UILabel new];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.clipsToBounds = YES;
    return _titleLabel;
}

#pragma mark ------ set

#pragma mark ------ init
/// 初始化视图
- (void)tgtnInitView {
    [super tgtnInitView];
    
    [self.contentView addSubview:self.titleLabel];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
}

#pragma mark ------ Private

#pragma mark ------ Public
- (void)tgtnSetModel:(id)model {
    [super tgtnSetModel:model];
    
    TGTNSegmentedBaseTitleCellModel *dataModel = (TGTNSegmentedBaseTitleCellModel *)self.model;
    
    _titleLabel.text = dataModel.title;
    
    UIFont *maxScaleFont = [UIFont fontWithDescriptor:dataModel.titleFont.fontDescriptor size:dataModel.titleFont.pointSize*self.model.titleSelectZoomScale];
    float baseScale = dataModel.titleFont.lineHeight/maxScaleFont.lineHeight;
    
    _titleLabel.font = maxScaleFont;
    CGAffineTransform currentTransform = CGAffineTransformMakeScale(baseScale*self.model.titleCurrentZoomScale, baseScale*self.model.titleCurrentZoomScale);
    _titleLabel.transform = currentTransform;
    
    _titleLabel.textColor = (dataModel.isSelect ? dataModel.selectTitleColor : dataModel.normalTitleColor);
}

@end
