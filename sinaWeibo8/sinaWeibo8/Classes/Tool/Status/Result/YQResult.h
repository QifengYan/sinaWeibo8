//
//  YQResult.h
//  sinaWeibo8
//
//  Created by apple on 16/3/14.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface YQResult : NSObject<MJKeyValue>

/// 用户的微博数组 （YQStatuses）
@property (nonatomic, strong) NSArray *statuses;

@end
