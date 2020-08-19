//
//  UIViewController+TT_ConfigNet.h
//  捕鱼达人
//
//  Created by tengtengdang on 2019/4/15.
//  Copyright © 2019 FTT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TT_BaseVM.h"
#import "UIViewController+TT_configV.h"
#import "TT_CommentMaco.h"
@interface UIViewController (TT_ConfigNet)

@property (nonatomic , strong) TT_BaseVM *VM;


- (void)setupVM:(Class)VM;

/// 数据请求
- (void)configDataforNewnetWorkname:(NSString *)networkName
                             params:(NSMutableDictionary *)params
                       networkClass:(Class)networkClass;

- (void)configDataforNewnetWorkname:(NSString *)networkName
                             params:(NSMutableDictionary *)params
                        networkMark:(NSString *)networkMark
                       networkClass:(Class)networkClass;

/// 网络请求回调
- (void)loadSuccessDataconversionallData:(id)Alldata
                                    Data:(id)Data
                                has_more:(BOOL)has_more
                                    mark:(NSString *)mark;



- (void)DatajudgmentallData:(id)allData
                       Data:(id)Data
                       YorN:(BOOL)YorN
                   has_more:(BOOL)has_more
                       mark:(NSString *)mark;
/// 请求成功数据赋值
- (void)configsubview:(NSMutableArray *)arr
             has_more:(BOOL)has_more
                 mark:(NSString *)mark;

/// 单纯的数据返回
- (id)changeData:(id)Data
            mark:(NSString *)mark;
/// 设置tableV 数据
- (void)configTabelData:(NSMutableArray *)arr
               has_more:(BOOL)has_more;
/// 请求失败
- (void)RequstFailTankuangMarK:(NSString *)MarK;

- (void)RequestFailInfo:(id)info;
/// 加载成功设置黑色弹框
- (void)configSuccessTankuang:(NSString *)mark;
/// 加载失败设置黑色弹框
- (void)configFailTankuang:(NSString *)mark ;

- (void)configData;

- (void)configNothingVis_hide:(BOOL)YorN;

@end

