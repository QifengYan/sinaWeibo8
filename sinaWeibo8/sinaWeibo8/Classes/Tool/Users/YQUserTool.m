//
//  YQUserTool.m
//  sinaWeibo8
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQUserTool.h"
#import "YQHttpTool.h"
#import "YQUserParam.h"

#import "YQAccountTool.h"
#import "YQAccount.h"
#import "YQUserResult.h"
#import "MJExtension.h"
#import "YQUser.h"

@implementation YQUserTool

+ (void)unreadWithUrl:(NSString *)url success:(void(^)(YQUserResult *result))success failure:(void(^)(NSError *error))failure {
    
    YQUserParam *param = [[YQUserParam alloc] init];
    param.access_token = [YQAccountTool account].access_token;
    param.uid = [YQAccountTool account].uid;
    
    [YQHttpTool GET:url parameters:param.mj_keyValues success:^(id responseObject) {
        
        YQUserResult *result = [YQUserResult mj_objectWithKeyValues:responseObject];
        if (success) {
            success(result);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)usersInfoWithUrl:(NSString *)url success:(void(^)(YQUser *user))success failure:(void(^)(NSError *error))failure {
    
    YQUserParam *param = [[YQUserParam alloc] init];
    param.access_token = [YQAccountTool account].access_token;
    param.uid = [YQAccountTool account].uid;
    
    [YQHttpTool GET:url parameters:param.mj_keyValues success:^(id responseObject) {
        YQUser *user = [YQUser mj_objectWithKeyValues:responseObject];
        
        if (success) {
            success(user);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
