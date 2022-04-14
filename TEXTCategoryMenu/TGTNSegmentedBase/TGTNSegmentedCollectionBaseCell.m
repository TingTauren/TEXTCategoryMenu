//
//  TGTNSegmentedCollectionBaseCell.m
//  TGTN
//
//  Created by TGTN on 2022/2/23.
//

#import "TGTNSegmentedCollectionBaseCell.h"

@interface TGTNSegmentedCollectionBaseCell()
/// 数据模型
@property (nonatomic, readwrite) TGTNSegmentedBaseCellModel *model;
@end

@implementation TGTNSegmentedCollectionBaseCell

#pragma mark ------ get

#pragma mark ------ set

#pragma mark ------ init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self tgtnInitView];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self tgtnInitView];
    }
    return self;
}
/// 初始化视图
- (void)tgtnInitView {
}

#pragma mark ------ Private

#pragma mark ------ Public
/// 设置数据源
- (void)tgtnSetModel:(id)model {
    _model = model;
    
    self.backgroundColor = (_model.isSelect ? _model.selectBackColor : _model.normalBackColor);
}

@end
