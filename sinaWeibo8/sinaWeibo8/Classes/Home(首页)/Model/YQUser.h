//
//  YQUser.h
//  sinaWeibo8
//
//  Created by apple on 16/3/14.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQUser : NSObject

/// 用户昵称
@property (nonatomic, copy) NSString *screen_name;

/// 用户头像地址
@property (nonatomic, copy) NSString *profile_image_url;

@end
