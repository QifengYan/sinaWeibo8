//
//  YQPopMenu.h
//  sinaWeibo8
//
//  Created by apple on 16/2/19.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQPopMenu : UIImageView

/**
 *  显示pop菜单
 */
+ (instancetype)showInRect:(CGRect)rect;

+ (void)hidden;

@property (nonatomic,weak) UIView *contentView;

@end
