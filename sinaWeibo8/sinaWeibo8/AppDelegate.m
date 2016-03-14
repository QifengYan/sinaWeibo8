//
//  AppDelegate.m
//  sinaWeibo
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//



#import "AppDelegate.h"
#import "YQTabBarController.h"
#import "YQRootTool.h"
#import "YQOauthController.h"
#import "YQAccountTool.h"
#import "YQWelcomeController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 判断用户有没有登陆
    if (![YQAccountTool account]) {
        self.window.rootViewController = [[YQOauthController alloc] init];
    } else {
        [YQRootTool chooseRootViewController:self.window];
    }
//    self.window.rootViewController = [[YQWelcomeController alloc] init];
    // 展示窗口
    [self.window makeKeyAndVisible];
    return YES;
}

///// 控制器的选择
//- (void)chooseRootViewController:(BOOL)isNewVertion {
//   
//    self.window.rootViewController = isNewVertion ? [[YQNewFeatureController alloc] init] :[[YQTabBarController alloc] init];
//}
//
//+ (void)outChooseRootViewController:(BOOL)isNewVersion{
//    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [delegate chooseRootViewController:isNewVersion];
//}
//
//- (UIViewController *)defaultsViewController {
//    if (![YQAccountTool account]) {
//        return [[YQOauthController alloc] init]; // 如果账号不存在 就返回登陆授权界面
//    }
//    //  如果账号存在 判断是否是新版本
//    return [self isNewVertion] ? [[YQNewFeatureController alloc] init] :[[YQWelcomeController alloc] init];
//    
//}



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
