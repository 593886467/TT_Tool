//
//  FTT_ArcRotateV.m
//  FTT_LoadAnimation
//
//  Created by tengtengdang on 2018/5/16.
//  Copyright © 2018年 FTT. All rights reserved.
//

#import "FTT_ArcRotateV.h"
#import "FTT_ShareLayer.h"
#import "FTT_AnimationTool.h"
#import "FTT_Helper.h"
@interface FTT_ArcRotateV ()
/** 弧线 */
@property (nonatomic , strong) CAShapeLayer *arc_ShareLayer;

@property (nonatomic , strong) CAGradientLayer *gradient;

@property (nonatomic , strong) CAGradientLayer *gradient1;
/** 圆中心 */
@property (nonatomic , assign) CGPoint arc_Point;

/** 渐变色视图 */
@property (nonatomic , strong) CALayer *ColorView;

@property (nonatomic , assign) FTT_ArcRotateVType Type;

@property (nonatomic , strong) CALayer *ImageLayer;

@end

@implementation FTT_ArcRotateV



#pragma mark ---- 生命周期

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configDefault];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
         [self configDefault];
    }
    return self;
}

#pragma mark ---- 回调协议


#pragma mark ---- 公开方法

/*
 功能：动画开始
 备注：不带文字
 */
- (void)arc_starwithType:(FTT_ArcRotateVType)Type {
    [self arc_starwithType:Type Title:self.arc_title];
}

/*
 功能：动画开始
 备注：可添加文字
 */
- (void)arc_starwithType:(FTT_ArcRotateVType)Type Title:(NSString *)Title {
    [self arc_initTitleLabel:Title];
    self.Type = Type;
    if (Type == FTT_ArcRotateVTypeDefault) {
        [self arc_initArcRotateVTypeDefault];
    }else if (Type == FTT_ArcRotateVTypeGradientcolor) {
        [self arc_initArcRotateVTypeGradientcolor];
    }else if (Type == FTT_ArcRotateVTypeDoubleGradientColor) {
        [self arc_initArcRotateVTypeDoubleGradientcolor];
    }
}

- (void)arc_star {
    [self.layer addSublayer:self.arc_ShareLayer];
    if (self.Type == FTT_ArcRotateVTypeDefault) {
        [FTT_AnimationTool addcircularAnimationlayer:self.arc_ShareLayer duration:1 rotation:kCARotationZ];
    }else if (self.Type == FTT_ArcRotateVTypeGradientcolor) {
        [self.ColorView setMask:self.arc_ShareLayer];
        [self.layer addSublayer:self.ColorView];
        [FTT_AnimationTool addcircularAnimationlayer:self.ColorView duration:1 rotation:kCARotationZ];
    }else if (self.Type == FTT_ArcRotateVTypeDoubleGradientColor) {
        [self.layer addSublayer:self.ColorView];
        [self.layer addSublayer:self.ImageLayer];
        [self.ColorView setMask:self.arc_ShareLayer];
        [FTT_AnimationTool addcircularAnimationlayer:self.ColorView duration:1 rotation:kCARotationZ];
    }
}

/*
 功能：动画结束
 备注：无
 */
- (void)arc_end {
    [self.arc_ShareLayer removeAllAnimations];
    [self.arc_ShareLayer removeFromSuperlayer];
    [self.ColorView removeFromSuperlayer];
    [self.ImageLayer removeFromSuperlayer];
    [self removeFromSuperview];
}

#pragma mark ---- 私有方法
/*
 功能：默认配置
 备注：设置弧线默认配置
 */
- (void)configDefault {
    self.arc_fillColor              = [UIColor clearColor];
    self.arc_strokColor             = [UIColor whiteColor];
    self.arc_lineWith               = 1.5;
    self.arc_ShareLayer.strokeStart = 0;
    self.arc_ShareLayer.strokeEnd   = 1;
    self.arc_backgroundColor        = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    self.arc_cornerRadius           = 4;
    self.arc_startAngle             = 0;
    self.arc_endAngle               = 300;
    self.arc_radius                 = 20;
}

