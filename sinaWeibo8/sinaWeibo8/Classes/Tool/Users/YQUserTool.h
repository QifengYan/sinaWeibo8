//
//  YQUserTool.h
//  sinaWeibo8
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//  用户消息发送请求工具类

#import <Foundation/Foundation.h>
//#import "YQUserResult.h"
@class YQUser,YQUserResult;
@interface YQUserTool : NSObject

+ (void)unreadWithUrl:(NSString *)url success:(void(^)(YQUserResult *result))success failure:(void(^)(NSError *error))failure;

+ (void)usersInfoWithUrl:(NSString *)url success:(void(^)(YQUser *user))success failure:(void(^)(NSError *error))failure;

@end
