//
//  YQTransmitView.m
//  sinaWeibo8
//
//  Created by apple on 16/4/8.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//  转发

#import "YQTransmitView.h"
#import "YQStatusViewModel.h"
#import "YQStatuses.h"
@interface YQTransmitView ()
// 头像
@property (weak, nonatomic) UIImageView *iconView;

// 昵称
@property (weak, nonatomic) UILabel *nameView;

// vip
@property (weak, nonatomic) UIImageView *vipView;

// 时间
@property (weak, nonatomic) UILabel *timeView;

// 来源
@property (weak, nonatomic) UILabel *sourceView;

// 正文
@property (weak, nonatomic) UILabel *textView;
@end

@implementation YQTransmitView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //  添加子控件
        [self setupChildesView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchImageNamed:@"timeline_retweet_background"];
    }
    return self;
}

#pragma mark - 布局子控件
- (void)setupChildesView {
    // 头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    
    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = YQNameFont;
    [self addSubview:nameView];
    _nameView = nameView;
    
    // vip
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    _vipView = vipView;
    
    // 时间
    UILabel *timeView = [[UILabel alloc] init];
    [self addSubview:timeView];
    _timeView = timeView;
    
    // 来源
    UILabel *sourceView = [[UILabel alloc] init];
    [self addSubview:sourceView];
    _sourceView = sourceView;
    
    // 正文
    UILabel *textView = [[UILabel alloc] init];
    textView.font = YQTextFont;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;
}

- (void)setStatusF:(YQStatusViewModel *)statusF {
    _statusF = statusF;
    _nameView.frame = statusF.transmitNameFrame;
    _nameView.text = statusF.status.retweetName;
    _textView.frame = statusF.transmitTextFrame;
    _textView.text = statusF.status.retweeted_status.text;
}

@end
