//
//  TT_BaseC.m
//  tengteng
//
//  Created by tengtengdang on 2019/3/19.
//  Copyright © 2019 腾腾. All rights reserved.
//

#import "TT_BaseC.h"
@interface TT_BaseC ()


@end

@implementation TT_BaseC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tt_layoutNavigation];
    [self tt_addSubviews];
    [self tt_bindViewModel];
    [self tt_changeDefauleConfiguration];
    [self configureViewFromLocalisation];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 生命周期

#pragma mark 回调协议

#pragma mark 界面跳转

- (void)JumpController:(UIViewController *)Contrl {
    [self.navigationController pushViewController:Contrl animated:YES];
}


#pragma mark 触发方法
-(void)configureViewFromLocalisation
{
    
}

#pragma mark 公开方法

/// 绑定 V（VC）与VM
- (void)tt_bindViewModel {
    [self setupVM:[TT_BaseVM class]];
}

/// 添加控件
- (void)tt_addSubviews {
    
}

/// 初次获取数据
- (void)tt_getNewDate {
    
}

/// 回调
- (void)tt_allClose {
    
}

- (void)tt_addNoti {
    
}

- (void)tt_addnavgarItme {
    
}

- (void)tt_changeDefauleConfiguration {
    
}



- (void)tt_deletNoti {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

/// 设置navation
- (void)tt_layoutNavigation {
    if (iOS11_1Later) {
        [UITableView appearance].estimatedRowHeight = 0;
        [UITableView appearance].estimatedSectionHeaderHeight = 0;
        [UITableView appearance].estimatedSectionFooterHeight = 0;
        if (@available(iOS 11.0, *)) {
            [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }else {
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
 
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
        [self CreateBack];
    }
}


/// 点击空数据界面出发方法
- (void)TapNothingTriggermethod:(NSString *)Str {
    [self configData];
}

// 右滑返回事件
- (void)tengteng_configdidMoveToParentV {
    
}


/// 配置键盘消失
- (void)tengteng_configkeyboardendEditing {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}



#pragma mark 私有方法
- (void)CreateBack {
    UIBarButtonItem *imageItem = [[UIBarButtonItem alloc]initWithCustomView:self.tt_custonBack];
    if (!self.is_hideback) {
        self.navigationItem.leftBarButtonItem = imageItem ;
    }
}

/** 返回按钮触发事件 */
- (void)BackBarButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didMoveToParentViewController:(UIViewController*)parent{
    [super didMoveToParentViewController:parent];
    NSLog(@"%s,%@",__FUNCTION__,parent);
    if(!parent){
        [self tengteng_configdidMoveToParentV];
        NSLog(@"离开页面");
    }
}

#pragma mark 存取方法

- (UIButton *)tt_custonBack {
    if (!_tt_custonBack) {
        _tt_custonBack = [UIButton buttonWithType:UIButtonTypeCustom];
        _tt_custonBack.frame = CGRectMake(0, 0, 30, 40);
        [_tt_custonBack addTarget:self action:@selector(BackBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_tt_custonBack setImage:[UIImage imageNamed:DefaultBackIMG] forState:UIControlStateNormal];
        _tt_custonBack.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    }
    return _tt_custonBack;
}

@end
