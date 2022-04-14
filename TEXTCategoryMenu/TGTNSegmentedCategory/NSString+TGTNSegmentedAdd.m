//
//  NSString+TGTNSegmentedAdd.m
//  TGTN
//
//  Created by TGTN on 2022/3/1.
//

#import "NSString+TGTNSegmentedAdd.h"

@implementation NSString (TGTNSegmentedAdd)

/// 计算字符串的大小
/// @param size 限制大小
/// @param font 字体
/// @param lSpacing 行间距
/// @param kSpacing 字间距
- (CGSize)tgtnBoundingRectWithSize:(CGSize) size font:(UIFont *) font withlineSpacing:(CGFloat) lSpacing withKernSpacing:(CGFloat) kSpacing {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
    // 设置行间距
    paraStyle.lineSpacing = fmax(lSpacing, 0.0);
    // 设置字间距和字体大小和行间距
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@(fmax(kSpacing, 0.0))};
    // 转换为富文本字符
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self attributes:dic];
    // 计算字符大小
    CGSize attributedStringSize = [attributedString boundingRectWithSize:size options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    attributedStringSize = CGSizeMake(ceil(attributedStringSize.width) + 1.0, ceil(attributedStringSize.height) + 1.0);
    return attributedStringSize;
}

@end
