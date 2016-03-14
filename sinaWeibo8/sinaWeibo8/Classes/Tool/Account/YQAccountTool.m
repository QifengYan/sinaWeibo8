//
//  YQAccount.m
//  sinaWeibo8
//
//  Created by apple on 16/3/12.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQAccountTool.h"
#import "YQAccount.h"

#define YQAccountPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"account.data"]

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

@end
