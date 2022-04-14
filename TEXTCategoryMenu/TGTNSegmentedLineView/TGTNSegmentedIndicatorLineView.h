//
//  TGTNSegmentedIndicatorLineView.h
//  TGTN
//
//  Created by TGTN on 2022/3/4.
//

#import "TGTNSegmentedBaseIndicatorView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TGTNSegmentedIndicatorLineType) {
    TGTNSegmentedIndicatorLineTypeDefault,
    TGTNSegmentedIndicatorLineTypeTop,
    TGTNSegmentedIndicatorLineTypeCenter,
};

typedef NS_ENUM(NSInteger, TGTNSegmentedIndicatorLineScrollType) {
    TGTNSegmentedIndicatorLineScrollTypeDefault,
    TGTNSegmentedIndicatorLineScrollTypeLengthen,
    TGTNSegmentedIndicatorLineScrollTypeLengthenOffset,
};

@interface TGTNSegmentedIndicatorLineView : TGTNSegmentedBaseIndicatorView

/// 类型
@property (nonatomic, assign) TGTNSegmentedIndicatorLineType type;

/// 滚动类型
@property (nonatomic, assign) TGTNSegmentedIndicatorLineScrollType scrollType;

@end

NS_ASSUME_NONNULL_END
