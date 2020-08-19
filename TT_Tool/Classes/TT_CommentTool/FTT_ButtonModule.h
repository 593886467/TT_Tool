//
//  FTT_ButtonModule.h
//  95128
//
//  Created by 樊腾 on 17/6/24.
//  Copyright © 2017年 FTT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , FTT_ButtonModuleType) {
    FTT_ButtonModuleTypeCancer = 0 ,
    FTT_ButtonModuleTypeSure
};

@protocol FTT_ButtonModuleDelegate <NSObject>

/**
 选中按钮

 @param tag  998 取消 999 确定
 */
- (void)FTT_ButtonModuleSelectBtn:(NSInteger)tag;

@end
@interface FTT_ButtonModule : UIView

/**
 取消按钮
 */
@property (nonatomic , strong) UIButton *CancerBtn;

/**
 确定按钮
 */
@property (nonatomic , strong) UIButton *SureBtn;

/**
 回调
 */
@property (nonatomic , weak) id <FTT_ButtonModuleDelegate> delegate;

// -----------------------   确定取消按钮  ---------------------- //
/**
 界面搭建

 @param CancerMessage 取消
 @param Message 确定
 @param type 类型
 */
- (void)CreateCancerMessage:(NSString *)CancerMessage SureMessage:(NSString *)Message andType:(FTT_ButtonModuleType)type;

@end
