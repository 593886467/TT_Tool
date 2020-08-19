//
//  FTT_AnimationTool.m
//  FTT_LoadAnimation
//
//  Created by tengtengdang on 2018/5/19.
//  Copyright © 2018年 FTT. All rights reserved.
//

#import "FTT_AnimationTool.h"
#import <UIKit/UIKit.h>
@implementation FTT_AnimationTool


+ (void)addcircularAnimationlayer:(id)layer
                         duration:(float)duration
                         rotation:(NSString *)rotation {
    [FTT_AnimationTool addcircularAnimationlayer:layer
                                  duration:duration
                                  rotation:rotation
                               repeatCount:LONG_MAX
                              autoreverses:NO
                                 fromValue:@(0)
                                   toValue:@(M_PI * 2)];
}

/// 暂停动画
+ (void)pasuseAnimation:(CALayer *)layer {
    CFTimeInterval pauseTime = CACurrentMediaTime();
    /// 设置速度为0，t停止动画
    layer.speed = 0;
    /// 保存暂停时间，便于恢复
    layer.timeOffset = pauseTime;
}

/// 恢复动画
+ (void)resumeAnimation:(CALayer *)layer {
    /// 获取暂停时保存的时间
    CFTimeInterval pauseTime = layer.timeOffset;
    /// 设置速度
    layer.speed = 1.0;
    /// 清除开始时间
    layer.beginTime = 0.0;
    /// 计算开始时间
    CFTimeInterval beginTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pauseTime;
    /// 重设开始时间
    layer.beginTime = beginTime;
    
}


+ (void)addcircularAnimationlayer:(id)layer
                         duration:(float)duration
                         rotation:(NSString *)rotation
                      repeatCount:(NSInteger)repeatCount
                     autoreverses:(BOOL)autoreverses
                        fromValue:(id)fromValue
                          toValue:(id)toValue {
    [layer addAnimation:[FTT_AnimationTool configAnimationduration:duration
                                                          rotation:rotation
                                                       repeatCount:repeatCount
                                                      autoreverses:autoreverses
                                                         fromValue:fromValue
                                                           toValue:toValue]
                 forKey:@"animation"];
}

+ (CABasicAnimation *)configAnimationduration:(float)duration
                                     rotation:(NSString *)rotation
                                  repeatCount:(NSInteger)repeatCount
                                 autoreverses:(BOOL)autoreverses
                                    fromValue:(id)fromValue
                                      toValue:(id)toValue {
    
    NSString *Rotation            = rotation;
    CABasicAnimation *animation   = [CABasicAnimation animationWithKeyPath:Rotation];
    animation.fromValue           = fromValue;
    animation.toValue             = toValue;
    animation.duration            = duration;
    animation.repeatCount         = repeatCount;
    animation.autoreverses        = autoreverses;
    animation.removedOnCompletion = NO;
    animation.fillMode            = kCAFillModeForwards;
    return animation;
}


+ (void)addCATransitiontype:(CATransitionType)type
                   duration:(CGFloat)duration
                      layer:(id)layer{
    CATransition *transition = [CATransition animation];
    transition.duration = duration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    transition.type = type;
    [layer addAnimation:transition forKey:@"transition"];
}

/** 缩放动画 */
+ (void)addScaleAnimationOnView:(UIView *)animationView repeatCount:(float)repeatCount duration:(float)duration{
    //需要实现的帧动画，这里根据需求自定义
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.repeatCount = repeatCount;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:nil];
}

/** 旋转动画 */
+ (void)addRotateAnimationOnView:(UIView *)animationView {
    // 针对旋转动画，需要将旋转轴向屏幕外侧平移，最大图片宽度的一半
    // 否则背景与按钮图片处于同一层次，当按钮图片旋转时，转轴就在背景图上，动画时会有一部分在背景图之下。
    // 动画结束后复位
    animationView.layer.zPosition = 65.f / 2;
    [UIView animateWithDuration:0.32 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        animationView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.70 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            animationView.layer.transform = CATransform3DMakeRotation(2 * M_PI, 0, 1, 0);
        } completion:nil];
    });
}







@end
