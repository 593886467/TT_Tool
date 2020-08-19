//
//  TT_BaseV.m
//  tengteng
//
//  Created by tengtengdang on 2019/3/19.
//  Copyright © 2019 腾腾. All rights reserved.
//

#import "TT_BaseV.h" 

@implementation TT_BaseV



#pragma mark 生命周期



- (instancetype)init {
    self = [super init];
    if (self) {
        [self tt_setupViews];
        [self tt_configDefault];
        [self tt_configClose];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self tt_setupViews];
        [self tt_configDefault];
        [self tt_configClose];
    }
    return self;
}


#pragma mark 触发方法



#pragma mark 公开方法

- (void)tt_configDefault {
    
}

/// 添加视图
- (void)tt_setupViews{
    
}

/// 设置Frams
- (void)tt_setupViewsFrame{
    
}

/// 绑定V 与 VM
- (void)tt_bindViewModel {
    
}

- (void)tt_updateSubviewFramses {
    
}

/// 子控件回调
- (void)tt_configClose{
    
}

/// 赋值
- (void)tt_confignewdata:(id)data {
    
}

/// 回调通用方法
- (void)generaltriggermethodType:(NSInteger)type data:(id)data{
   
    
    if (self.basedelegate && [self.basedelegate respondsToSelector:@selector(tengteng_configtaptype:data:)]) {
        [self.basedelegate tengteng_configtaptype:type data:data];
    }
    
    if (self.ViewtapClose) {
        self.ViewtapClose(type, data);
    }
}

#pragma mark 私有方法

#pragma mark 存取方法

- (void)setView_generalData:(id)view_generalData {
    _view_generalData = view_generalData;
    [self tt_bindViewModel];
}

- (CGFloat)V_screnW {
    return self.bounds.size.width;
}

- (CGFloat)V_screnH {
    return self.bounds.size.height;
}


@end
