//
//  UIBarButtonItem+item.h
//  sinaWeibo8
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (item)

/// 导航栏按钮分类
+ (instancetype)barButtonItemWithImage:(UIImage *)image highlightedImage:(UIImage *)highlighteImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
