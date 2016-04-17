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
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss zzz yyyy";
    
#warning 注意时间格式的转换  一定要指定地区  否则无法转换
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    
    NSDate *creared = [fmt dateFromString:_created_at];

//    NSLog(@"crered_at = %@",creared);
    
    if ([creared isThisYear]) { // 是否为今年
        
        if ([creared isToday]) { // 是否为今天
            
            NSDateComponents *cmp = [creared deltaWithNow];
//            NSLog(@"%ld-%ld-%ld",cmp.hour,cmp.minute,cmp.second);
            
            if (cmp.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时之前",cmp.hour];
            }else if (cmp.minute > 1){
                return [NSString stringWithFormat:@"%ld分钟之前",cmp.minute];
            }else{
                return @"刚刚";
            }
            
        } else if ([creared isYesterday]) { // 是否为昨天
            
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:creared];
            
        } else { // 前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:creared];
        }
        
    } else { // 不是今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:creared];
    }
    
    return _created_at;
}

#pragma mark - 处理来源
- (void)setSource:(NSString *)source {
    
    // <a href="http://app.weibo.com/t/feed/1tqBja" rel="nofollow">360安全浏览器</a>
    // 截取字符串
    NSRange range = [source rangeOfString:@">"];
    
    source = [source substringFromIndex:(range.location + range.length)];
    // 360安全浏览器</a>
    range = [source rangeOfString:@"<"];
    
    source = [source substringToIndex:range.location];
    
    source = [NSString stringWithFormat:@"来自%@",source];
    
//    NSLog(@"%@",source);
    _source = source;
}

- (void)setRetweeted_status:(YQStatuses *)retweeted_status {
    _retweeted_status = retweeted_status;
    
    _retweetName = [NSString stringWithFormat:@"@%@",retweeted_status.user.name];
}

@end
