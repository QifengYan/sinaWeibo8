//
//  YQTabBarController.m
//  sinaWeibo
//
//  Created by apple on 16/2/2.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQTabBarController.h"
#import "UIImage+YQImage.h"
#import "YQTabBar.h"
#import "YQHomeViewController.h"
#import "YQDiscoverViewController.h"
#import "YQMessageViewController.h"
#import "YQProfileViewController.h"

@interface YQTabBarController ()

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, weak) YQHomeViewController *home;
@end

@implementation YQTabBarController

//+ (void)initialize {
//    // 获得全局的tabBarItem
////    UITabBarItem *item = [UITabBarItem appearance];
//    // 获取当前这个类所以的tabBarItem
//    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
//    
//    NSDictionary *att = @{
//                          NSForegroundColorAttributeName:[UIColor orangeColor],
//                          };
//    //    [attDict setObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
//    [item setTitleTextAttributes:att forState:UIControlStateSelected];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载子控制器
    [self setupChildViewController];
    
    // 加载自定义的tabBar
    [self setupTabBar];

}

#pragma mark - 加载自定义tabBar
- (void)setupTabBar
{
    YQTabBar *tabBar = [[YQTabBar alloc] initWithFrame:self.tabBar.frame];
    
    tabBar.items = self.items;
    
//    [tabBar setDidSelectedBtn:^(NSUInteger index) {
//        self.selectedIndex = index;
//    }];
    
    [tabBar setBackgroundColor:[UIColor whiteColor]];
    
    //    tabBar.tabBarButtonCount = self.viewControllers.count;
    
    //    NSLog(@"%@",self.tabBar);
    //    self.tabBar = tabBar;  只读属性不允许直接修改 通过kvc
    //    [self setValue:tabBar forKeyPath:@"tabBar"];
    // 移除系统的tabBar
    [self.tabBar removeFromSuperview];
    // 添加自定义的tabBar
    [self.view addSubview:tabBar];
    //    NSLog(@"%@",self.tabBar);
}

#pragma mark - 加载子控制器 -
- (void)setupChildViewController {
    // 创建子控制器
    // 主界面
    YQHomeViewController *homeVC = [[YQHomeViewController alloc] init];
    [self setupOneChildViewController:homeVC image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageWithOriginalNamed:@"tabbar_home_selected"] title:@"主页"];
    _home = homeVC;
    // 消息
    YQMessageViewController *messageVC = [[YQMessageViewController alloc] init];
//    messageVC.tabBarItem.title = @"消息";
//    [self addChildViewController:messageVC];
    [self setupOneChildViewController:messageVC image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageWithOriginalNamed:@"tabbar_message_center_selected"] title:@"消息"];
    
    // 发现
    YQDiscoverViewController *discoverVC = [[YQDiscoverViewController alloc] init];
//    [self addChildViewController:discoverVC];
    [self setupOneChildViewController:discoverVC image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalNamed:@"tabbar_discover_selected"] title:@"发现"];
    
    // 我
    YQProfileViewController *profileVC = [[YQProfileViewController alloc] init];
//    [self addChildViewController:profileVC];tabbar_profile
    [self setupOneChildViewController:profileVC image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalNamed:@"tabbar_profile_selected"] title:@"我"];

}
 
- (void)setupOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title {
    
//    vc.navigationItem.title = title;
//    vc.tabBarItem.title = title;
    vc.title = title;
    
    vc.tabBarItem.image = image;
    
    vc.tabBarItem.selectedImage = selectedImage;
//    vc.tabBarItem.badgeValue = @"10";
    // 保存tabBarItem 到数组中
    [self.items addObject:vc.tabBarItem];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];

}

#pragma mark - items 懒加载 -

- (NSMutableArray *)items {
      
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}


@end
