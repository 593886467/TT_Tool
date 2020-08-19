//
//  TT_ViewAppearOrdisappear.m
//  tengteng
//
//  Created by tengtengdang on 2019/3/19.
//  Copyright © 2019 腾腾. All rights reserved.
//

#import "TT_ViewAppearOrdisappear.h"
#import "TT_GeneralProfile.h"
@interface TT_ViewAppearOrdisappear ()

@property (nonatomic , strong) UIView *CustomV;

@property (nonatomic , assign) BOOL Is_tapself;

@end

@implementation TT_ViewAppearOrdisappear


#pragma mark 生命周期


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
   CGPoint cuspoint = [self convertPoint:point toView:self.CustomV];
    if ([self.CustomV pointInside:cuspoint withEvent:event]) {
        self.Is_tapself = NO;
    }else {
        self.Is_tapself = YES;
    }
    return [super hitTest:point withEvent:event];
}


#pragma mark 触发方法

- (void)closeBtnMethod {
    if (self.Is_tapself) {
        [self dismiss];
    }
}




#pragma mark 公开方法



- (void)configCustomcontrols:(UIView *)CustomV {
    self.CustomV = CustomV;
    [self addSubview:CustomV];
}

- (void)show {
    [self initDefaultFullscreendisplay];
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
        self.CustomV.transform = CGAffineTransformMakeTranslation(0, -self.CustomV.bounds.size.height);
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.alpha = 0;
                         self.CustomV.transform = CGAffineTransformIdentity;
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}
#pragma mark 私有方法

/// 默认设置界面
- (void)initDefaultFullscreendisplay {
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    self.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeBtnMethod)];
    [self addGestureRecognizer:tap];
}

#pragma mark 存取方法




@end
