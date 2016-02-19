//
//  UIBarButtonItem+item.m
//  sinaWeibo8
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "UIBarButtonItem+item.h"

@implementation UIBarButtonItem (item)

+ (instancetype)barButtonItemWithImage:(UIImage *)image highlightedImage:(UIImage *)highlighteImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:highlighteImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}

@end
