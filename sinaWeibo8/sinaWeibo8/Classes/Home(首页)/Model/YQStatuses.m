//
//  YQStatuses.m
//  sinaWeibo8
//
//  Created by apple on 16/3/14.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQStatuses.h"
#import "YQPhoto.h"

@implementation YQStatuses

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"pic_urls" : [YQPhoto class]};
}

@end
