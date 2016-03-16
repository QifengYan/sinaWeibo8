//
//  YQStatusTool.m
//  sinaWeibo8
//
//  Created by apple on 16/3/14.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQStatusTool.h"
#import "YQHttpTool.h"
#import "YQAccountTool.h"
#import "YQAccount.h"
#import "YQStatuses.h"
#import "YQResult.h"
#import "YQParameter.h"

@implementation YQStatusTool

+ (void)newStatusWithSinceId:(NSString *)sinceId success:(void(^)(NSArray *statuses))success failure:(void (^)(NSError *error))failure {
    
    YQParameter *parameter = [[YQParameter alloc] init];
    
    if (sinceId) {
        parameter.since_id = sinceId;
    }
    parameter.access_token = [YQAccountTool account].access_token;
    
    // 使用网路工具类 发送网络请求 获取数据
    [YQHttpTool GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:parameter.mj_keyValues success:^(id responseObject) {
        
        YQResult *result = [YQResult mj_objectWithKeyValues:responseObject];
        
        if (success) {
            success(result.statuses);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


+ (void)moreStatusWithMaxId:(NSString *)maxId success:(void(^)(NSArray *statuses))success failure:(void (^)(NSError *error))failure {
    // 网络请求参数
    YQParameter *parameters = [[YQParameter alloc] init];
    if (maxId) {
        parameters.max_id = maxId;
    }
    
    parameters.access_token = [YQAccountTool account].access_token;
    
    [YQHttpTool GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:parameters.mj_keyValues success:^(id responseObject) {
        
        YQResult *result = [YQResult mj_objectWithKeyValues:responseObject];
        
        if (success) {
            success(result.statuses);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

@end
