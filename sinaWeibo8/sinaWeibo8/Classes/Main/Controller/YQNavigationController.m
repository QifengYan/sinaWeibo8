//
//  YQNavigationController.m
//  sinaWeibo8
//
//  Created by apple on 16/3/8.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQNavigationController.h"

@interface YQNavigationController ()

@end

@implementation YQNavigationController

+ (void)initialize {
    
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:nil, nil];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
