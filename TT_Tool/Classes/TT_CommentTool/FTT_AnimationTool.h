//
//  FTT_AnimationTool.h
//  FTT_LoadAnimation
//
//  Created by tengtengdang on 2018/5/19.
//  Copyright © 2018年 FTT. All rights reserved.
//

#import <Foundation/Foundation.h>
/* 旋转x,y,z分别是绕x,y,z轴旋转 */
static NSString *kCARotation = @"transform.rotation";
static NSString *kCARotationX = @"transform.rotation.x";
static NSString *kCARotationY = @"transform.rotation.y";
static NSString *kCARotationZ = @"transform.rotation.z";

/* 缩放x,y,z分别是对x,y,z方向进行缩放 */
static NSString *kCAScale = @"transform.scale";
static NSString *kCAScaleX = @"transform.scale.x";
static NSString *kCAScaleY = @"transform.scale.y";
static NSString *kCAScaleZ = @"transform.scale.z";

/* 平移x,y,z同上 */
static NSString *kCATranslation = @"transform.translation";
static NSString *kCATranslationX = @"transform.translation.x";
static NSString *kCATranslationY = @"transform.translation.y";
static NSString *kCATranslationZ = @"transform.translation.z";

/* 平面 */
/* CGPoint中心点改变位置，针对平面 */
static NSString *kCAPosition = @"position";
static NSString *kCAPositionX = @"position.x";
static NSString *kCAPositionY = @"position.y";

/* CGRect */
static NSString *kCABoundsSize = @"bounds.size";
static NSString *kCABoundsSizeW = @"bounds.size.width";
static NSString *kCABoundsSizeH = @"bounds.size.height";
static NSString *kCABoundsOriginX = @"bounds.origin.x";
static NSString *kCABoundsOriginY = @"bounds.origin.y";

/* 透明度 */
static NSString *kCAOpacity = @"opacity";
/* 背景色 */
static NSString *kCABackgroundColor = @"backgroundColor";
/* 圆角 */
static NSString *kCACornerRadius = @"cornerRadius";
/* 边框 */
static NSString *kCABorderWidth = @"borderWidth";
/* 阴影颜色 */
static NSString *kCAShadowColor = @"shadowColor";
/* 偏移量CGSize */
static NSString *kCAShadowOffset = @"shadowOffset";
/* 阴影透明度 */
static NSString *kCAShadowOpacity = @"shadowOpacity";
/* 阴影圆角 */
static NSString *kCAShadowRadius = @"shadowRadius";

#import <UIKit/UIKit.h>
@interface FTT_AnimationTool : NSObject


/**
 沿着坐标系旋转

 @param layer 视图
 @param duration 动画执行时间
 @param rotation 坐标系（x,y,z）
 */
+ (void)addcircularAnimationlayer:(id)layer
                         duration:(float)duration
                         rotation:(NSString *)rotation;



/**
 沿着坐标系旋转

 @param layer 视图
 @param duration 动画执行时间
 @param rotation 坐标系（x,y,z）
 @param repeatCount 动画执行次数 LONG_MAX 无限
 @param autoreverses 动画结束时是否执行逆动画 默认NO
 @param fromValue 起点
 @param toValue 终点
 */
+ (void)addcircularAnimationlayer:(id)layer
                         duration:(float)duration
                         rotation:(NSString *)rotation
                      repeatCount:(NSInteger)repeatCount
                     autoreverses:(BOOL)autoreverses
                        fromValue:(id)fromValue
                          toValue:(id)toValue;


/// 暂停动画
+ (void)pasuseAnimation:(CALayer *)layer;
/// 恢复动画
+ (void)resumeAnimation:(CALayer *)layer;



///  kCATransitionFade
+ (void)addCATransitiontype:(CATransitionType)type
                   duration:(CGFloat)duration
                      layer:(id)layer;


+ (CABasicAnimation *)configAnimationduration:(float)duration
                                     rotation:(NSString *)rotation
                                  repeatCount:(NSInteger)repeatCount
                                 autoreverses:(BOOL)autoreverses
                                    fromValue:(id)fromValue
                                      toValue:(id)toValue ;

/** 缩放动画 */
+ (void)addScaleAnimationOnView:(UIView *)animationView
                    repeatCount:(float)repeatCount
                       duration:(float)duration;

/** 旋转动画 */
+ (void)addRotateAnimationOnView:(UIView *)animationView;



@end
