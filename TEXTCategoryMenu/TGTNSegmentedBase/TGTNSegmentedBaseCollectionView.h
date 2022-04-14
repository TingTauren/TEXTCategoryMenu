//
//  TGTNSegmentedBaseCollectionView.h
//  TGTN
//
//  Created by TGTN on 2022/3/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TGTNSegmentedBaseCollectionView : UICollectionView

/// 数组
@property (nonatomic, strong) NSArray<UIView *> *lineViews;

@end

NS_ASSUME_NONNULL_END
