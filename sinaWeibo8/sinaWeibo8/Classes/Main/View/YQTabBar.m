//
//  YQTabBar.m
//  sinaWeibo
//
//  Created by apple on 16/2/5.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQTabBar.h"
#import "YQTabBarButton.h"

@interface YQTabBar ()

@property (nonatomic,weak) UIButton *button;

@property (nonatomic, strong) NSMutableArray *buttons;

@property (nonatomic, weak) UIButton *selectedBtn;

@end
@implementation YQTabBar

//- (instancetype)initWithFrame:(CGRect)frame {
//    
//    if (self = [super initWithFrame:frame]) {
//        
//    }
//    return self;
//}


- (void)setItems:(NSArray *)items {
    
    _items = items;
    for (UITabBarItem *item in _items) {
        
        YQTabBarButton *btn = [YQTabBarButton buttonWithType:UIButtonTypeCustom];
        
        btn.item = item;
        btn.tag = self.buttons.count;
        if (btn.tag == 0) {
            [self btnDidClick:btn];
        }
        [self addSubview:btn];
        
        [btn addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchDown];
        
        [self.buttons addObject:btn];
    }
}

- (void)btnDidClick:(UIButton *)btn {
    
    _selectedBtn.selected = NO;
    btn.selected = YES;
    _selectedBtn = btn;
    
    if (self.didSelectedBtn) {
        self.didSelectedBtn(btn.tag);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    NSLog(@"%@",self.subviews);
    CGFloat w = self.width;
    CGFloat h = self.height;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = w / (self.items.count + 1);
    CGFloat btnH = h;
    int i = 0;
    for (UIView *tabBarButton in self.buttons) {
        if (i == 2) {
            i = 3;
        }
        btnX = i * btnW;
        tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
        i++;
    }
    
    self.button.center = CGPointMake(w * 0.5, h * 0.5); 
}

#pragma mark - 加号按钮懒加载 -
- (UIButton *)button {
    if (_button == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        _button = btn;
        [self addSubview:_button];
    }
    return _button;
}


#pragma mark - 懒加载 -

- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}









@end
