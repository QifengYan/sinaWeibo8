//
//  YQStatusCell.h
//  sinaWeibo8
//
//  Created by apple on 16/4/8.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YQStatusViewModel;
@interface YQStatusCell : UITableViewCell

@property (strong, nonatomic) YQStatusViewModel *statuesF;

// 工厂方法
+ (instancetype)statusCellWithTableView:(UITableView *)tableView;

@end
