//
//  NSString+TGTNSegmentedAdd.h
//  TGTN
//
//  Created by TGTN on 2022/3/1.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (TGTNSegmentedAdd)

/// 计算字符串的大小
/// @param size 限制大小
/// @param font 字体
/// @param lSpacing 行间距
/// @param kSpacing 字间距
- (CGSize)tgtnBoundingRectWithSize:(CGSize) size font:(UIFont *) font withlineSpacing:(CGFloat) lSpacing withKernSpacing:(CGFloat) kSpacing;

@end

NS_ASSUME_NONNULL_END
