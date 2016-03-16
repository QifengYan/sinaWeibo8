//
//  YQUserParam.h
//  sinaWeibo8
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//  用户消息 参数工具类

#import <Foundation/Foundation.h>

@interface YQUserParam : NSObject

/// 用户的账户信息
@property (nonatomic, copy) NSString *access_token;

/// 用户的唯一标示
@property (nonatomic, copy) NSString *uid;

@end
