//
//  YQCoverView.m
//  sinaWeibo8
//
//  Created by apple on 16/2/19.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQCoverView.h"

@implementation YQCoverView

/**
 *  展示蒙版
 */
+ (instancetype)show
{
    YQCoverView *coverView = [[YQCoverView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 清除颜色
    coverView.backgroundColor = [UIColor clearColor];
    // 添加到窗口
    [YQKeyWindow addSubview:coverView];
    
    return coverView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 监听蒙版的点击 移除蒙版
    [self removeFromSuperview];
    
    // 移除pop菜单  通知代理 来实现
    if ([self.delegate respondsToSelector:@selector(coverViewDidClick:)]) {
        [self.delegate coverViewDidClick:self];
    }
}

@end
