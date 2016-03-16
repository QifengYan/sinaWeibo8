//
//  YQResult.m
//  sinaWeibo8
//
//  Created by apple on 16/3/14.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQResult.h"
#import "YQStatuses.h"

@implementation YQResult

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"statuses" : [YQStatuses class]};
}
@end
