//
//  YQDiscoverViewController.m
//  sinaWeibo
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQDiscoverViewController.h"
#import "YQSearch.h"

@interface YQDiscoverViewController ()

@end

@implementation YQDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDiscover];
}

#pragma mark -  设置 搜索
- (void)loadDiscover {
    YQSearch *search = [[YQSearch alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 35)];
    search.placeholder = @"大家都在搜";
    self.navigationItem.titleView = search;
}

@end
