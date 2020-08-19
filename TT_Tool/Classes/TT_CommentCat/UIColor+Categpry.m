//
//  UIColor+Categpry.m
//  大学帮帮-企业版
//
//  Created by cmcc on 16/7/29.
//  Copyright © 2016年 HangLong Lv. All rights reserved.
//

#import "UIColor+Categpry.h"

@implementation UIColor (Categpry)

/**
 RGB 转换为颜色

 @param RGB 颜色RGB
 @return 对应的颜色
 */
+ (UIColor *)getColor:(NSString *)RGB {
    long red = strtoul([[RGB substringWithRange:NSMakeRange(1, 2)]UTF8String], 0, 16);
    long green = strtoul([[RGB substringWithRange:NSMakeRange(3, 2)]UTF8String], 0, 16);
    long blue = strtoul([[RGB  substringWithRange:NSMakeRange(5, 2)]UTF8String], 0, 16);
    return [UIColor colorWithRed:red / 255.0f green:green/ 255.0f blue:blue / 255.0f alpha:1];
}


+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr {
    //    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id)[UIColor getColor:fromHexColorStr].CGColor,(__bridge id)[UIColor getColor:toHexColorStr].CGColor];
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];
    return gradientLayer;
}



@end
