//
//  YQAccess.m
//  sinaWeibo8
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQAccount.h"
#import <objc/runtime.h>
#import "MJExtension.h"

#define YQAccessTokenKey @"access_token"
#define YQExpires_inKey @"expires_in"
#define YQUidKey @"uid"
#define YQExpires_dateKey @"expires_date"
#define YQNameKey @"name"

@implementation YQAccount

MJCodingImplementation



+ (instancetype)accountWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    NSArray *pros = [self propertiess];
    for (NSString *key in pros) {
        if (dict[key]) {
            [obj setValue:dict[key] forKey:key];
        }
    }
    return obj;
}

/**
 *  返回当前类所有的属性
 */
+ (NSArray *)propertiess {
    NSMutableArray *pros = [NSMutableArray array];
    // 属性的个数
    unsigned int count = 0;
    // 获得属性数组
    objc_property_t *property = class_copyPropertyList([self class], &count);
    //    char *names = {"zhangsan","lis"};
    for (NSInteger index = 0; index < count; index ++) {
        // 根据index获得对应的属性
        objc_property_t p = property[index];
        // 获得属性的名字
        const char *cname = property_getName(p);
        // 转换OC字符串
        NSString *name = [[NSString alloc] initWithCString:cname encoding:NSUTF8StringEncoding];
        // 将属性添加到数组中
        [pros addObject:name];
    }
    return pros;
}

- (void)setExpires_in:(NSString *)expires_in {
    
    _expires_in = expires_in;
    
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[_expires_in longLongValue]];
}


// 归档
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    
//    [aCoder encodeObject:_access_token forKey:YQAccessTokenKey];
//    [aCoder encodeObject:_expires_in forKey:YQExpires_inKey];
//    [aCoder encodeObject:_uid forKey:YQUidKey];
//    [aCoder encodeObject:_expires_date forKey:YQExpires_dateKey];
//    [aCoder encodeObject:_name forKey:YQNameKey];
//}
//
//// 解档
//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    
//    if ( self = [super init]) {
//        _access_token = [aDecoder decodeObjectForKey:YQAccessTokenKey];
//        _expires_in = [aDecoder decodeObjectForKey:YQExpires_inKey];
//        _uid = [aDecoder decodeObjectForKey:YQUidKey];
//        _expires_date = [aDecoder decodeObjectForKey:YQExpires_dateKey];
//        _name = [aDecoder decodeObjectForKey:YQNameKey];
//    }
//    return self;
//}


@end
