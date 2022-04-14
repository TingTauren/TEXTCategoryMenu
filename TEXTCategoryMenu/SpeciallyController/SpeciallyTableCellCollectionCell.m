//
//  SpeciallyTableCellCollectionCell.m
//  TEXTCategoryMenu
//
//  Created by Mac on 2022/3/8.
//

#import "SpeciallyTableCellCollectionCell.h"

@interface SpeciallyTableCellCollectionCell()<UITableViewDelegate, UITableViewDataSource>
/// 列表视图
@property (nonatomic, strong) UITableView *tableView;

/// 是否第一次
@property (nonatomic, assign) BOOL isFirstLoad;
@end

@implementation SpeciallyTableCellCollectionCell

#pragma mark ------ get
- (UITableView *)tableView {
    if (_tableView) return _tableView;
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    return _tableView;
}

#pragma mark ------ set

#pragma mark ------ init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _tgtnInitView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect targetFrame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.bounds), floor(CGRectGetHeight(self.bounds)));
    if (!CGRectIsEmpty(self.frame) && _isFirstLoad) {
        _tableView.frame = targetFrame;
        _isFirstLoad = NO;
        
        [_tableView reloadData];
    } else {
        if (!CGRectEqualToRect(_tableView.frame, targetFrame)) {
            _tableView.frame = targetFrame;
            
            [_tableView reloadData];
        }
    }
}
/// 初始化视图
- (void)_tgtnInitView {
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0];
    
    _isFirstLoad = YES;
    
    [self.contentView addSubview:self.tableView];
}

#pragma mark ------ UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"SpeciallyTableCellCollectionTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    
    return cell;
}
#pragma mark ------ UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_tableView]) {
        if (_childScrollDidScrollConfig) {
            _childScrollDidScrollConfig(scrollView);
        }
    }
}

#pragma mark ------ Private

#pragma mark ------ Public

@end
