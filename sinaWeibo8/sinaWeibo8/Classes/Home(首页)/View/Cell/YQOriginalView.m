//
//  YQAuthorshipView.m
//  sinaWeibo8
//
//  Created by apple on 16/4/8.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//  原创

#import "YQOriginalView.h"
#import "YQStatusViewModel.h"
#import "YQStatuses.h"

#import "UIImageView+WebCache.h"

@interface YQOriginalView ()
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

@implementation YQOriginalView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //  添加子控件
        [self setupChildesView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchImageNamed:@"timeline_card_top_background"];
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
    timeView.font = YQTimeFont;
    timeView.textColor = [UIColor orangeColor];
    [self addSubview:timeView];
    _timeView = timeView;
    
    // 来源
    UILabel *sourceView = [[UILabel alloc] init];
    sourceView.font = YQSourceFont;
    sourceView.textColor = [UIColor lightGrayColor];
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
    
    // 设置frame
    [self setUpFrame];
    
    // 设置数据
    [self setUpData];
}

/// 设置数据
- (void)setUpData {
    // 头像
    [_iconView sd_setImageWithURL:_statusF.status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"] options:SDWebImageRetryFailed |SDWebImageLowPriority];
    
    // 昵称
    _nameView.text = _statusF.status.user.name;
    
    // vip
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",_statusF.status.user.mbrank];
    _vipView.image = [UIImage imageNamed:imageName];
    
    // 时间
    _timeView.text = _statusF.status.created_at;
//    _timeView.textColor = [UIColor orangeColor];
    
    // 来源
    _sourceView.text = _statusF.status.source;
    
    // 正文
    _textView.text = _statusF.status.text;
    
}

/// 设置frame
- (void)setUpFrame {
    // 头像
    _iconView.frame = _statusF.originalIconViewFrame;
    
    // 昵称
    _nameView.frame = _statusF.originalNameFrame;
    
    // vip
    if (_statusF.status.user.vip) {
        _vipView.hidden = NO;
        _vipView.frame = _statusF.originalVipFrame;
        _nameView.textColor = [UIColor redColor];
    } else {
        _vipView.hidden = YES;
        _nameView.textColor = [UIColor blackColor];
    }
#warning 时间的frame  和来源的frame  要更新
//    // 时间
//    _timeView.frame = _statusF.originalTimeFrame;
    
    // 时间
    CGFloat timeX = _nameView.frame.origin.x;
    CGFloat timeY = CGRectGetMaxY(_nameView.frame) + YQStatusMargin * 0.5;
    CGSize timeSize = [_statusF.status.created_at sizeWithFont:YQTimeFont];
    _timeView.frame = (CGRect){{timeX,timeY},timeSize};
    
    // 来源
    CGFloat sourceX = CGRectGetMaxX(_timeView.frame) + YQStatusMargin;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [_statusF.status.source sizeWithFont:YQSourceFont];
    _sourceView.frame = (CGRect){{sourceX,sourceY},sourceSize};
    
    // 来源
//    _sourceView.frame = _statusF.originalSourceFrame;
    
    // 正文
    _textView.frame = _statusF.originalTextFrame;
}

@end
