//
//  TT_WKweb.h
//  tengteng
//
//  Created by tengtengdang on 2018/10/9.
//  Copyright © 2018年 腾腾. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "TT_ProgressV.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger , TT_WKwebType) {
    GET = 0,
    POST
};

typedef NS_ENUM(NSInteger , TT_WKwebRequestStatus) {
    /// 开始加载
    TT_WKwebRequestStatusStart = 0,
    /// 即将加载完成
    TT_WKwebRequestStatusdidCommit ,
    /// 加载完成
    TT_WKwebRequestStatusFinish ,
    /// 加载失败
    TT_WKwebRequestStatusFail
};

@protocol TT_WKwebDelegate <NSObject>

@optional


/// 截取加载的URL
- (void)TT_WkwebdecidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;

/// JS -> OC 回传的数据
- (void)TT_WKwebJScallOCdidReceiveScriptMessage:(WKScriptMessage *)message ;
/// WK加载状态
- (void)TT_WkwebrequeStatus:(TT_WKwebRequestStatus)Status;
/// 获取内容的高度
- (void)TT_WKwebContentSizeHeight:(CGFloat)Height;
/// 滑动监听 和 上下滑动
- (void)TT_WkwebDidScroll:(UIScrollView *)ScrollView UporDown:(BOOL)YorN;
/// 开始手动滑动
- (void)TT_WkwebscrollViewWillBeginDragging:(UIScrollView *)scrollView;




@end



@interface TT_WKweb : UIView<WKNavigationDelegate,WKScriptMessageHandler,WKUIDelegate,UIScrollViewDelegate>
/// JS -> OC 方法名
@property (nonatomic , strong) NSString *configName;
///// 连接
@property (nonatomic , strong) NSString *wkweb_url;
/// 标题 
@property (nonatomic , strong) NSString *wkweb_title;

@property (nonatomic , assign) BOOL Is_jump;
/// 滑动上一次的位置
@property (nonatomic , assign) float oldY;
/// 网页
@property (nonatomic , strong) WKWebView *wkweb;
/// 网页中图片
@property (nonatomic , strong) NSMutableArray *ImageUrlArr;
/// 请求类型
@property (nonatomic , assign) TT_WKwebRequestStatus RequestStatus;
/// 进度条
@property (nonatomic , strong) TT_ProgressV *wkweb_pv;
/// 是否第一时间响应滑动回调
@property (nonatomic , assign) BOOL is_firstSlide;

@property (nonatomic , assign) CGFloat wkweb_pvY;

@property (nonatomic , assign) BOOL is_openapp;

@property (nonatomic , assign) BOOL is_cooki;

@property (nonatomic , strong) WKUserContentController *userContentController;

//请求的cookie
@property(nonatomic,strong)NSMutableString *badyhead;


/// 回调
@property (nonatomic , weak) id<TT_WKwebDelegate> TT_WKDelegate;
/// 获取数据
- (void)loadRequest:(NSString *)url data:(NSString *)data requestStatus:(TT_WKwebType)Status;
/// 设置偏移量
- (void)wkwebconfigOffestY:(CGFloat)offestY ;
/// OC -> JS
- (void)wkwebOCtouchJS:(NSString *)javaScript;
/// 返回上一页 并告诉是否还可以返回
- (BOOL)wkwebgoback;
/// 加载数据
- (void)loadRefare;
/// 清理缓存
+ (void)Clear;
@end

NS_ASSUME_NONNULL_END
