//
//  YQStatusViewModel.m
//  sinaWeibo8
//
//  Created by apple on 16/4/8.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQStatusViewModel.h"
#import "YQStatuses.h"



@implementation YQStatusViewModel

- (void)setStatus:(YQStatuses *)status {
    _status = status;
    // 计算原创微博
    [self setupOriginalFrame];
    
    CGFloat toolY = CGRectGetMaxY(_originalViewFrame);
    // 计算转发微博
    if (_status.retweeted_status) { // 如果有转发微博 才进行计算
        
        [self setupTransmitFrame];
        
        toolY = CGRectGetMaxY(_transmitViewFrame);
    }
    
    // 计算工具条
    CGFloat toolX = 0;
    CGFloat toolW = YQScreenWidth;
    CGFloat toolH = 35;
    _toolFrame = CGRectMake(toolX, toolY, toolW, toolH);
    
    // 计算cell 的高度
    _cellHeight = CGRectGetMaxY(_toolFrame); 
    
}

#pragma mark - 计算原创微博的frame
- (void)setupOriginalFrame {
    // 图片的frame
    CGFloat iconX = YQStatusMargin;
    CGFloat iconY = YQStatusMargin;
    CGFloat iconWH = 35;
    _originalIconViewFrame = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    // 昵称的frame
    CGFloat nameX = CGRectGetMaxX(_originalIconViewFrame) + YQStatusMargin;
    CGFloat nameY = iconY;
    CGSize nameSize = [_status.user.name sizeWithFont:YQNameFont];
    _originalNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    // vip
    if (_status.user.vip) {
        CGFloat vipX = CGRectGetMaxX(_originalNameFrame) +YQStatusMargin;
        CGFloat vipY = nameY;
        CGFloat vipWH = 14;
        _originalVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
    }
    
//    // 时间
//    CGFloat timeX = nameX;
//    CGFloat timeY = CGRectGetMaxY(_originalNameFrame) + YQStatusMargin * 0.5;
//    CGSize timeSize = [_status.created_at sizeWithFont:YQTimeFont];
//    _originalTimeFrame = (CGRect){{timeX,timeY},timeSize};
//    
//    // 来源
//    CGFloat sourceX = CGRectGetMaxX(_originalTimeFrame) + YQStatusMargin;
//    CGFloat sourceY = timeY;
//    CGSize sourceSize = [_status.source sizeWithFont:YQSourceFont];
//    _originalSourceFrame = (CGRect){{sourceX,sourceY},sourceSize};
    
    // 正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(_originalIconViewFrame) + YQStatusMargin;
    CGFloat textW = YQScreenWidth - YQStatusMargin * 2;
    CGSize textSize = [_status.text sizeWithFont:YQTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _originalTextFrame = (CGRect){{textX,textY},textSize};
    
    // 原创微博的frame
    CGFloat x = 0;
    CGFloat y = YQStatusMargin;
    CGFloat w = YQScreenWidth;
    CGFloat h = CGRectGetMaxY(_originalTextFrame) + YQStatusMargin;
    _originalViewFrame = CGRectMake(x, y, w, h);
    
    
}

#pragma mark - 计算转发微博的frame
- (void)setupTransmitFrame {
    
    // 昵称的frame
    CGFloat nameX = YQStatusMargin;
    CGFloat nameY = nameX;
    CGSize nameSize = [_status.retweetName sizeWithFont:YQNameFont];
    _transmitNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    // 正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(_transmitNameFrame);
    CGFloat textW = YQScreenWidth - YQStatusMargin * 2;
    CGSize textSize = [_status.retweeted_status.text sizeWithFont:YQTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _transmitTextFrame = (CGRect){{textX,textY},textSize};
    
    // 转发微博的frame
    CGFloat x = 0;
    CGFloat y = CGRectGetMaxY(_originalViewFrame);
    CGFloat w = YQScreenWidth;
    CGFloat h = CGRectGetMaxY(_transmitTextFrame) + YQStatusMargin;
    _transmitViewFrame = CGRectMake(x, y, w, h);
    
    
}


@end
