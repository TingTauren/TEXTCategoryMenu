//
//  TGTNSegmentedCollectionBaseCell.h
//  TGTN
//
//  Created by TGTN on 2022/2/23.
//

#import <UIKit/UIKit.h>

#import "TGTNSegmentedBaseCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGTNSegmentedCollectionBaseCell : UICollectionViewCell

/// 数据模型
@property (nonatomic, readonly) TGTNSegmentedBaseCellModel *model;

/// 初始化视图
- (void)tgtnInitView;

/// 设置数据源
- (void)tgtnSetModel:(id)model;

@end

NS_ASSUME_NONNULL_END
