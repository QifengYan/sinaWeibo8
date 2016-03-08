//
//  YQCoverView.h
//  sinaWeibo8
//
//  Created by apple on 16/2/19.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YQCoverView;
@protocol YQCoverViewDelegate <NSObject>

@optional

- (void)coverViewDidClick:(YQCoverView *)coverView;

@end

@interface YQCoverView : UIView

/**
 *  展示蒙版
 */
+ (instancetype)show;

/**
 *  代理属性
 */
@property (nonatomic, weak) id<YQCoverViewDelegate> delegate;


@property (nonatomic, assign) BOOL dimBackground;

@end
