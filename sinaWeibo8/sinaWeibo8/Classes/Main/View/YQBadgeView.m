//
//  YQBadgeView.m
//  sinaWeibo
//
//  Created by apple on 16/2/12.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQBadgeView.h"

#define YQBadgeValueFont [UIFont systemFontOfSize:11]

@implementation YQBadgeView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        
        self.titleLabel.font = YQBadgeValueFont;
        
        self.userInteractionEnabled = NO;
        
        [self sizeToFit];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue {
    _badgeValue = badgeValue;
    
    if (badgeValue.length == 0 || [badgeValue isEqualToString:@"0"]) {
        self.hidden = YES;
    } else {
        self.hidden = NO;
    }
    
    CGSize size = [badgeValue sizeWithFont:YQBadgeValueFont];
    
    if (size.width > self.width) {
        
        [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
        
        [self setTitle:nil forState:UIControlStateNormal];
        
        [self setBackgroundImage:nil forState:UIControlStateNormal];
        
    } else {
        [self setImage:nil forState:UIControlStateNormal];
        
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        
        [self setTitle:badgeValue forState:UIControlStateNormal];
    }
    
}

@end
