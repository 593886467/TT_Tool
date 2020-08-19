//
//  UIImage+Rotate.h
//  FTT_AuxiliaryTools
//
//  Created by 樊腾 on 17/6/8.
//  Copyright © 2017年 FTT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Rotate)

/**
 设置图片方向(顺时针)

 @param degrees 角度
 @return 转换后的图片
 */
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

/**
 设置图片方向(逆时针)

 @param Angle 角度
 @return 转换后的图片
 */
- (UIImage*)imageRotatedByAngle:(CGFloat)Angle;
/// 设置图片的位置
+ (UIImage *)pz_reSizeImage:(UIImage *)image imageframe:(CGRect)imageframe ;
/// 设置图片的颜色
- (UIImage *)imageWithColor:(UIColor *)color;
/// 切圆角
- (UIImage *)imageWithRadius:(CGFloat)radius rectSize:(CGSize)rectSize;

/// 特定方向切圆角
- (UIImage *)imageWithbyRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
@end
