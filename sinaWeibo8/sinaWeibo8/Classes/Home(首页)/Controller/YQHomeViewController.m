//
//  YQHomeViewController.m
//  sinaWeibo
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//



#import "YQHomeViewController.h"
#import "YQTitleButton.h"
#import "YQPopMenu.h"
#import "YQCoverView.h"
#import "YQOneViewController.h"
#import "AFNetworking.h"
#import "YQAccountTool.h"
#import "YQAccount.h"
#import "MJExtension.h"
#import "YQStatuses.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "YQHttpTool.h"
#import "YQAccount.h"
#import "YQAccountTool.h"

#import "YQStatusTool.h"
#import "YQUserTool.h"

@interface YQHomeViewController ()<YQCoverViewDelegate>

@property (nonatomic,weak) YQTitleButton *titleButton;

@property (nonatomic, strong) YQOneViewController *one;

@property (nonatomic, strong) NSMutableArray *statuses;

@end

@implementation YQHomeViewController

static NSString *ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加item
    [self setupNavigationItem];
    
    // 获取网络数据
//    [self loadNewStatus];
    
    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    // 下拉刷星
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewStatus)];
    
    // 开启下拉刷新
    [self.tableView.mj_header beginRefreshing];
    
    // 上拉加载跟多
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreStatus)];
    
    [YQUserTool usersInfoWithUrl:@"https://api.weibo.com/2/users/show.json" success:^(YQUser *user) {
        
        // 设置标题
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        
        // 获取账号 保存用户昵称
        YQAccount *account = [YQAccountTool account];
        account.name = user.name;
        
        [YQAccountTool saveAccount:account];
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)refresh {
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 获取最新微博数据
- (void)loadNewStatus {
    
    NSString *sinceId = nil;
    if (self.statuses.count) {
        sinceId = [self.statuses[0] idstr];
    }
    
    [YQStatusTool newStatusWithSinceId:sinceId success:^(NSArray *statuses) {
        // 结束下拉刷新
        [self.tableView.mj_header endRefreshing];
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        
        [self.statuses insertObjects:statuses atIndexes:indexSet];
        
        // 刷新数据
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"数据请求失败--%@",error);
    }];
}

#pragma mark - 上拉加载更多

- (void)loadMoreStatus {
    
    NSString *maxId = nil;
    if (self.statuses.count) {
        long long maxID = [[[self.statuses lastObject] idstr] longLongValue] - 1;
        
        maxId = [NSString stringWithFormat:@"%lld",maxID];
    }
    
    [YQStatusTool moreStatusWithMaxId:maxId success:^(NSArray *statuses) {
        
        // 结束下拉刷新
        [self.tableView.mj_footer endRefreshing];
        
        [self.statuses addObjectsFromArray:statuses];
        
        // 刷新数据
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"获取数据失败：error%@",error);
    }];
}


#pragma mark - 添加左右按钮
/**
 *  添加item
 */
- (void)setupNavigationItem
{
    // 添加左边导航条按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highlightedImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendsearch) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加右边导航条按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highlightedImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    // 自定义title 按钮
    YQTitleButton *btn = [YQTitleButton buttonWithType:UIButtonTypeCustom];
    _titleButton = btn;
    btn.adjustsImageWhenHighlighted = NO;// 取消按钮点击时候图片高亮效果
    NSLog(@"name -- %@",[YQAccountTool account].name);
    NSString *title = [YQAccountTool account].name ?  : @"首页";
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    [btn sizeToFit];
    self.navigationItem.titleView = btn;
    [btn addTarget:self action:@selector(titleButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];// 添加点击事件
}

- (void)titleButtonDidClick:(UIButton *)button
{
    button.selected = !button.selected;
    
    // 添加蒙版
    YQCoverView *coverView = [YQCoverView show];
    
    coverView.delegate = self;
    
//    coverView.dimBackground = YES;
    
    // 弹出pop菜单
    CGFloat popW = YQPopViewWidth;
    CGFloat popH = popW;
    CGFloat popX = (self.view.width - popW) * 0.5;
    CGFloat popY = YQPopViewY;
    
    YQPopMenu *pop = [YQPopMenu showInRect:CGRectMake(popX, popY, popW, popH)];
    pop.userInteractionEnabled = YES; 
    pop.contentView = self.one.view;
}

#pragma mark - YQCoverViewDelegate -

- (void)coverViewDidClick:(YQCoverView *)coverView
{
    // 将pop菜单移除
    [YQPopMenu hidden];
    _titleButton.selected = NO;
}

#pragma mark - 监听按钮的点击

/**
 *  监听左边按钮的点击
 */
- (void)friendsearch
{
   
}

/**
 *  监听右边按钮的点击
 */
- (void)pop
{
    
}

#pragma mark - 控制器懒加载

- (YQOneViewController *)one{
    if (_one == nil) {
        _one = [[YQOneViewController alloc] init];
    }
    return _one;
}

-  (NSMutableArray *)statuses {
    if (_statuses == nil) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}

 #pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    YQStatuses *status = self.statuses[indexPath.row];
    
    cell.textLabel.text = status.user.name;
    
    [cell.imageView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
//    cell.detailTextLabel.text = status.text;
    
    return cell;
}

@end
