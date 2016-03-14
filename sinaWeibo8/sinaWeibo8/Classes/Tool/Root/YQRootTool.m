//
//  YQRootTool.m
//  sinaWeibo8
//
//  Created by apple on 16/3/12.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//
#define NEW_VERSION @"newVersion"

#import "YQRootTool.h"
#import "YQNewFeatureController.h"
#import "YQWelcomeController.h"
@implementation YQRootTool

+ (void)chooseRootViewController:(UIWindow *)window {
    
    // 获得系统版本
    NSString * version = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    // 获取当前版本
    NSString *currentVersion = [[NSUserDefaults standardUserDefaults] stringForKey:NEW_VERSION];
    
    // 判断系统版本是否和当前版本一致
    BOOL isTure = [version isEqualToString:currentVersion];
    if (isTure) { // 不是新特性  直接跳转到欢迎界面
        window.rootViewController = [[YQWelcomeController alloc] init];
    } else {
        // 是新界面
        // 保存
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:NEW_VERSION];
        [[NSUserDefaults standardUserDefaults] synchronize]; // 同步
        
        // 控制器跳转到新特性界面
        window.rootViewController = [[YQNewFeatureController alloc] init];
    }
    
}

@end
