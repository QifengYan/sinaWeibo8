//
//  YQStatusViewModel.h
//  sinaWeibo8
//
//  Created by apple on 16/4/8.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//  视图模型 包含了 模型数据 和frame 数据

#import <Foundation/Foundation.h>

@class YQStatuses;
@interface YQStatusViewModel : NSObject

/// 微博数据
@property (strong, nonatomic)  YQStatuses *status;

/// 原创微博frame
@property (assign, nonatomic) CGRect originalViewFrame;

// 原创微博子控件frame
// 头像
@property (assign, nonatomic) CGRect originalIconViewFrame;
// 昵称
@property (assign, nonatomic) CGRect originalNameFrame;
// vip
@property (assign, nonatomic) CGRect originalVipFrame;
// 时间
@property (assign, nonatomic) CGRect originalTimeFrame;
// 来源
@property (assign, nonatomic) CGRect originalSourceFrame;
// 正文
@property (assign, nonatomic) CGRect originalTextFrame;

/// 转发微博frame
@property (assign, nonatomic) CGRect transmitViewFrame;
// 转发微博子空间frame
// 正文
@property (assign, nonatomic) CGRect transmitTextFrame;
// 昵称
@property (assign, nonatomic) CGRect transmitNameFrame;

/// 工具条frame
@property (assign, nonatomic) CGRect toolFrame;

/// cell的高度
@property (assign, nonatomic) CGFloat cellHeight;

@end
