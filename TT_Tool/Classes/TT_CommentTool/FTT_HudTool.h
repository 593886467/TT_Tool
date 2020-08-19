//
//  FTT_HudTool.h
//  95128-Driver
//
//  Created by 樊腾 on 17/8/9.
//  Copyright © 2017年 FTT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>
typedef void (^HUDBack)(void);

@interface FTT_HudTool : NSObject

@property (nonatomic , assign) float progress;
+ (instancetype)share_FTT_HudTool;
/**
 设置弹框

 @param Message 信息
 @param SubView 视图
 @param Mode 类型
 @param ImageName 图片名字
 @param time 展示时间
 @param back 消失回调
 */
- (void)CreateHUD:(NSString *)Message AndView:(UIView *)SubView  AndMode:(MBProgressHUDMode)Mode AndImage:(NSString *)ImageName  AndAfterDelay:(CGFloat)time AndBack:(HUDBack)back;
/** 创建菊花转 */
- (void)CreateMBProgressHUDModeIndeterminateForVeiw:(UIView *)view;
///** 关闭菊花转 */
- (void)DelectMBProgressHUDModeIndeterminate;

- (void)CreateHUD:(NSString *)Message AndView:(UIView *)SubView  AndMode:(MBProgressHUDMode)Mode AndImage:(NSString *)ImageName  AndBack:(HUDBack)back;

- (void)dissmiss;
@end
