//
//  YQPopMenu.m
//  sinaWeibo8
//
//  Created by apple on 16/2/19.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQPopMenu.h"

@implementation YQPopMenu

+ (instancetype)showInRect:(CGRect)rect
{
    YQPopMenu *menu = [[YQPopMenu alloc] initWithFrame:rect];
    
    [menu setImage:[UIImage imageWithStretchImageNamed :@"popover_background"]];
    // 添加到窗口上
    [YQKeyWindow addSubview:menu];
    
    return menu;
}


+ (void)hidden
{
    for (UIView *pop in YQKeyWindow.subviews) {
        if ([pop isKindOfClass:self]) {
            [pop removeFromSuperview];
        }
    }
}

- (void)setContentView:(UIView *)contentView
{
    [_contentView removeFromSuperview];
    _contentView = contentView;
    contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:contentView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置内视图的尺寸
    CGFloat y = 9;
    CGFloat margin = 5;
    CGFloat x = margin;
    CGFloat w = self.width - margin * 2;
    CGFloat h = self.height - y;
    _contentView.frame = CGRectMake(x, y, w, h);
}

@end