/*
 功能：画弧线
 备注：参数配置
 */
-(UIBezierPath *)drawclickCircleBezierPath:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:CGPointMake(0, 0) radius:radius startAngle:degreesToRadians(startAngle) endAngle:degreesToRadians(endAngle)  clockwise:YES];

    return bezierPath;
}

/*
 功能：创建文本
 备注：无
 */
- (void)arc_initTitleLabel:(NSString *)title {
    if (title) {
        CGSize title_size = [FTT_Helper contentSizeOfString:title maxWidth:self.bounds.size.width - 10 font:[FTT_Helper confignormalfontsize:14]];
        CGFloat childe_h = title_size.height + 10 + self.arc_radius * 2;
        self.arc_ShareLayer.position =  CGPointMake(self.bounds.size.width / 2 , (self.bounds.size.height - childe_h) / 2  + self.arc_radius);
        self.Title_Label.frame = CGRectMake(5, (self.bounds.size.height - childe_h) / 2 + self.arc_radius * 2 + 10, self.bounds.size.width - 10, title_size.height);
        self.Title_Label.text = title;
        [self addSubview:self.Title_Label];
    }else {
        self.arc_ShareLayer.position =  CGPointMake(self.bounds.size.width / 2 , self.bounds.size.height / 2);
        [self.Title_Label removeFromSuperview];
    }
}



/*
 功能：创建渐变色承载视图
 备注：无
 */
- (void)arc_initGradientcolorlayer {
    CGFloat W = self.arc_radius + 2;
    CGRect Frame;
    if (self.arc_endAngle == 300) {
        self.arc_endAngle = 360;
    }
    self.arc_ShareLayer.path = [self drawclickCircleBezierPath:self.arc_radius startAngle:self.arc_startAngle endAngle:self.arc_endAngle].CGPath;
    if (self.Title_Label) {
        CGSize title_size = [FTT_Helper contentSizeOfString:self.Title_Label.text maxWidth:self.bounds.size.width - 10 font:[FTT_Helper confignormalfontsize:14]];
        CGFloat childe_h = title_size.height + 10 + W * 2;
        Frame = CGRectMake(self.bounds.size.width / 2 - W, (self.bounds.size.height - childe_h) / 2, W * 2, W * 2);
    }else {
        Frame = CGRectMake(self.bounds.size.width / 2 - W, self.bounds.size.height / 2 - W, W * 2, W * 2);
    }
    self.ColorView.frame = Frame;
    self.arc_ShareLayer.position = CGPointMake( Frame.size.width / 2,Frame.size.height / 2);
//    self.ImageLayer.position =  CGPointMake( Frame.size.width / 2,Frame.size.height / 2);
    self.ImageLayer.frame = Frame;
}

/*
 功能：创建默认ShareLayer;
 备注：无
 */
- (void)arc_initArcRotateVTypeDefault {
    if (self.arc_endAngle == 360) {
        self.arc_endAngle = 300;
    }
    self.arc_ShareLayer.path = [self drawclickCircleBezierPath:self.arc_radius startAngle:self.arc_startAngle endAngle:self.arc_endAngle].CGPath;
}

/*
 功能：创建渐变色ShareLayer
 备注：无
 */
- (void)arc_initArcRotateVTypeGradientcolor {
    [self arc_initGradientcolorlayer];
    [self arc_configGradientcolorIsDouble:NO];
}

/*
 功能：创建double渐变色
 备注：无
 */
- (void)arc_initArcRotateVTypeDoubleGradientcolor {
    [self arc_initGradientcolorlayer];
    [self arc_configGradientcolorIsDouble:YES];
}

/*
 功能：设置渐变色
 备注：YorN YES 两个相同的渐变色 NO 从头到位的渐变色
 */
