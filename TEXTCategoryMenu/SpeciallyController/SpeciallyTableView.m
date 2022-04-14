//
//  SpeciallyTableView.m
//  TEXTCategoryMenu
//
//  Created by Mac on 2022/3/8.
//

#import "SpeciallyTableView.h"

@interface SpeciallyTableView()<UIGestureRecognizerDelegate>
@end

@implementation SpeciallyTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]);
}

@end
