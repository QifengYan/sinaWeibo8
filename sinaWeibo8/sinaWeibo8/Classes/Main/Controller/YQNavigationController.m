//
//  YQNavigationController.m
//  sinaWeibo8
//
//  Created by apple on 16/3/8.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQNavigationController.h"
#import "YQTabBarController.h"
@interface YQNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) id popDelegate;

@end

@implementation YQNavigationController

+ (void)initialize {
    
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:nil, nil];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 记录代理
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    
    self.delegate = self;
    
}

#pragma mark - UINavigationControllerDelegate 代理方法

// 导航栏即将显示新的控制器的时候调用
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 获取根控制器
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    YQTabBarController *tabBarVC = (YQTabBarController *)keyWindow.rootViewController;
    
    for (UIView *tabBar in tabBarVC.tabBar.subviews) {
        if ([tabBar isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBar removeFromSuperview];
        }
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    } else {
        // 实现滑动返回功能
        // 如果 导航栏左边View 被设置了  就不能实现滑动返回了  必须要把代理制为空 才能实现
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

#pragma mark - 重写push 方法 设置导航栏左右按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count != 0) {
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highlightedImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(backPre) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highlightedImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(backRoot )forControlEvents:UIControlEventTouchUpInside];
    }
    // 这调用父类的 要放在最后面 如果是放在最前面 会出现问题
    [super pushViewController:viewController animated:animated];
    
}

- (void)backPre {
    [self popViewControllerAnimated:YES];
}


- (void)backRoot {
    [self popToRootViewControllerAnimated:YES];
}

@end
