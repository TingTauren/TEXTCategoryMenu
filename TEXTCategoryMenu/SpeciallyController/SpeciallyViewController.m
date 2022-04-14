//
//  SpeciallyViewController.m
//  TEXTCategoryMenu
//
//  Created by Mac on 2022/3/8.
//

#import "SpeciallyViewController.h"

#import "SpeciallyTableView.h"
#import "SpeciallyViewTableCell.h"

#import "TGTNSegmentedBaseTitleView.h"
#import "TGTNSegmentedIndicatorLineView.h"

@interface SpeciallyViewController ()<UITableViewDelegate, UITableViewDataSource>
/// 返回按钮
@property (nonatomic, strong) UIButton *backButton;
/// 右边按钮
@property (nonatomic, strong) UIButton *rightButton;
/// 列表视图
@property (nonatomic, strong) SpeciallyTableView *tableView;

/// 头部视图
@property (nonatomic, strong) UIView *headerView;
/// 分段视图
@property (nonatomic, strong) TGTNSegmentedBaseTitleView *segmentView;
@end

@implementation SpeciallyViewController

- (UIButton *)backButton {
    if (_backButton) return _backButton;
    _backButton = [UIButton new];
    [_backButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
    [_backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_backButton setTitle:@"返回" forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    return _backButton;
}
- (UIButton *)rightButton {
    if (_rightButton) return _rightButton;
    _rightButton = [UIButton new];
    [_rightButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
    [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_rightButton setTitle:@"加header" forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    return _rightButton;
}

- (SpeciallyTableView *)tableView {
    if (_tableView) return _tableView;
    _tableView = [[SpeciallyTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor redColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    return _tableView;
}
- (UIView *)headerView {
    if (_headerView) return _headerView;
    _headerView = [UIView new];
    _headerView.frame = CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width, 200.0);
    _headerView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    [_headerView addSubview:self.segmentView];
    return _headerView;
}
- (TGTNSegmentedBaseTitleView *)segmentView {
    if (_segmentView) return _segmentView;
    _segmentView = [TGTNSegmentedBaseTitleView new];
    _segmentView.frame = CGRectMake(0.0, 200.0-64.0, [UIScreen mainScreen].bounds.size.width, 64.0);
    _segmentView.backgroundColor = [UIColor blackColor];
    /// 默认标题颜色(默认:whiteColor)
    _segmentView.normalTitleColor = [UIColor whiteColor];
    /// 选中标题颜色(默认:blackColor)
    _segmentView.selectTitleColor = [UIColor brownColor];
    _segmentView.titleList = @[@"螃蟹", @"麻辣小龙虾", @"鱼", @"波斯顿大龙虾", @"东星斑", @"深海巨物帝王蟹"];
    
    TGTNSegmentedIndicatorLineView *lineView = [TGTNSegmentedIndicatorLineView new];
    lineView.backgroundColor = [UIColor redColor];
    lineView.lineHeight = 6.0;
    lineView.incrementMargin = 5.0;
    _segmentView.lineViews = @[lineView];
    return _segmentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.backButton];
    _backButton.frame = CGRectMake(20.0, 44.0, 80.0, 50.0);
    
    [self.view addSubview:self.rightButton];
    _rightButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 100.0, 44.0, 80.0, 50.0);
    
    [self.view addSubview:self.tableView];
    _tableView.frame = CGRectMake(0.0, 94.0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 94.0 - 32.0);
}

#pragma mark ------ UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"SpeciallyViewCellIndentify";
    SpeciallyViewTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SpeciallyViewTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(cell) weakCell = cell;
    cell.childScrollDidScrollConfig = ^(UIScrollView * _Nonnull scrollView, NSInteger index) {
        __strong typeof(weakSelf) self = weakSelf;
        __strong typeof(weakCell) cell = weakCell;
        
        NSLog(@"%f - ", self.tableView.contentOffset.y);
        NSLog(@"- %f", scrollView.contentOffset.y);
        
        if (scrollView.contentOffset.y > 0 && self.tableView.contentOffset.y < CGRectGetHeight(self.headerView.bounds)) {
            scrollView.contentOffset = CGPointMake(0.0, 0.0);
        }
    };
    
    return cell;
}
#pragma mark ------ UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ([UIScreen mainScreen].bounds.size.height - 94.0 - 32.0);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark ------ UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y >= CGRectGetHeight(_headerView.bounds)) {
        scrollView.contentOffset = CGPointMake(0.0, CGRectGetHeight(_headerView.bounds));
    }
}

#pragma mark ------ Click
- (void)backButtonClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)rightButtonClick {
    _tableView.tableHeaderView = self.headerView;
    _segmentView.contentScrollView = [((SpeciallyViewTableCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]) tgtnGetScrollView];
    [_tableView reloadData];
}

@end
