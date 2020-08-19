//
//  TT_ProgressV.m
//  TT_Wkweb
//
//  Created by tengtengdang on 2018/12/21.
//  Copyright © 2018 FTT. All rights reserved.
//

#import "TT_ProgressV.h"
#import "TT_DarkmodeTool.h"

#define PROGRESS_LINE_WIDTH 2


@interface TT_ProgressV ()

/** 路径  */
@property (nonatomic , strong) UIBezierPath *path;
/** 背景线 */
@property (nonatomic , strong) CAShapeLayer *BackGroudLayer;
/** 线 */
@property (nonatomic , strong) CALayer *GradientLayer;
/** 精度条 */
@property (nonatomic , strong) CAShapeLayer *ProgressLayer;
/** 颜色 */
@property (nonatomic , strong) CAGradientLayer *Gradient;
/** 结束位置 */
@property (nonatomic , assign) CGFloat strokeEnd;
@end

@implementation TT_ProgressV


#pragma mark 生命周期


- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        [self configDefaultattribute];
    }
    return self;
}


#pragma mark 回调协议

#pragma mark 触发方法

/// 创建背景
- (void)CreateBackGroudLayer:(UIBezierPath *)path {
    self.BackGroudLayer = [self CreateShapeLayer];
    self.BackGroudLayer.path = [path CGPath];
    self.BackGroudLayer.opacity = 1;
    self.BackGroudLayer.strokeStart = 0.0;
    self.BackGroudLayer.strokeEnd   = 1.0;
}

/// 创建进度条
- (void)CreateProgressLayer:(UIBezierPath *)path {
    self.ProgressLayer = [self CreateShapeLayer];
    self.ProgressLayer.strokeColor = [TT_DarkmodeTool TT_NormalWhite].CGColor;
    self.ProgressLayer.path = [path CGPath];
    self.ProgressLayer.strokeEnd = 0.0;
}


#pragma mark 公开方法

/// 设置进度条的起点
- (void)strokeStart:(CGFloat)value {
    self.ProgressLayer.speed = 1;
    self.ProgressLayer.strokeEnd = value;
}

/// 设置进度条的终点
- (void)strokeEnd:(CGFloat)value {
    [self CreateTransaction];
    self.ProgressLayer.speed = 1;
    self.strokeEnd = value;
    self.ProgressLayer.strokeEnd = value;
    [CATransaction commit];
}

/// 设置进度条走动的动画
- (void)animationWith:(CGFloat)y  {
    [self CreateTransaction];
    if (y<1) {
        self.alpha = 1;
        self.ProgressLayer.strokeEnd = y;
    }else {
        self.ProgressLayer.strokeEnd = 1.0f;
        self.alpha = 0;
    }
    [CATransaction commit];
}


#pragma mark 私有方法

/// 设置默认属性
- (void)configDefaultattribute {
    self.Type = FTT_ProgressVTypeLine;
    self.IS_ShowBackgoroudLine = YES;
    self.LineWidth = 2;
    self.BackgroundLineColor = [UIColor getColor:@"#f2f2f2"];
}

/// 设置动画配置
- (void)CreateTransaction {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:1];
}

/// 创建线
- (CAShapeLayer *)CreateShapeLayer {
    CAShapeLayer *ShaoeLayer = [CAShapeLayer layer];
    ShaoeLayer.frame = self.bounds;
    ShaoeLayer.lineCap = kCALineCapRound;
    ShaoeLayer.lineWidth = self.LineWidth;
    ShaoeLayer.fillColor = [UIColor clearColor].CGColor;
    return ShaoeLayer;
}
#pragma mark 存取方法


- (void)setLineWidth:(CGFloat)LineWidth {
    _LineWidth = LineWidth;
    self.BackGroudLayer.lineWidth = LineWidth;
    self.ProgressLayer.lineWidth  = LineWidth;
}

- (void)setIS_ShowBackgoroudLine:(BOOL)IS_ShowBackgoroudLine {
    if (IS_ShowBackgoroudLine) {
        [self.layer addSublayer:self.BackGroudLayer];
    }
}

- (void)setBackgroundLineColor:(UIColor *)BackgroundLineColor {
    self.BackGroudLayer.strokeColor = BackgroundLineColor.CGColor;
}

- (void)setType:(FTT_ProgressVType)Type {
    self.path = [UIBezierPath bezierPath];
    switch (Type) {
        case 1:{
            [self.path moveToPoint:CGPointMake(0, self.bounds.size.height / 2)];
            [self.path addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height/2)];
        }
            break;
        case 0:{
            self.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2.0f, self.bounds.size.height / 2.0f)
                                                       radius:self.bounds.size.height / 2.0f - self.LineWidth
                                                   startAngle:0
                                                     endAngle:M_PI * 2
                                                    clockwise:YES];
        }
            break;
    }
    [self CreateBackGroudLayer:self.path];
    [self CreateProgressLayer:self.path];
    
}

- (void)setColosArray:(NSArray *)ColosArray {
    self.GradientLayer = [CALayer layer];
    self.Gradient = [CAGradientLayer layer];
    self.Gradient.frame = self.bounds;
    [self.Gradient setColors:ColosArray];
    [self.Gradient setStartPoint:CGPointMake(0, 0)];
    [self.Gradient setEndPoint:CGPointMake(1, 0)];
    [self.GradientLayer addSublayer:self.Gradient];
    [self.GradientLayer setMask:self.ProgressLayer];
    [self.layer addSublayer:self.GradientLayer];

}



@end
