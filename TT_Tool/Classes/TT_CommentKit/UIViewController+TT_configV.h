//
//  UIViewController+TT_configV.h
//  捕鱼达人
//
//  Created by tengtengdang on 2019/4/15.
//  Copyright © 2019 FTT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TT_BaseTableV.h"
#import "TT_BaseCollectionV.h"
#import "TT_NothingV.h"
#import "FTT_HudTool.h"
@class TT_CycleCollectionViewFlowLayout;


@interface UIViewController (TT_configV)<TT_BaseTableVDelegate,TT_BaseCollectionVDelegate>

@property (nonatomic , strong) TT_BaseTableV *TableV;

@property (nonatomic , strong) TT_BaseCollectionV *CollectionV;

@property (nonatomic , strong) TT_NothingV *NothingV;



/// 设置TableV
- (void)setupTableV:(Class)TableV ;

- (void)setupTableV:(Class)TabelV
              style:(UITableViewStyle)style;

- (void)setupTableV:(Class)TableV
              Frame:(CGRect)Frame;

- (void)setupTableV:(Class)TableV
              Frame:(CGRect)Frame
              style:(UITableViewStyle)style;

/// 设置CollectionV
- (void)setupCollectionV:(Class)CollectionV;

- (void)setupCollectionV:(Class)CollectionV
                   Frame:(CGRect)Frame;

- (void)setupCollectionV:(Class)CollectionV
                   Frame:(CGRect)Frame
                  layout:(TT_CycleCollectionViewFlowLayout *)layout;

/// 默认不开启点击事件
- (void)setupNothingV;
/// 是否打开点击事件
- (void)setupNothingVis_tap:(BOOL)is_tap;

- (void)setupNothingVforImgaeName:(NSString *)Imagename
                        titleName:(NSString *)titleName
                            Frame:(CGRect)Frame is_Tap:(BOOL)isTap;



#pragma mark 触发方法
/// 点击空界面 或 加载失败界面触发方法
- (void)TapNothingTriggermethod:(NSString *)Str ;
/// 文字加图片 黑色弹框
- (void)configTankuangTitle:(NSString *)Title
                  imageName:(NSString *)ImageName
                       Back:(HUDBack)back;


/// 纯文字弹框
- (void)configTextTankuangTitle:(NSString *)title;
/// 文字加动画的探矿
- (void)configTextTankuangTitle:(NSString *)title
                           type:(MBProgressHUDMode)type;


@end

