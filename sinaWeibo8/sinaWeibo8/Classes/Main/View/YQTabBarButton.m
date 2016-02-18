//
//  YQTabBarButton.m
//  sinaWeibo
//
//  Created by apple on 16/2/11.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQTabBarButton.h"
#import "YQBadgeView.h"
#import "UIView+ZUtility.h"

#define YQImageRidio 0.7

@interface YQTabBarButton ()

@property (nonatomic,weak)  YQBadgeView *badgeView;

@end

@implementation YQTabBarButton

- (void)setHighlighted:(BOOL)highlighted {}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        // 设置图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 设置文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    // 修改image的位置
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * YQImageRidio;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    // title的位置
    CGFloat titleX = 0;
    CGFloat titleY = imageH - 5;
    CGFloat titleW = self.bounds.size.width;
    CGFloat titleH = self.bounds.size.height - titleY;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    // 设置badgeView
//    CGRect frame = self.badgeView.frame;
//    frame.origin.x = self.bounds.size.width - self.badgeView.bounds.size.width - 5;
//    frame.origin.y = 0;
//    self.badgeView.frame = frame;
    
    self.badgeView.x = self.width - self.badgeView.width - 10;
    self.badgeView.y = 0;
}



- (YQBadgeView *)badgeView {
    
    if (_badgeView == nil) {
        YQBadgeView *btn = [YQBadgeView buttonWithType:UIButtonTypeCustom];
        
        [self addSubview:btn];
        
        _badgeView = btn;
    }
    return _badgeView;
}

- (void)setItem:(UITabBarItem *)item {
    
    _item = item;
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
//    [self setTitle:item.title forState:UIControlStateNormal];
//    
//    [self setImage:item.image forState:UIControlStateNormal];
//    
//    [self setImage:item.selectedImage forState:UIControlStateSelected];
//    
//    self.badgeView.badgeValue = item.badgeValue;
    
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    [self setTitle:_item.title forState:UIControlStateNormal];
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateNormal];
    self.badgeView.badgeValue = _item.badgeValue;
}

- (void)dealloc {
    
    [_item removeObserver:self forKeyPath:@"title"];
    [_item removeObserver:self forKeyPath:@"image"];
    [_item removeObserver:self forKeyPath:@"selectedImage"];
    [_item removeObserver:self forKeyPath:@"badgeValue"]; 
}

@end
