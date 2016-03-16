//
//  YQUserResult.h
//  sinaWeibo8
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//  用户消息 结果工具类

#import <Foundation/Foundation.h>
/*
 status	int	新微博未读数
 follower	int	新粉丝数
 cmt	int	新评论数
 dm	int	新私信数
 mention_status	int	新提及我的微博数
 mention_cmt	int	新提及我的评论数
 */

@interface YQUserResult : NSObject
/// 新微博未读数
@property (nonatomic, assign) int status;

/// 新粉丝数
@property (nonatomic, assign) int follower;

/// 新评论数
@property (nonatomic, assign) int cmt;

/// 新私信数
@property (nonatomic, assign) int dm;

/// 新提及我的微博数
@property (nonatomic, assign) int mention_status;

/// 新提及我的评论数
@property (nonatomic, assign) int mention_cmt;

/// 关于我的消息的总和
- (int)messageCount;

/// 应用程序的总和
- (int)totalCount;

@end
