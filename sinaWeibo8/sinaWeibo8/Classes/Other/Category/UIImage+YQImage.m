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

+ (instancetype)imageWithStretchImageNamed:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    CGFloat width = image.size.width * 0.5;
    CGFloat height = image.size.height * 0.5;
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(height, width, height, width) resizingMode:UIImageResizingModeStretch];
}

@end
