//
//  UIImage+YQImage.m
//  sinaWeibo
//
//  Created by apple on 16/2/2.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "UIImage+YQImage.h"

@implementation UIImage (YQImage)

+ (instancetype)imageWithOriginalNamed:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
