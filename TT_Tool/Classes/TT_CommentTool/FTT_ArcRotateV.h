//
//  FTT_ArcRotateV.h
//  FTT_LoadAnimation
//
//  Created by tengtengdang on 2018/5/16.
//  Copyright © 2018年 FTT. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger , FTT_ArcRotateVType) {
    /** 默认动画 */
    FTT_ArcRotateVTypeDefault = 0,
    /** 渐变色圆动画 */
    FTT_ArcRotateVTypeGradientcolor ,
    /** 两个渐变色 */
    FTT_ArcRotateVTypeDoubleGradientColor ,
    
    
};

@interface FTT_ArcRotateV : UIView
/** 弧线外环颜色 */
@property (nonatomic , strong) UIColor *arc_strokColor;
/** 弧内颜色 */
@property (nonatomic , strong) UIColor *arc_fillColor;
/** 文字描述 */
@property (nonatomic , strong) NSString *arc_title;
/** 中间图片 */
@property (nonatomic , strong) NSString *arc_imgaeStr;
/** 背景颜色 */
@property (nonatomic , strong) UIColor *arc_backgroundColor;
/** 弧线宽度 */
@property (nonatomic , assign) CGFloat arc_lineWith;
/** 圆弧起点 */
@property (nonatomic , assign) CGFloat arc_startAngle;
/** 圆弧终点 */
@property (nonatomic , assign) CGFloat arc_endAngle;
/** 背景圆角 */
@property (nonatomic , assign) CGFloat arc_cornerRadius;
/** 弧线半径 */
@property (nonatomic , assign) CGFloat arc_radius;
/** 动画执行时间 */
@property (nonatomic , assign) CGFloat arc_duration;
/** 显示文字视图 */
@property (nonatomic , strong) UILabel *Title_Label;

/*
 功能：设置类型
 备注：想要用带文字的，必须先设置文字才可以调用此方法
 */
- (void)arc_starwithType:(FTT_ArcRotateVType)Type;

/*
 功能：设置类型 带文字
 备注：无
 */
- (void)arc_starwithType:(FTT_ArcRotateVType)Type Title:(NSString *)Title;

/**
 动画开始
 */
- (void)arc_star;

/*
 功能：动画结束
 备注：无
 */
- (void)arc_end;


@end
