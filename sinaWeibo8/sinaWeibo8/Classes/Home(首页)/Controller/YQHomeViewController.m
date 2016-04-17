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
#import "YQStatusCell.h"
#import "YQStatusViewModel.h"

@interface YQHomeViewController ()<YQCoverViewDelegate>

@property (nonatomic,weak) YQTitleButton *titleButton;

@property (nonatomic, strong) YQOneViewController *one;


/**
 *  VM：视图模型 YQStatusViewModel
 */
@property (nonatomic, strong) NSMutableArray<YQStatusViewModel *> *statusFrame;

@end

@implementation YQHomeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    // 添加item
    [self setupNavigationItem];
    
    // 取消分隔新
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 获取网络数据
//    [self loadNewStatus];
    
//    // 注册cell
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
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
    if (self.statusFrame.count) {
        YQStatuses *status = [self.statusFrame[0] status]; // 取出视图模型中的 数据模型
        sinceId = [status idstr];
    }
    
    [YQStatusTool newStatusWithSinceId:sinceId success:^(NSArray *statuses) {
        
        // 显示刷新的数据
        [self showNewStatusCount:statuses.count];
        
        // 结束下拉刷新
        [self.tableView.mj_header endRefreshing];
        // ???:??? 视图模型更改
        // 包装数据模型 -> 视图模型
        NSMutableArray *statusFrame = [NSMutableArray array];
        // 遍历传过来的数组
        for (YQStatuses *status in statuses) {
            // 创建视图模型
            YQStatusViewModel *statusF = [[YQStatusViewModel alloc] init];
            statusF.status = status;
            [statusFrame addObject:statusF];
        }
        
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        
        [self.statusFrame insertObjects:statusFrame atIndexes:indexSet];
        
        // 刷新数据
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"数据请求失败--%@",error);
    }];
}

#pragma mark - 上拉加载更多

- (void)loadMoreStatus {
    
    NSString *maxId = nil;
    if (self.statusFrame.count) {
        YQStatuses *status = [self.statusFrame[0] status];
        long long maxID = [[status idstr] longLongValue] - 1;
        
        maxId = [NSString stringWithFormat:@"%lld",maxID];
    }
    
    [YQStatusTool moreStatusWithMaxId:maxId success:^(NSArray *statuses) {
        
        // 结束下拉刷新
        [self.tableView.mj_footer endRefreshing];
        
        NSMutableArray *statusFrame = [NSMutableArray array];
        // 遍历传过来的数组
        for (YQStatuses *status in statuses) {
            // 创建视图模型
            YQStatusViewModel *statusF = [[YQStatusViewModel alloc] init];
            statusF.status = status;
            [statusFrame addObject:statusF];
        }
        
        [self.statusFrame addObjectsFromArray:statusFrame];
        
        // 刷新数据
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"获取数据失败：error%@",error);
    }];
}

#pragma mark - 显示最新的微博数据
- (void)showNewStatusCount:(NSInteger)count {
    
//    if (count == 0) {
//        return;
//    }
    
    CGFloat x = 0;
    CGFloat h = 35;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - h;
    CGFloat w = self.navigationController.navigationBar.width;
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    lable.text = [NSString stringWithFormat:@"最新微博数%ld",count];
    lable.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    lable.textAlignment = NSTextAlignmentCenter;
    // 插入到 navigationBar 上
    [self.navigationController.view insertSubview:lable belowSubview:self.navigationController.navigationBar];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        lable.transform = CGAffineTransformMakeTranslation(0, y);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.25 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
            // 还原
            lable.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            // 移除Lable
            [lable removeFromSuperview];
        }];
        
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

 #pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrame.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *ID = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//    }
    YQStatusCell *cell = [YQStatusCell statusCellWithTableView:tableView];
    
    YQStatusViewModel *statusF = self.statusFrame[indexPath.row];
    
    cell.statuesF = statusF;
    
//    cell.textLabel.text = status.user.name;
//    
//    [cell.imageView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
//    cell.detailTextLabel.text = status.text;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YQStatusViewModel *statusF = self.statusFrame[indexPath.row];
    
    return  statusF.cellHeight;
}

#pragma mark - 控制器懒加载

- (YQOneViewController *)one{
    if (_one == nil) {
        _one = [[YQOneViewController alloc] init];
    }
    return _one;
}

-  (NSMutableArray *)statusFrame {
    if (_statusFrame == nil) {
        _statusFrame = [NSMutableArray array];
    }
    return _statusFrame;
}

@end
