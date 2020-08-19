//
//  TT_ProgressV.h
//  TT_Wkweb
//
//  Created by tengtengdang on 2018/12/21.
//  Copyright © 2018 FTT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TT_CommentCat.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger , FTT_ProgressVType) {
    /** 圆 */
    FTT_ProgressVTypeCircular = 0,
    /** 细线 */
    FTT_ProgressVTypeLine
};

@interface TT_ProgressV : UIView
/** 类型 默认为细线*/
@property (nonatomic , assign) FTT_ProgressVType Type;
/** 是否显示背景线 默认为YES*/
@property (nonatomic , assign) BOOL IS_ShowBackgoroudLine;
/** 颜色数组 */
@property (nonatomic , strong) NSArray *ColosArray;
/** 背景线颜色 默认为 grayColor 0.5 */
@property (nonatomic , strong) UIColor *BackgroundLineColor;
/** 细线宽度 默认为 2*/
@property (nonatomic , assign) CGFloat LineWidth;

/**
 设置起点
 
 @param value 进度
 */
- (void)strokeStart:(CGFloat)value;

/**
 设置终点
 
 @param value 进度
 */
- (void)strokeEnd:(CGFloat)value;

/**
 设置进度值
 
 @param y 值
 */
- (void)animationWith:(CGFloat)y ;

@end

NS_ASSUME_NONNULL_END
