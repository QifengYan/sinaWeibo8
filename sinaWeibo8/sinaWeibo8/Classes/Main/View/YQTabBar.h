//
//  YQTabBar.h
//  sinaWeibo
//
//  Created by apple on 16/2/5.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQTabBar : UIView

//@property (nonatomic, assign) NSUInteger tabBarButtonCount;

// items:保存所有的UITabBarItem
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, copy) void (^didSelectedBtn)(NSUInteger );

@end
