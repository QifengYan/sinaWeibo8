//
//  YQProfileViewController.m
//  sinaWeibo
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQProfileViewController.h"
#import "YQSettingController.h"

@interface YQProfileViewController ()

@end

@implementation YQProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareNavigationItem];
}

/// 加载右边按钮
- (void)prepareNavigationItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:(UIBarButtonItemStylePlain) target:self action:@selector(btnClick)];
    
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark - 监听按钮的点击
- (void)btnClick {
    
    YQSettingController *setting = [[YQSettingController alloc] init];
    
    setting.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:setting animated:YES];
    
}



@end
