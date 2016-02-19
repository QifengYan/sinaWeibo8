//
//  YQPopMenu.m
//  sinaWeibo8
//
//  Created by apple on 16/2/19.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQPopMenu.h"

@implementation YQPopMenu

+ (void)showInRect:(CGRect)rect
{
    YQPopMenu *menu = [[YQPopMenu alloc] initWithFrame:rect];
    
    [menu setImage:[UIImage imageWithStretchImageNamed :@"popover_background"]];
    // 添加到窗口上
    [YQKeyWindow addSubview:menu];
}


+ (void)hidden
{
    for (UIView *pop in YQKeyWindow.subviews) {
        if ([pop isKindOfClass:self]) {
            [pop removeFromSuperview];
        }
    }
}

@end
