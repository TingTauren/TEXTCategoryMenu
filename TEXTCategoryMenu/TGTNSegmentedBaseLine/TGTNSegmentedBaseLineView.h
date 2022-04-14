//
//  TGTNSegmentedBaseLineView.h
//  TGTN
//
//  Created by TGTN on 2022/3/3.
//

#import "TGTNSegmentedBaseView.h"

#import "TGTNSegmentedCollectionBaseLineCell.h"

#import "TGTNSegmentedBaseIndicatorView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGTNSegmentedBaseLineView : TGTNSegmentedBaseView

/// 数组
@property (nonatomic, strong) NSArray<TGTNSegmentedBaseIndicatorView *> *lineViews;

@end

NS_ASSUME_NONNULL_END
