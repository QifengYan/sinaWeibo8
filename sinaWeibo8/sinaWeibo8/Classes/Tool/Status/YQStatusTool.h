//
//  YQStatusTool.h
//  sinaWeibo8
//
//  Created by apple on 16/3/14.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//  获取数据工具类

#import <Foundation/Foundation.h>

@interface YQStatusTool : NSObject

/**
 *  请求更新微博数据
 *
 *  @param sinceId 返回比这个更大的数据
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)newStatusWithSinceId:(NSString *)sinceId success:(void(^)(NSArray *statuses))success failure:(void (^)(NSError *error))failure;

/**
 *  下拉加载跟多
 *
 *  @param maxId 返回比这个更小的数据
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)moreStatusWithMaxId:(NSString *)maxId success:(void(^)(NSArray *statuses))success failure:(void (^)(NSError *error))failure;

@end
