//
//  FTT_ShareLayer.m
//  FTT_LoadAnimation
//
//  Created by tengtengdang on 2018/5/21.
//  Copyright © 2018年 FTT. All rights reserved.
//

#import "FTT_ShareLayer.h"

@interface FTT_ShareLayer ()
/** 弧线 */
@property (nonatomic , strong) CAShapeLayer *ShareLayer;

@end


@implementation FTT_ShareLayer


#pragma mark ---- 生命周期

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configDefault];
    }
    return self;
}

#pragma mark ---- 回调协议

#pragma mark ---- 公开方法

- (CAShapeLayer *)Create_ShareLayer {
    self.ShareLayer.path = [self drawclickCircleBezierPath:self.shareLayer_radius startAngle:self.shareLayer_startAngle endAngle:self.shareLayer_endAngle].CGPath;
    return self.ShareLayer;
}

/*
 功能：创建渐变色
 备注：无
 */
+ (CAGradientLayer *)CreateGradientcolors:(NSArray *)colors {
    CAGradientLayer *GradientLayer = [CAGradientLayer layer];
    GradientLayer.colors           = colors;
    return GradientLayer;
}

/*
 功能：多功能创建渐变色
 备注：无
 */
+ (CAGradientLayer *)CreateGradientcolors:(NSArray *)colors
                                starPoint:(CGPoint)starPoint
                                 endPoint:(CGPoint)endPoint
                                locations:(NSArray<NSNumber *> *)locations {
    CAGradientLayer *GradientLayer = [CAGradientLayer layer];
    GradientLayer.colors           = colors;
    GradientLayer.startPoint       = starPoint;
    GradientLayer.endPoint         = endPoint;
    GradientLayer.locations        = locations;
    return GradientLayer;
}

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
                       lineDirection:(BOOL)isHorizonal {

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];

    [shapeLayer setBounds:lineView.bounds];

    if (isHorizonal) {

        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];

    } else{
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame)/2)];
    }

    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    if (isHorizonal) {
        [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    } else {

        [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
    }
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);

    if (isHorizonal) {
        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    } else {
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(lineView.frame));
    }

    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

#pragma mark ---- 私有方法

/*
 功能：设置默认属性
 备注：无
 */
- (void)configDefault {
    self.shareLayer_strokColor = [UIColor whiteColor];
    self.shareLayer_fillColor  = [UIColor clearColor];
    self.shareLayer_lineWith   = 1.5;
    self.shareLayer_startAngle = 0;
    self.shareLayer_endAngle   = 300;
    self.shareLayer_radius     = 20;
}

- (UIBezierPath *)drawclickCircleBezierPath:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:CGPointMake(0, 0) radius:radius startAngle:degreesToRadians(startAngle) endAngle:degreesToRadians(endAngle)  clockwise:YES];
    return bezierPath;
}

#pragma mark ---- 存取方法

- (void)setShareLayer_strokColor:(UIColor *)shareLayer_strokColor {
    self.ShareLayer.strokeColor = shareLayer_strokColor.CGColor;
}

- (void)setShareLayer_fillColor:(UIColor *)shareLayer_fillColor {
    self.ShareLayer.fillColor = shareLayer_fillColor.CGColor;
}

- (void)setShareLayer_lineWith:(CGFloat)shareLayer_lineWith {
    self.ShareLayer.lineWidth = shareLayer_lineWith;
}

- (CAShapeLayer *)ShareLayer {
    if (!_ShareLayer) {
        _ShareLayer             = [CAShapeLayer layer];
        _ShareLayer.strokeStart = 0;
        _ShareLayer.strokeEnd   = 0;
    }
    return _ShareLayer;
}

@end
