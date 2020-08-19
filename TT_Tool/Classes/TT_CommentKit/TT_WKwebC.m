//
//  TT_WKwebC.m
//  TT_Wkweb
//
//  Created by tengtengdang on 2018/12/21.
//  Copyright © 2018 FTT. All rights reserved.
//

#import "TT_WKwebC.h"
@interface TT_WKwebC ()

@property (nonatomic , assign) BOOL isSetUserAgent;
@end

@implementation TT_WKwebC


#pragma mark 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    IPhoneXHeigh
 
    [self initconfig];
    [self initSubViewS];
    [self initnavgationItemS];
    [self changeDefaultConfiguration];
    [self configWKwebC_allClose];
}



- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    // 解决返回后语音一直播放的问题
    [self pausePlay];
}
 
/// 暂停播放网页内的音频、视频
- (void)pausePlay {
    [self.Web.wkweb evaluateJavaScript:@"pauseVideo()" completionHandler:nil];
    [self.Web.wkweb evaluateJavaScript:@"pauseAudio()" completionHandler:nil];
}


#pragma mark 回调协议


/// 加载状态
- (void)TT_WkwebrequeStatus:(TT_WKwebRequestStatus)Status {
    if (Status == TT_WKwebRequestStatusFinish) {
        self.navigationItem.title = self.Web.wkweb_title;
    }
}

/// JS -> OC
- (void)TT_WKwebJScallOCdidReceiveScriptMessage:(WKScriptMessage *)message {
    [self configJSinvokeOCinfo:message];
}

/// 截取URL
- (void)TT_WkwebdecidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(nonnull void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString *url = navigationAction.request.URL.absoluteString;

  if ([url containsString:@"weixin://"]|| [url containsString:@"alipay://"] || [url containsString:@"alipayqr://"] || [url containsString:@"alipays://"]){
        [[UIApplication sharedApplication]openURL:navigationAction.request.URL options:@{} completionHandler:^(BOOL success) {
        
        }];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    [self configPolicyForNavigationAction:navigationAction decisionHandler:decisionHandler];
}

/// 滑动
- (void)TT_WkwebDidScroll:(UIScrollView *)ScrollView UporDown:(BOOL)YorN {
    
}

/// 手动 滑动
- (void)TT_WkwebscrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

#pragma mark 触发方法

- (void)shuaxin {
    [self.Web.wkweb reload];
}


- (void)guanbi {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 公开方法


- (void)initconfig {
    self.view.backgroundColor = [TT_DarkmodeTool TT_NormalWhite];
}

/// 添加视图
- (void)initSubViewS {
    [self.view addSubview:self.Web];
}

/// 添加导航栏按钮
- (void)initnavgationItemS {
    UIButton *shuaxin = [TT_ControlTool FTT_ControlToolUIButtonFrame:CGRectMake(0, 0, 40, 40) taeget:self
                                                             sel:@selector(shuaxin)
                                                             tag:0
                                                        AntTitle:nil
                                                       titleFont:0
                                                      titleColor:nil
                                                        andImage:@"BuyCar_Reload"
                                                    AndBackColor:nil
                                         adjustsFontSizesTowidth:NO
                                                   masksToBounds:NO
                                                    conrenRadius:0
                                                     BorderColor:nil
                                                     BorderWidth:0
                                       ContentHorizontalAligment:0];
    [shuaxin setImage:[[UIImage imageNamed:@"BuyCar_Reload"] imageWithColor:[TT_DarkmodeTool TT_norma333]] forState:UIControlStateNormal];
    UIBarButtonItem *imageItem = [[UIBarButtonItem alloc]initWithCustomView:shuaxin];
    self.navigationItem.rightBarButtonItem = imageItem ;
    
    
    self.tt_custonBack.frame = CGRectMake(0, 0, 30, 40);
    UIBarButtonItem *imageItem2 = [[UIBarButtonItem alloc]initWithCustomView:self.tt_custonBack];
    
    
    UIButton *guanbi = [TT_ControlTool FTT_ControlToolUIButtonFrame:CGRectMake(0, 0, 30, 40) taeget:self
                                                                 sel:@selector(guanbi)
                                                                tag:0
                                                           AntTitle:nil
                                                          titleFont:0
                                                         titleColor:nil
                                                           andImage:@"close"
                                                       AndBackColor:nil
                                            adjustsFontSizesTowidth:NO
                                                      masksToBounds:NO
                                                       conrenRadius:0
                                                        BorderColor:nil
                                                        BorderWidth:0
                                          ContentHorizontalAligment:0];
    guanbi.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [guanbi setImage:[[UIImage imageNamed:@"close"] imageWithColor:[TT_DarkmodeTool TT_norma333]] forState:UIControlStateNormal];
    UIBarButtonItem *leftNegativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftNegativeSpacer.width = -15;
    UIBarButtonItem *imageItem1 = [[UIBarButtonItem alloc]initWithCustomView:guanbi];
    self.navigationItem.leftBarButtonItems = @[imageItem2,leftNegativeSpacer, imageItem1] ;
}

/// 修改默认属性
- (void)changeDefaultConfiguration {
    
}

/// 配置回调
- (void)configWKwebC_allClose {
    
}

/// WK 刷新
- (void)configWKweb_reload {
    [self.Web.wkweb reload];
}

/// H5 返回上一个界面
- (void)configWKweb_goBack {
    if (![self.Web wkwebgoback]) {
        [self.navigationController popViewControllerAnimated:NO];
    }else {
        [self.Web.wkweb goBack];
    }
}

/// 加载网络请求
- (void)configloadRequestWKweb_Url:(NSString *)WKweb_Url WKweb_data:(NSString *)WKweb_data WKweb_requesStatus:(TT_WKwebType)WKweb_requesStatus {
    [self.Web loadRequest:WKweb_Url data:WKweb_data requestStatus:WKweb_requesStatus];
}
    
- (void)configcheyoubangWKweb_Url:(NSString *)WKweb_Url WKweb_data:(NSString *)WKweb_data WKweb_requesStatus:(TT_WKwebType)WKweb_requesStatus {
    [self.Web loadRequest:WKweb_Url data:WKweb_data requestStatus:WKweb_requesStatus];
}

/// 设置自定义控件的显示隐藏
- (void)configPublicmenthodcontrolisHide:(BOOL)Ishide {
    
}

/// 获取图片信息
- (void)configPolicyForNavigationAction:(WKNavigationAction *)NavigationAction decisionHandler:(nonnull void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow);
}

/// JS -> OC
- (void)configJSinvokeOCinfo:(WKScriptMessage *)info {
}

/// OC -> JS
- (void)configwkwebOCtouchJS:(NSString *)javaScript {
    [self.Web wkwebOCtouchJS:javaScript];
}

- (void)BackBarButtonPressed:(id)sender{
    [self configWKweb_goBack];
}


#pragma mark 私有方法




#pragma mark 存取方法


- (void)setWeb_configName:(NSString *)Web_configName {
    _Web_configName = Web_configName;
    self.Web.configName = Web_configName;
}



- (TT_WKweb *)Web {
    if (!_Web) {
        IPhoneXHeigh
        _Web = [[TT_WKweb alloc]initWithFrame:self.Web_frame];
        _Web.TT_WKDelegate = self;
        _Web.is_firstSlide = YES;
    }
    return _Web;
}

@end
