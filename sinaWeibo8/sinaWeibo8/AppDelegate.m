//
//  AppDelegate.m
//  sinaWeibo
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#define NEW_VERSION @"newVersion"

#import "AppDelegate.h"
#import "YQTabBarController.h"
#import "YQNewFeatureController.h"
#import "YQWelcomeController.h"
#import "YQOauthController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 设置颜色
    // 创建一个tabBarController （不需要根控制器，导航控制器才需要根控制器）；
//    YQTabBarController *tabBarVC = [[YQTabBarController alloc] init];
//    // 指定根控制器
//    self.window.rootViewController = tabBarVC;
    self.window.rootViewController = [[YQOauthController alloc] init];
    // 展示窗口
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)isNewVertion {
  
    // 获得系统版本
    NSString * version = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    // 获取当前版本
    NSString *currentVersion = [[NSUserDefaults standardUserDefaults] stringForKey:NEW_VERSION];
    
    // 判断系统版本是否和当前版本一致
    BOOL isTure = [version isEqualToString:currentVersion];
    if (!isTure) {
        // 保存
        [[NSUserDefaults standardUserDefaults] setValue:version forKey:NEW_VERSION];
        [[NSUserDefaults standardUserDefaults] synchronize]; // 同步
    }
    return isTure;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
