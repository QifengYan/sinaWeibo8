//
//  YQAccess.h
//  sinaWeibo8
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "access_token" = "2.00WQd85G5A2N9D1fa698ead6PpcS_D";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 5858014852;
 */

@interface YQAccount : NSObject<NSCoding>

/// 用户登录的标示牌
@property (nonatomic, copy) NSString *access_token;

/// 账号过期时间
@property (nonatomic, copy) NSString *expires_in;

/// 用户唯一标示
@property (nonatomic, copy) NSString *uid;

/// 账号过期时间
@property (nonatomic, strong) NSDate *expires_date;

/// 用户昵称
@property (nonatomic, copy) NSString *name;

/// 便利方法
+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
