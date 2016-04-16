//
//  YQUser.m
//  sinaWeibo8
//
//  Created by apple on 16/3/14.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQUser.h"

@implementation YQUser

- (void)setMbtype:(int)mbtype {
    _mbrank = mbtype;
    _vip = _mbrank > 2;
}

@end
