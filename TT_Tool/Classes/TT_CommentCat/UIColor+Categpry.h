//
//  UIColor+Categpry.h
//  大学帮帮-企业版
//
//  Created by cmcc on 16/7/29.
//  Copyright © 2016年 HangLong Lv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Categpry)

/**
 RGB 转换为颜色

 @param RGB 颜色RGB
 @return 对应的颜色
 */
+ (UIColor *)getColor:(NSString *)RGB;


+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr;

@end
