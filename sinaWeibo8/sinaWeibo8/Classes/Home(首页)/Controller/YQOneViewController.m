//
//  YQOneViewController.m
//  sinaWeibo8
//
//  Created by apple on 16/3/8.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQOneViewController.h"

@interface YQOneViewController ()

@end

static NSString *ID = @"cell";

@implementation YQOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellEditingStyleNone;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}

@end
