//
//  YQStatusCell.m
//  sinaWeibo8
//
//  Created by apple on 16/4/8.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQStatusCell.h"
#import "YQOriginalView.h"
#import "YQTransmitView.h"
#import "YQStatuesToolView.h"
#import "YQStatusViewModel.h"
@interface YQStatusCell ()

/// 原创view
@property (weak, nonatomic)  YQOriginalView *originalView;

/// 转发view
@property (weak, nonatomic) YQTransmitView *transmitView;

/// 工具条
@property (weak, nonatomic) YQStatuesToolView *toolView;

@end

@implementation YQStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //  添加子控件
        [self setupChildesView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - 工厂方法
+ (instancetype)statusCellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

#pragma mark - 布局子控件
- (void)setupChildesView{
    // 添加原创view
    YQOriginalView *originalView = [[YQOriginalView alloc] init];
    [self addSubview:originalView];
    _originalView = originalView;
    
    // 添加转发的view
    YQTransmitView *transmitView = [[YQTransmitView alloc] init];
    [self addSubview:transmitView];
    _transmitView = transmitView;
    
    // 添加工具条
    YQStatuesToolView *toolView = [[YQStatuesToolView alloc] init];
    toolView.backgroundColor = [UIColor redColor];
    [self addSubview:toolView];
    _toolView = toolView;
}

#pragma mark -  模型赋值
- (void)setStatuesF:(YQStatusViewModel *)statuesF {
    _statuesF = statuesF;
    
    _originalView.frame = statuesF.originalViewFrame;
    _originalView.statusF = _statuesF;
    _transmitView.frame = statuesF.transmitViewFrame;
    _transmitView.statusF = _statuesF;
    _toolView.frame = statuesF.toolFrame;
    
}


@end
