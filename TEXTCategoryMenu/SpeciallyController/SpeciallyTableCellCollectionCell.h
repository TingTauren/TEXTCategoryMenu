//
//  SpeciallyTableCellCollectionCell.h
//  TEXTCategoryMenu
//
//  Created by Mac on 2022/3/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SpeciallyTableCellCollectionCell : UICollectionViewCell

/// 滚动回调
@property (nonatomic, copy) void(^ _Nullable childScrollDidScrollConfig)(UIScrollView *scrollView);

@end

NS_ASSUME_NONNULL_END
