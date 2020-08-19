//
//  FTT_ShareLayer.h
//  FTT_LoadAnimation
//
//  Created by tengtengdang on 2018/5/21.
//  Copyright © 2018年 FTT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** 转换角度 */
#define degreesToRadians(x) (M_PI*(x)/180.0)
@interface FTT_ShareLayer : NSObject

/** 弧线外环颜色 */
@property (nonatomic , strong) UIColor *shareLayer_strokColor;
/** 弧内颜色 */
@property (nonatomic , strong) UIColor *shareLayer_fillColor;
/** 圆弧起点 */
@property (nonatomic , assign) CGFloat shareLayer_startAngle;
/** 圆弧终点 */
@property (nonatomic , assign) CGFloat shareLayer_endAngle;
/** 弧线半径 */
@property (nonatomic , assign) CGFloat shareLayer_radius;
/** 弧线宽度 */
@property (nonatomic , assign) CGFloat shareLayer_lineWith;

/*
 功能：创建sharelayer
 备注：无
 */
- (CAShapeLayer *)Create_ShareLayer;
/*
 功能：创建渐变色
 备注：无
 */
+ (CAGradientLayer *)CreateGradientcolors:(NSArray *)colors;

/*
 功能：创建多参数渐变色
 备注：无
 */
+ (CAGradientLayer *)CreateGradientcolors:(NSArray *)colors
                                starPoint:(CGPoint)starPoint
                                 endPoint:(CGPoint)endPoint
                                locations:(NSArray<NSNumber *> *)locations;

- (UIBezierPath *)drawclickCircleBezierPath:(CGFloat)radius
                                 startAngle:(CGFloat)startAngle
                                   endAngle:(CGFloat)endAngle;

/**
 *  通过 CAShapeLayer 方式绘制虚线
 *
 *  param lineView:       需要绘制成虚线的view
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 **/
+ (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView
                          lineLength:(int)lineLength
                         lineSpacing:(int)lineSpacing
                           lineColor:(UIColor *)lineColor
                       lineDirection:(BOOL)isHorizonal;
@end
