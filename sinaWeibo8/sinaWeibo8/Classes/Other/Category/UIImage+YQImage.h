//
//  UIImage+YQImage.h
//  sinaWeibo
//
//  Created by apple on 16/2/2.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YQImage)

/**
 *  返回一张原型图片
 */
+ (instancetype)imageWithOriginalNamed:(NSString *)imageName;

/**
 *  根据图片名称创建拉伸不变形图片
 */
+ (instancetype)imageWithStretchImageNamed:(NSString *)name;

@end
