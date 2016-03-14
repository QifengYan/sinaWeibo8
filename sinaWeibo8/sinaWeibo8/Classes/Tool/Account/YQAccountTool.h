//
//  YQAccount.h
//  sinaWeibo8
//
//  Created by apple on 16/3/12.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YQAccount;
@interface YQAccountTool : NSObject

/// 保存用户信息（归档）
+ (void)saveAccount:(YQAccount *)account;

/// 读取用户信息 （解档）
+ (YQAccount *)account;
@end
