//
//  YQSearch.m
//  sinaWeibo8
//
//  Created by apple on 16/3/8.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQSearch.h"

@implementation YQSearch

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.font = [UIFont systemFontOfSize:13];
        self.background = [UIImage imageWithStretchImageNamed:@"searchbar_textfield_background"]; //  设置背景图片
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        imageView.width += 10;
        imageView.contentMode = UIViewContentModeCenter; //  图片居中
        
        self.leftView = imageView;  // 设置UITextField 左边图片
        self.leftViewMode = UITextFieldViewModeAlways; // 显示样式
        
    }
    return self;
}

@end
