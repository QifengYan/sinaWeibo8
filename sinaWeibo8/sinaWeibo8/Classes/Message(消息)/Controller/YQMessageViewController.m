//
//  YQMessageViewController.m
//  sinaWeibo
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQMessageViewController.h"

@interface YQMessageViewController ()

@end

@implementation YQMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareNavigationItem];
    
}

/// 加载右边按钮
- (void)prepareNavigationItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"发起聊天" style:(UIBarButtonItemStylePlain) target:self action:@selector(btnClick)];
    
    self.navigationItem.rightBarButtonItem = item;
}

- (void)btnClick {
    QFLog(@"%s",__func__);
}

@end
