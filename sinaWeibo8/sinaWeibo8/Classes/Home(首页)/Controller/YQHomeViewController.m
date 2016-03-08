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

@interface YQHomeViewController ()<YQCoverViewDelegate>

@property (nonatomic,weak) YQTitleButton *titleButton;

@property (nonatomic, strong) YQOneViewController *one;

@end

@implementation YQHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加item
    [self setupNavigationItem];
}

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
    [btn setTitle:@"首页" forState:UIControlStateNormal];
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

/**
 *  监听左边按钮的点击
 */
- (void)friendsearch
{
    [self.titleButton setTitle:@"爸鼻我要喝奶奶" forState:UIControlStateNormal];
}

/**
 *  监听右边按钮的点击
 */
- (void)pop
{
    
}

- (YQOneViewController *)one
{
    if (_one == nil) {
        _one = [[YQOneViewController alloc] init];
    }
    return _one;
}

@end
