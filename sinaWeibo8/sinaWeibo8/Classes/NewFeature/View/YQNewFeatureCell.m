//
//  YQNewFeatureCell.m
//  sinaWeibo8
//
//  Created by apple on 16/3/9.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQNewFeatureCell.h"
#import "Masonry.h"
#import "YQTabBarController.h"

@interface YQNewFeatureCell ()

/// 图片
@property (nonatomic,strong) UIImageView *imageView;

/// 开始体验按钮
@property (nonatomic, strong) UIButton *startBtn;

@end

@implementation YQNewFeatureCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
//    self.startBtn.hidden = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 设置图片的frame值
    _imageView.frame = self.bounds;
    
    // 设置按钮的约束
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-160);
//        make.size.mas_equalTo(CGSizeMake(160, 35));
    }];
}

- (void)isShow:(BOOL)show {
    self.startBtn.hidden = show;
}

- (void)showStartButton {
    self.startBtn.hidden = NO;
    
    self.startBtn.transform = CGAffineTransformMakeScale(0, 0);
    
    [UIView animateWithDuration:1.25 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:5 options:0 animations:^{
        self.startBtn.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 懒加载
-(UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

- (UIButton *)startBtn {
    if (_startBtn == nil) {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [_startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [_startBtn setTitle:@"开始体验" forState:UIControlStateNormal];
        [_startBtn sizeToFit];
        [_startBtn addTarget:self action:@selector(startBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_startBtn];
    }
    return _startBtn;
}

/// 监听 开始按钮的点击事件
- (void)startBtnDidClick {
    // 跳转到首页控制器
    YQTabBarController *tabBar = [[YQTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBar;
    
}

@end
