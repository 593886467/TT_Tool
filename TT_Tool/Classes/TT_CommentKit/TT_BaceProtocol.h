//
//  TT_BaceProtocol.h
//  AFNetworking
//
//  Created by 樊腾 on 2020/8/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TT_BaceProtocol <NSObject>

@optional

/// 绑定 V（VC）与VM
- (void)tt_bindViewModel ;
/// 添加控件
- (void)tt_addSubviews;
/// 初次获取数据
- (void)tt_getNewDate;
/// 设置navation
- (void)tt_layoutNavigation;
/// 接收回调
- (void)tt_allClose;
/// 添加通知
- (void)tt_addNoti;
/// 删除通知
- (void)tt_deletNoti;
/// 返回按钮
- (void)CreateBack;
/// 添加导航栏按钮
- (void)tt_addnavgarItme ;
/// 修改默认配置
- (void)tt_changeDefauleConfiguration;
/// 返回按钮触发事件
- (void)BackBarButtonPressed:(id)sender;
/// 界面跳转
- (void)JumpController:(UIViewController *)Contrl;
/// 配置视图
- (void)configureViewFromLocalisation;
/// 右滑返回事件
- (void)tengteng_configdidMoveToParentV;
/// 配置键盘消失
- (void)tengteng_configkeyboardendEditing;
@end

NS_ASSUME_NONNULL_END
