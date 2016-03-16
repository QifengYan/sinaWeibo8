//
//  YQAccount.m
//  sinaWeibo8
//
//  Created by apple on 16/3/12.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQAccountTool.h"
#import "YQAccount.h"

#import "YQAccountPar.h"
#import "YQHttpTool.h"
#import "AFNetworking.h"
#import "MJExtension.h"

#define YQAccountPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"account.data"]

#define YQAuthClient_id     @"3165314916"
#define YQAuthClient_secret @"967afe2dd64a84f7be9e318e8e45ca2f"
#define YQAuthRedirect_uri  @"http://www.baidu.com/"
#define YQAuthGrant_type    @"authorization_code"
@implementation YQAccountTool

+ (void)saveAccount:(YQAccount *)account {
    [NSKeyedArchiver archiveRootObject:account toFile:YQAccountPath];
}

static YQAccount *_account;

+ (YQAccount *)account {
    if (_account == nil) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:YQAccountPath];
        
        NSLog(@"YQAccountPath - %@",YQAccountPath);
        // 同时判断账号有没有过期
        // NSOrderedAscending = -1L, 递增
        // NSOrderedSame,            相对
        // NSOrderedDescending       递减
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) {
            return nil;
        }
    }
    return _account;
}

+ (void)accountWithCode:(NSString *)code success:(void (^)())success failurl:(void (^)(NSError *))failure {
    
    YQAccountPar *parameter = [[YQAccountPar alloc] init];
    parameter.client_id = YQAuthClient_id;
    parameter.client_secret = YQAuthClient_secret;
    parameter.grant_type = YQAuthGrant_type;
    parameter.code = code;
    parameter.redirect_uri = YQAuthRedirect_uri;
    // 错误信息 "Request failed: unacceptable content-type: text/plain"
    // 请求失败 确实响应类型
    //  创建一个响应类型
    //    manager.responseSerializer.acceptableContentTypes  = [NSSet setWithObjects:@"text/plain", nil];
    
    [YQHttpTool POST:@"https://api.weibo.com/oauth2/access_token" parameters:parameter.mj_keyValues success:^(id responseObject) {
        // 成功回调
        NSLog(@"success-- %@",responseObject);
        
        // 获取到数据 字典转模型
        YQAccount *account = [YQAccount accountWithDict:responseObject];
        
        // 保存用户信息 （归档）
        [YQAccountTool saveAccount:account];
        
        if (success) {
            success();
        }

    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
   
}


@end
