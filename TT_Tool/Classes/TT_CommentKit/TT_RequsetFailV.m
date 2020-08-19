//
//  TT_RequsetFailV.m
//  XXX
//
//  Created by 樊腾 on 2019/11/14.
//  Copyright © 2019 绑耀. All rights reserved.
//

#import "TT_RequsetFailV.h"
#import "TT_GeneralProfile.h"
#import "TT_ControlTool.h"
#import "TT_CommentCat.h"
#import "SYBJ_ColorS.h"
@interface TT_RequsetFailV ()


@end

@implementation TT_RequsetFailV


#pragma mark 生命周期

#pragma mark 回调协议

#pragma mark 触发方法

/// 点击刷新按钮
- (void)taprefmethod {
    if (self.ViewtapClose) {
        self.ViewtapClose(0, @"");
    }
}
#pragma mark 公开方法


- (void)configheaderimgstr:(NSString *)imgstr titleStr:(NSString *)titleStr refstr:(NSString *)refstr {
    [self configheaderimgstr:imgstr imageSize:CGSizeMake(214, 170) titleStr:titleStr refstr:refstr];
}

- (void)configheaderimgstr:(NSString *)imgstr imageSize:(CGSize)imagesize titleStr:(NSString *)titleStr refstr:(NSString *)refstr {
    [self.refbtn setTitle:refstr forState:UIControlStateNormal];
    [self tt_setupViewsFrame:imagesize];
}

#pragma mark 私有方法

- (void)tt_setupViews {
    [self addSubview:self.headerimg];
    [self addSubview:self.titlelabel];
    [self addSubview:self.refbtn];
    [self configheaderimgstr:nil titleStr:nil refstr:@"刷新重试"];
}

- (void)tt_setupViewsFrame:(CGSize)imagesize {
    self.headerimg.frame = CGRectMake((self.frame.size.width - imagesize.width) / 2, (self.frame.size.height - (110 + imagesize.height) - 150) / 2 , imagesize.width, imagesize.height);
    self.titlelabel.frame = CGRectMake(0, CGRectGetMaxY(self.headerimg.frame) + 30, self.frame.size.width, 20);
    self.refbtn.frame = CGRectMake((self.frame.size.width - 130) / 2, CGRectGetMaxY(self.titlelabel.frame) + 20, 130, 36);
}

#pragma mark 存取方法

- (UIImageView *)headerimg {
    if (!_headerimg) {
        _headerimg = [TT_ControlTool FTT_ControlToolUIImageViewFrame:CGRectZero
                                                           ImageName:@"jiazaishibai"
                                              userInteractionEnabled:NO
                                                       MasksToBounds:NO
                                                       ConrenrRadius:0
                                                         BorderColor:nil
                                                         BorderWidth:0
                                                          LabelBlock:nil];
    }
    return _headerimg;
}

- (UILabel *)titlelabel {
    if (!_titlelabel) {
        _titlelabel = [TT_ControlTool FTT_ControlToolUILabelFrame:CGRectZero
                                                         AndTitle:@"网络去度假了，刷新试试~"
                                                      AndFontSize:19
                                                    AndTitleColor:[UIColor getColor:@"#999999"]
                                                    Numberoflines:0
                                                    TextAlignment:NSTextAlignmentCenter
                                         adjustesFontSizesTowidth:NO
                                                    masksToBounds:NO
                                                    conrenrRadius:0
                                           userInteractionEnabled:NO
                                                       LabelBlock:nil
                                                       lineIsShow:NO
                                                        lineFrame:CGRectZero];
    }
    return _titlelabel;
}


- (UIButton *)refbtn {
    if (!_refbtn) {
        _refbtn = [TT_ControlTool FTT_ControlToolUIButtonFrame:CGRectZero
                                                        taeget:self
                                                           sel:@selector(taprefmethod)
                                                           tag:0
                                                      AntTitle:@"刷新重试"
                                                     titleFont:16
                                                    titleColor:[UIColor whiteColor]
                                                      andImage:nil
                                                  AndBackColor:nil
                                       adjustsFontSizesTowidth:NO
                                                 masksToBounds:YES
                                                  conrenRadius:18
                                                   BorderColor:nil
                                                   BorderWidth:0
                                     ContentHorizontalAligment:0];
        
        
    }
    return _refbtn;
}
@end
