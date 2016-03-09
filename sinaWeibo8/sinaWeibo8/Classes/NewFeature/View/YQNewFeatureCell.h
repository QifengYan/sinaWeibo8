//
//  YQNewFeatureCell.h
//  sinaWeibo8
//
//  Created by apple on 16/3/9.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQNewFeatureCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;


- (void)showStartButton;

- (void) isShow:(BOOL)show;

@end
