//
//  FTT_HudTool.m
//  95128-Driver
//
//  Created by 樊腾 on 17/8/9.
//  Copyright © 2017年 FTT. All rights reserved.
//

#import "FTT_HudTool.h"
#import "TT_DarkmodeTool.h"
#import "FTT_AnimationTool.h"
@interface FTT_HudTool ()

@property (nonatomic , strong) MBProgressHUD *HUD;

@end

@implementation FTT_HudTool

+ (instancetype)share_FTT_HudTool {
    static FTT_HudTool *MW = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        MW = [[FTT_HudTool alloc]init];
    });
    return MW;
}

/**
 设置弹框

 @param Message 信息
 @param SubView 视图
 @param Mode 类型
 @param ImageName 图片名字
 @param time 展示时间
 @param back 消失回调
 */
- (void)CreateHUD:(NSString *)Message AndView:(UIView *)SubView  AndMode:(MBProgressHUDMode)Mode AndImage:(NSString *)ImageName  AndAfterDelay:(CGFloat)time AndBack:(HUDBack)back {
    [self CreateMBProgressHUDModeIndeterminateForVeiw:SubView];
    self.HUD.mode = Mode;
    if (Mode == MBProgressHUDModeCustomView) {
        UIImageView *ImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:ImageName]];
        [FTT_AnimationTool addScaleAnimationOnView:ImageV repeatCount:1 duration:0.5];
        self.HUD.customView = ImageV;
    }
    self.HUD.label.text = Message;
    self.HUD.label.font = [UIFont systemFontOfSize:12];
    self.HUD.label.textColor = [TT_DarkmodeTool TT_NormalWhite];
    [self.HUD hideAnimated:YES afterDelay:time];
    self.HUD.completionBlock = ^() {
        if (back) {
            back();
        }
    };
}

- (void)CreateHUD:(NSString *)Message AndView:(UIView *)SubView  AndMode:(MBProgressHUDMode)Mode AndImage:(NSString *)ImageName  AndBack:(HUDBack)back {

    [self CreateMBProgressHUDModeIndeterminateForVeiw:SubView];
    self.HUD.mode = Mode;
    if (Mode == MBProgressHUDModeCustomView) {
        UIImageView *ImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:ImageName]];
        [FTT_AnimationTool addScaleAnimationOnView:ImageV repeatCount:1 duration:0.5];
        self.HUD.customView = ImageV;
    }
    self.HUD.label.text = Message;
    self.HUD.label.font = [UIFont systemFontOfSize:12];
    self.HUD.label.textColor = [TT_DarkmodeTool TT_NormalWhite];
   
    self.HUD.completionBlock = ^() {
        if (back) {
            back();
        }
    };
}

- (void)dissmiss {
    [self.HUD hideAnimated:YES];
    [self.HUD removeFromSuperview];
}



- (void)CreateMBProgressHUDModeIndeterminateForVeiw:(UIView *)view {
    //设置菊花框为白色
    self.HUD = [[MBProgressHUD alloc]initWithView:view];
    self.HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    self.HUD.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
     [UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[[MBProgressHUD class]]].color = [TT_DarkmodeTool TT_NormalWhite];
    [self.HUD showAnimated:YES];
    [view addSubview:self.HUD];

}

- (void)DelectMBProgressHUDModeIndeterminate {
    [self.HUD removeFromSuperview];
}

- (void)setProgress:(float)progress {
    self.HUD.progress = progress;
}



@end
