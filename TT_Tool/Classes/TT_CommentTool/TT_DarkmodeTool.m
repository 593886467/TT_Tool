//
//  TT_DarkmodeTool.m
//   
//
//  Created by 樊腾 on 2020/3/16.
//  Copyright © 2020 绑耀. All rights reserved.
//

#import "TT_DarkmodeTool.h"
#import "TT_CommentCat.h"
@implementation TT_DarkmodeTool


+ (UIColor *)TT_NormalWhite {
    return [TT_DarkmodeTool colorWithArray:@[Col_FFF,Col_1E1]];
}




+ (UIColor *)TT_Normal2F2 {
    return [TT_DarkmodeTool colorWithArray:@[Col_2F2,Col_D5D]];
}

+ (UIColor *)TT_NormaFFE {
    return [TT_DarkmodeTool colorWithArray:@[Col_FFE,Col_FFF]];
}

+ (UIColor *)TT_norma333 {
    return [TT_DarkmodeTool colorWithArray:@[Col_333,Col_D5D]];
}


+ (UIColor *)TT_norma222 {
    return [TT_DarkmodeTool colorWithArray:@[Col_222,Col_D5D]];
}





+ (UIColor *)TT_Normal595 {
    return [TT_DarkmodeTool colorWithArray:@[Col_595,Col_7C7]];
}


+ (UIColor *)TT_normaF7F {
    return [TT_DarkmodeTool colorWithArray:@[Col_F7F,Col_121]];
}

+ (UIColor *)TT_normaF3F {
    return [TT_DarkmodeTool colorWithArray:@[Col_F3F,Col_303]];
}


+ (UIColor *)TT_norma7F7 {
    return [TT_DarkmodeTool colorWithArray:@[Col_7F7,Col_CAC]];
}


+ (UIColor *)TT_normaEEE {
    return [TT_DarkmodeTool colorWithArray:@[Col_EEE,Col_303]];
}





+ (UIColor *)TT_noraml666 {
    return [TT_DarkmodeTool colorWithArray:@[Col_666,Col_CAC]];
}

+ (UIColor *)TT_norma999 {
    return [TT_DarkmodeTool colorWithArray:@[Col_999,Col_7C7]];
}

+ (UIColor *)TT_normaF4F {
    return [TT_DarkmodeTool colorWithArray:@[Col_F4F,Col_303]];
}

+ (UIColor *)TT_normaF8F {
    return [TT_DarkmodeTool colorWithArray:@[Col_F8F,Col_2D2]];
}


+ (UIColor *)TT_normaF2F {
    return [TT_DarkmodeTool colorWithArray:@[Col_F2F,Col_2D2]];
}



+ (UIColor *)TT_normaF8B {
    return [TT_DarkmodeTool colorWithArray:@[Col_F8B,Col_121]];
}




+ (UIColor *)colorWithArray:(NSArray *)colorArray{
    if (colorArray == nil || colorArray.count == 0) {
        return [UIColor whiteColor];
    }
    if (@available(iOS 13.0, *)) {
        UIColor * color = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection)
        {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight)
            {
                return colorArray.firstObject;
            }
            else if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark)
            {
                return  colorArray.lastObject;
            }
            return colorArray.firstObject;
        }];
        return color;
    }
    return colorArray.firstObject;
}

@end
