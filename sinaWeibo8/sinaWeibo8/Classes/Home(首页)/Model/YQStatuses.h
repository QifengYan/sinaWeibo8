//
//  YQStatuses.h
//  sinaWeibo8
//
//  Created by apple on 16/3/14.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YQUser.h"
#import "MJExtension.h"
/*
 idstr	string	字符串型的微博ID
 text	string	微博信息内容
 source	string	微博来源
 user	object	微博作者的用户信息字段 详细
 retweeted_status	object	被转发的原微博信息字段，当该微博为转发微博时返回 详细
 reposts_count	int	转发数
 comments_count	int	评论数
 attitudes_count	int	表态数
 pic_urls  微博配图
 */
@interface YQStatuses : NSObject<MJKeyValue >

/// 用户信息
@property (nonatomic, strong) YQUser *user;

/// 转发的微博
@property (nonatomic, strong) YQStatuses *retweeted_status;

/// 转发微博的名字（新增属性）
@property (copy, nonatomic) NSString *retweetName;

/// 微博创建时间
@property (nonatomic, copy) NSString *created_at;

/// 微博ID
@property (nonatomic, copy) NSString *idstr;

/// 微博信息内容
@property (nonatomic, copy) NSString *text;

/// 微博来源
@property (nonatomic, copy) NSString *source;

/// 转发数
@property (nonatomic, assign) int reposts_count;

/// 评论数
@property (nonatomic, assign) int comments_count;

/// 表态数
@property (nonatomic, assign) int attitudes_count;

/// 微博配图
@property (nonatomic, strong) NSArray *pic_urls;


@end
