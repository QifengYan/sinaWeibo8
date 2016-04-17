//
//  YQStatuesToolView.m
//  sinaWeibo8
//
//  Created by apple on 16/4/8.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQStatuesToolView.h"
#import "YQStatuses.h"

@interface YQStatuesToolView ()

@property (strong, nonatomic) NSMutableArray *buttonsArr;

@property (strong, nonatomic) NSMutableArray *linesArr;

@property (weak, nonatomic) UIButton *retweet;

@property (weak, nonatomic) UIButton *comment;

@property (weak, nonatomic) UIButton *unlike;

@end
@implementation YQStatuesToolView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupChildesView];
        self.userInteractionEnabled = YES;
        [self setImage: [UIImage imageWithStretchImageNamed:@"timeline_card_bottom_background"]];
        
    }
    return self;
}

#pragma mark - 设置子控件
- (void)setupChildesView {
    
    // 添加按钮
    UIButton *retweet = [self setUpButtonWith:[UIImage imageWithStretchImageNamed:@"timeline_icon_retweet"] title:@"转发"];
    _retweet = retweet;
    
    UIButton *comment = [self setUpButtonWith:[UIImage imageWithStretchImageNamed:@"timeline_icon_comment"] title:@"评论"];
    _comment = comment;
    
    UIButton *unlike = [self setUpButtonWith:[UIImage imageWithStretchImageNamed:@"timeline_icon_unlike"] title:@"赞"];
    _unlike = unlike;
    
    // 添加分隔线
    for (int i = 0; i < self.buttonsArr.count - 1; ++i) {
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageWithStretchImageNamed:@"timeline_card_bottom_line"]];
        [self addSubview:image];
        [self.linesArr addObject:image];
    }
    
}

- (UIButton *)setUpButtonWith:(UIImage *)image title:(NSString *)title {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self addSubview:button];
    
    [self.buttonsArr addObject:button];
    return button;
}

#pragma mark - 设置转发数，评论数，点赞数
- (void)setStatus:(YQStatuses *)status {
    _status = status;
   
    // 设置转发按钮
    [self setTitleButton:_retweet count:status.reposts_count];
    
    // 设置评论
    [self setTitleButton:_comment count:status.comments_count];
    
    // 点赞数
    [self setTitleButton:_unlike count:status.attitudes_count];
    
    
}

/// 设置按钮标题

- (void)setTitleButton:(UIButton *)button count:(int)count {
    NSString *title = nil;
    //    status.reposts_count = 11002;
    if (count) {
        
        if (count > 10000) {
            CGFloat floatCount = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1fW",floatCount];
            title = [title stringByReplacingOccurrencesOfString:@".0"
                                                     withString:@""];
        } else {
            
            title = [NSString stringWithFormat:@"%d",count];
        }
        
        [button setTitle:title forState:UIControlStateNormal];
    }
}

#pragma mark - 布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSUInteger integer = self.buttonsArr.count;
    CGFloat w = YQScreenWidth / integer;
    CGFloat h = self.height;
    CGFloat y = 0;
    CGFloat x = 0;
    
    for (int i = 0; i < integer; ++i) {
        UIButton *button = self.buttonsArr[i];
        x = i * w;
        button.frame = CGRectMake(x, y, w, h);
    }
    
    int i = 1;
    for (UIImageView *image in self.linesArr) {
        UIButton *button = self.buttonsArr[i];
        image.x = button.x;
        i++;
    }
    
}

#pragma mark - 懒加载
- (NSMutableArray *)buttonsArr {
    if (_buttonsArr != nil) {
        return _buttonsArr;
    }
    _buttonsArr = [NSMutableArray array];
    return _buttonsArr;
}

- (NSMutableArray *)linesArr {
    if (_linesArr != nil) {
        return _linesArr;
    }
    _linesArr = [NSMutableArray array];
    return _linesArr;
}

@end
