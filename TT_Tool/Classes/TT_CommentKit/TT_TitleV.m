//
//  PZ_TitleV.m
//  tengteng
//
//  Created by 腾腾 on 2018/1/24.
//  Copyright © 2018年 腾腾. All rights reserved.
//

#import "TT_TitleV.h"
#import "TT_ControlTool.h"
@interface TT_TitleV ()

@property (nonatomic , strong) UILabel *titleLable;

@end


@implementation TT_TitleV

#pragma mark ---- 生命周期

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self CreateUI];
    }
    return self;
}

#pragma mark ---- 回调协议


#pragma mark ---- 公开方法

#pragma mark ---- 私有方法


/**
 功能
 */
- (void)CreateUI {
    [self addSubview:self.titleLable];
    [self addSubview:self.ImageLayer];
}



/**
 点击按钮
 */
- (void)Btn {
    if (self.SearchClick) {
        self.SearchClick();
    }
}


#pragma mark ---- 存取方法


- (void)setTitle:(NSString *)title {
    self.titleLable.text = title;
}

- (void)setImageName:(NSString *)ImageName {
    [self.ImageLayer setImage:[UIImage imageNamed:ImageName] forState:UIControlStateNormal];
}

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, [UIScreen mainScreen].bounds.size.width - 80, 52)];
        _titleLable.textColor = [UIColor blackColor];
        _titleLable.font = [UIFont boldSystemFontOfSize:30];
    }
    return _titleLable;
}

- (UIButton *)ImageLayer {
    if (!_ImageLayer) {
        _ImageLayer = [UIButton buttonWithType:UIButtonTypeCustom];
        _ImageLayer.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 6, 40, 40);
        [_ImageLayer addTarget:self action:@selector(Btn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ImageLayer;
}

@end
