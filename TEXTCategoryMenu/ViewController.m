//
//  ViewController.m
//  TEXTCategoryMenu
//
//  Created by Mac on 2022/1/27.
//

#import "ViewController.h"

#import "NextViewController.h"
#import "SpeciallyViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
/// 列表数据
@property (nonatomic, strong) NSArray *listData;
/// 列表视图
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

#pragma mark ------ get
- (NSArray *)listData {
    if (_listData) return _listData;
    _listData = @[@"固定长度", @"cell同宽", @"延长线条", @"延长+偏移", @"椭圆型", @"椭圆型边框", @"渐变色", @"少量", @"图片", @"特殊视图"];
    return _listData;
}
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
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    _tableView.frame = CGRectMake(0.0, 100.0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100.0);
}

#pragma mark ------ UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"ViewControllerTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = [self.listData objectAtIndex:indexPath.row];
    
    return cell;
}
#pragma mark ------ UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str = [self.listData objectAtIndex:indexPath.row];
    
    if ([str isEqualToString:@"特殊视图"]) {
        SpeciallyViewController *speciallyVc = [SpeciallyViewController new];
        speciallyVc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:speciallyVc animated:YES completion:nil];
        return;
    }
    
    NextViewController *nextVc = [NextViewController new];
    nextVc.typeStr = str;
    nextVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nextVc animated:YES completion:nil];
}


@end
