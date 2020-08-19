//
//  Custonbtn.h
//  95128
//
//  Created by 樊腾 on 17/7/10.
//  Copyright © 2017年 FTT. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM( NSInteger ,UIButtonTitleAndImageType ) {
    UIButtonTitleAndImageTypeLift = 0, // 图在左 字在右
    UIButtonTitleAndImageTypeRight ,   // 图在右 字在左
    UIButtonTitleAndImageTypeTop ,     // 图在上 字在下
    UIButtonTitleAndImageTypeBottom ,   // 图在下 字在上
    UIButtonTitleAndImageTypeNormal
    
};


@interface TT_Custonbtn : UIButton


@property (nonatomic , assign) CGFloat ImageW;

@property (nonatomic , assign) CGFloat ImageH;

@property (nonatomic , assign) CGFloat TtileW;

@property (nonatomic , assign) CGFloat TitleH;

@property (nonatomic , assign) CGFloat PYX;

@property (nonatomic , assign) UIButtonTitleAndImageType type;

@property (nonatomic , assign) BOOL is_geust;

- (void)comfigurlImagurl:(NSString *)imageurl;




@end
