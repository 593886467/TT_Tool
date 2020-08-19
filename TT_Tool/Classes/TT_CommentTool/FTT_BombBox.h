//
//  FTT_BombBox.h
//  95128
//
//  Created by 樊腾 on 17/6/24.
//  Copyright © 2017年 FTT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTT_ButtonModule.h"
@protocol FTT_BombBoxDelegate <NSObject>

/**
 选中按钮

 @param tag  998 取消 999 确定
 */
- (void)FTT_BombBoxSelectBtn:(NSInteger)tag;

@end

@interface FTT_BombBox : UIView



/**
 标示
 */
@property (nonatomic , assign) NSInteger FTT_BomboTag;

/**
 回调
 */
@property (nonatomic , weak) id <FTT_BombBoxDelegate> FTT_BoxDelegate;



// -----------------------   简单的消息弹框  ---------------------- // 

//+ (instancetype)shareBomBox;
- (void)FrameWithTilteMessage:(NSString *)Message CancerMessage:(NSString *)CancerMessage SureMessage:(NSString *)SureMessage andType:(FTT_ButtonModuleType)type;

- (void)FrameWithTilteMessage:(NSString *)Message CancerMessage:(NSString *)CancerMessage SureMessage:(NSString *)SureMessage andType:(FTT_ButtonModuleType)type iskeywindow:(BOOL)iskeywindow;



@end
