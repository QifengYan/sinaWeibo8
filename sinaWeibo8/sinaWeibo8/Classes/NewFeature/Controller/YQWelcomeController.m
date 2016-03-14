//
//  YQWelcomeController.m
//  sinaWeibo8
//
//  Created by apple on 16/3/9.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQWelcomeController.h"
#import "Masonry.h"
#import "YQTabBarController.h"
@interface YQWelcomeController ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *welcomeName;

@end

@implementation YQWelcomeController

//- (instancetype)init {
//    if (self = [super init]) {
//        
//    }
//    return self;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
//    [self.view addSubview: self.iconView];
//    [self.view addSubview: self.welcomeName];
    
    self.view.backgroundColor = [UIColor whiteColor];
  
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 执行动画效果
    [self setAnimationForIconView];
    
}


#pragma mark - 加载子控件
- (void)prepareUI {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar_default_big"]];
    self.iconView = imageView;
    imageView.layer.cornerRadius = 42.5;
    imageView.layer.masksToBounds = YES;
    [self.view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-160);
        make.size.mas_equalTo(CGSizeMake(85, 85));
    }];
    
    UILabel *label = [[UILabel alloc] init];
    self.welcomeName = label;
    label.text = @"欢迎归来";
    label.font = [UIFont systemFontOfSize:16];
    [label sizeToFit];
    [self.view addSubview: label];
    self.welcomeName.alpha = 0;
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.iconView);
        make.top.equalTo(self.iconView.mas_bottom).offset(16);
    }];
}

#pragma mark - 头像动画效果
- (void)setAnimationForIconView {

    // 更新底部约束
    [self.iconView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-([UIScreen mainScreen].bounds.size.height - 160));
    }];
    // 设置动画
    [UIView animateWithDuration:1.5 delay:0.1 usingSpringWithDamping:0.6 initialSpringVelocity:5 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1 animations:^{
            self.welcomeName.alpha = 1;
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 控制器跳转到 主界面
            YQKeyWindow.rootViewController = [[YQTabBarController alloc] init];
        });
    }];
}

@end
