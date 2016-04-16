//
//  YQStatuses.m
//  sinaWeibo8
//
//  Created by apple on 16/3/14.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQStatuses.h"
#import "YQPhoto.h"
#import "NSDate+MJ.h"

@implementation YQStatuses

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"pic_urls" : [YQPhoto class]};
}

- (NSString *)created_at {
    
    // 日期格式字符串
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    NSDate *creared_at = [fmt dateFromString:_created_at];
    
    if ([creared_at isThisYear]) { // 是否为今年
        
        if ([creared_at isToday]) { // 是否为今天
            
            NSDateComponents *cmp = [creared_at deltaWithNow];
            NSLog(@"%ld-%ld-%ld",cmp.hour,cmp.minute,cmp.second);
            
        } else if ([creared_at isYesterday]) { // 是否为昨天
            
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:creared_at];
            
        } else { // 前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:creared_at];
        }
        
    } else { // 不是今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:creared_at];
    }
    
    return _created_at;
}

@end