- (void)arc_configGradientcolorIsDouble:(BOOL)YorN {
    CGFloat S1,S2;
    if (YorN) {
        S1 = 0;
        S2 = 1;
    }else {
        S1 = 0.5;
        S2 = 0.5;
    }
    CGRect Frame = self.ColorView.frame;
    self.gradient.colors = [NSArray arrayWithObjects:
                            (id)[UIColor whiteColor].CGColor,
                            (id)[[UIColor whiteColor]colorWithAlphaComponent:S1].CGColor,
                            nil];
    self.gradient.frame = CGRectMake(0, 0, Frame.size.width / 2, Frame.size.height);
    self.gradient1.colors = [NSArray arrayWithObjects:
                             (id)[[UIColor whiteColor]colorWithAlphaComponent:0.0].CGColor,
                             (id)[[UIColor whiteColor]colorWithAlphaComponent:S2].CGColor,
                             nil];
    self.gradient1.frame = CGRectMake(Frame.size.width / 2 , 0, Frame.size.width / 2 , Frame.size.height);
    [self.ColorView addSublayer:self.gradient];
    [self.ColorView addSublayer:self.gradient1];
}


#pragma mark ---- 存取方法


- (void)setArc_strokColor:(UIColor *)arc_strokColor {
    _arc_strokColor                 = arc_strokColor;
    self.arc_ShareLayer.strokeColor = arc_strokColor.CGColor;
}

- (void)setArc_fillColor:(UIColor *)arc_fillColor {
    _arc_fillColor                = arc_fillColor;
    self.arc_ShareLayer.fillColor = arc_fillColor.CGColor;
}

- (void)setArc_lineWith:(CGFloat)arc_lineWith {
    _arc_lineWith                 = arc_lineWith;
    self.arc_ShareLayer.lineWidth = arc_lineWith;
}

- (void)setArc_backgroundColor:(UIColor *)arc_backgroundColor {
    _arc_backgroundColor = arc_backgroundColor;
    self.backgroundColor = arc_backgroundColor;
}

- (void)setArc_cornerRadius:(CGFloat)arc_cornerRadius {
    _arc_cornerRadius        = arc_cornerRadius;
    self.layer.cornerRadius  = arc_cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setArc_imgaeStr:(NSString *)arc_imgaeStr {
    self.ImageLayer.contents = (__bridge id)[UIImage imageNamed:arc_imgaeStr].CGImage;
}


- (void)setArc_title:(NSString *)arc_title {
    _arc_title = arc_title;
    [self arc_initTitleLabel:arc_title];
}
- (CAShapeLayer *)arc_ShareLayer {
    if (!_arc_ShareLayer) {
        _arc_ShareLayer = [[[FTT_ShareLayer alloc]init]Create_ShareLayer];
    }
    return _arc_ShareLayer;
}

- (UILabel *)Title_Label {
    if (!_Title_Label) {
        _Title_Label = [[UILabel alloc]init];
        _Title_Label.textAlignment = NSTextAlignmentCenter;
        _Title_Label.textColor = [UIColor whiteColor];
        _Title_Label.font = [UIFont boldSystemFontOfSize:14];
        _Title_Label.numberOfLines = 0;
    }
    return _Title_Label;
}

- (CALayer *)ColorView {
    if (!_ColorView) {
        _ColorView = [[CALayer alloc]init];
    }
    return _ColorView;
}

- (CAGradientLayer *)gradient {
    if (!_gradient) {
        _gradient = [ CAGradientLayer layer];
    }
    return _gradient;
}

- (CAGradientLayer *)gradient1 {
    if (!_gradient1) {
        _gradient1 = [CAGradientLayer layer];
    }
    return _gradient1;
}

- (CALayer *)ImageLayer {
    if (!_ImageLayer) {
        _ImageLayer = [CALayer layer];
    }
    return _ImageLayer;
}
@end
