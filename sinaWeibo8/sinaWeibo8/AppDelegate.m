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
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 注册通知
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    
    [application registerUserNotificationSettings:setting];
    
    //  创建音频会话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    // 设置会话类型(后台播放)
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    // 激活会话
    [session setActive:YES error:nil];
    
    
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


/// 将要失去焦点的时候调用
- (void)applicationWillResignActive:(UIApplication *)application {
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"silence.mp3" withExtension:nil];
    
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    _player = player;
    
    [player prepareToPlay];
    player.numberOfLoops = -1; // 无限循环播放
    [player play];
    
}

/// 程序进入后台的时候调用
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // 开启一个后台任务
    UIBackgroundTaskIdentifier ID = [application beginBackgroundTaskWithExpirationHandler:^{
        
        // 后台任务结束的时候调用
        [application endBackgroundTask:ID];
    }];
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
