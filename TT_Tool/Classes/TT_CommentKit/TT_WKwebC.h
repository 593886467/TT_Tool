//
//  TT_WKwebC.h
//  TT_Wkweb
//
//  Created by tengtengdang on 2018/12/21.
//  Copyright © 2018 FTT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TT_BaseC.h"
#import "TT_WKweb.h"
NS_ASSUME_NONNULL_BEGIN

@interface TT_WKwebC : TT_BaseC <TT_WKwebDelegate>
/// WKwebview
@property (nonatomic , strong) TT_WKweb *Web;

@property (nonatomic , assign) CGRect Web_frame;

@property (nonatomic , strong) NSString *web_data;

@property (nonatomic , strong) NSString *web_url;
/// JS -> OC 的方法名
@property (nonatomic , strong) NSString *Web_configName;

@property (nonatomic , assign) BOOL is_openapp;
- (void)initconfig ;
/// 添加视图
- (void)initSubViewS;
/// 添加导航栏
- (void)initnavgationItemS;
/// 所有回调
- (void)configWKwebC_allClose;
/// 刷新Web
- (void)configWKweb_reload;
/// H5 返回上一个界面
- (void)configWKweb_goBack;
/// 改变默认配置
- (void)changeDefaultConfiguration;
/// JS -> OC 回调
- (void)configJSinvokeOCinfo:(WKScriptMessage *)info;
/// 获取wkweb的拦截信息
- (void)configPolicyForNavigationAction:(WKNavigationAction *)NavigationAction decisionHandler:(nonnull void (^)(WKNavigationActionPolicy))decisionHandler;
/// 自定义控件是否显示
- (void)configPublicmenthodcontrolisHide:(BOOL)Ishide;



#pragma mark -- 对象直接调用的方法
/// web 请求数据
- (void)configloadRequestWKweb_Url:(NSString *)WKweb_Url WKweb_data:(NSString *)WKweb_data WKweb_requesStatus:(TT_WKwebType)WKweb_requesStatus;
/// OC -> JS
- (void)configwkwebOCtouchJS:(NSString *)javaScript;






@end

NS_ASSUME_NONNULL_END
