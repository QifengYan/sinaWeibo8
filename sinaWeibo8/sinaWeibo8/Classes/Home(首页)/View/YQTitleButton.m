//
//  YQTitleButton.m
//  sinaWeibo8
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQTitleButton.h"

@implementation YQTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        UIImage *image = [UIImage imageWithStretchImageNamed:@"navigationbar_filter_background_highlighted"];
       
        [self setBackgroundImage:image forState:UIControlStateHighlighted];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.currentImage == nil) {
        return;
    } 
    
    self.titleLabel.x = 0;
    
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
}

@end
