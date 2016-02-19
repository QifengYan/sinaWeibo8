//
//  YQHomeViewController.m
//  sinaWeibo
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQHomeViewController.h"
#import "YQTitleButton.h"

@interface YQHomeViewController ()

@property (nonatomic,weak) YQTitleButton *titleButton;

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
    
    YQTitleButton *btn = [YQTitleButton buttonWithType:UIButtonTypeCustom];
    _titleButton = btn;
    [btn setTitle:@"首页" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    [btn sizeToFit];
    self.navigationItem.titleView = btn;
}

/**
 *  监听左边按钮的点击
 */
- (void)friendsearch
{
    [self.titleButton setTitle:@"我要吃奶奶" forState:UIControlStateNormal];
}

/**
 *  监听右边按钮的点击
 */
- (void)pop
{
    
}
@end
