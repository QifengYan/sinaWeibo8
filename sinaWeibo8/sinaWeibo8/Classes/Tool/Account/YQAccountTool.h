//
//  YQAccount.h
//  sinaWeibo8
//
//  Created by apple on 16/3/12.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//  用户信息工具类

#import <Foundation/Foundation.h>

@class YQAccount;
@interface YQAccountTool : NSObject

/// 保存用户信息（归档）
+ (void)saveAccount:(YQAccount *)account;

/// 读取用户信息 （解档）
+ (YQAccount *)account;

/**
 *  换取accessToken
 *
 *  @param code    code 参数
 *  @param success 成功回调
 *  @param failurl 失败回调
 */
+ (void)accountWithCode:(NSString *)code success:(void (^)())success failurl:(void(^)(NSError *error))failure;

@end
