//
//  FTT_ButtonModule.m
//  95128
//
//  Created by 樊腾 on 17/6/24.
//  Copyright © 2017年 FTT. All rights reserved.
//

#import "FTT_ButtonModule.h"
#import "TT_DarkmodeTool.h"
#import "TT_ControlTool.h"
@interface FTT_ButtonModule ()



@end

@implementation FTT_ButtonModule




/**
 界面搭建

 @param CancerMessage 取消
 @param Message 确定
 @param type 类型
 */
- (void)CreateCancerMessage:(NSString *)CancerMessage SureMessage:(NSString *)Message andType:(FTT_ButtonModuleType)type{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width, 0.5)];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width / 2 - 0.25, CGRectGetMaxY(view.frame), 0.5, self.frame.size.height - 0.5)];
    view.backgroundColor = [TT_DarkmodeTool TT_normaEEE];
    line.backgroundColor = [TT_DarkmodeTool TT_normaEEE];
    [self.CancerBtn setTitleColor:[TT_DarkmodeTool TT_noraml666] forState:UIControlStateNormal];
    [self.SureBtn   setTitleColor:[TT_DarkmodeTool TT_Normal2F2] forState:UIControlStateNormal];
    if (type == FTT_ButtonModuleTypeCancer) {
        [self addSubview:view];
        self.CancerBtn.frame = CGRectMake(0, CGRectGetMaxY(view.frame), self.frame.size.width, self.frame.size.height - 0.5);
        [self addSubview:self.CancerBtn];
    }else {
        [self addSubview:view];
        [self addSubview:line];
        self.CancerBtn.frame = CGRectMake(0, CGRectGetMaxY(view.frame) , self.frame.size.width / 2 - 0.5, self.frame.size.height - 0.5);
        self.SureBtn.frame = CGRectMake(CGRectGetMaxX(line.frame), CGRectGetMaxY(view.frame), self.CancerBtn.frame.size.width, self.CancerBtn.frame.size.height);
        [self addSubview:self.CancerBtn];
        [self addSubview:self.SureBtn];
    }
    [self.CancerBtn setTitle:CancerMessage forState:UIControlStateNormal];
    [self.SureBtn setTitle:Message forState:UIControlStateNormal];
}

/**
 按钮触发

 @param btn btn
 */
- (void)Btn:(UIButton *)btn {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(FTT_ButtonModuleSelectBtn:)]) {
        [self.delegate FTT_ButtonModuleSelectBtn:btn.tag];
    }
}

/**
 懒加载

 @return 取消
 */
- (UIButton *)CancerBtn {
    if (!_CancerBtn) {
        _CancerBtn = [TT_ControlTool FTT_ControlToolUIButtonFrame:CGRectZero
                                                           taeget:self
                                                              sel:@selector(Btn:)
                                                              tag:998
                                                         AntTitle:@""
                                                        titleFont:14
                                                       titleColor:[TT_DarkmodeTool TT_norma999]
                                                         andImage:nil
                                                     AndBackColor:nil
                                          adjustsFontSizesTowidth:NO
                                                    masksToBounds:NO
                                                     conrenRadius:0
                                                      BorderColor:nil
                                                      BorderWidth:0
                                        ContentHorizontalAligment:0];
    }
    return _CancerBtn;
}

/**
 懒加载

 @return 确定
 */
- (UIButton *)SureBtn {
    if (!_SureBtn) {
        _SureBtn = [TT_ControlTool FTT_ControlToolUIButtonFrame:CGRectMake(0, 0, 0, 0)
                                                         taeget:self
                                                            sel:@selector(Btn:)
                                                            tag:999
                                                       AntTitle:@""
                                                      titleFont:14
                                                     titleColor:[TT_DarkmodeTool TT_norma999]
                                                       andImage:nil
                                                   AndBackColor:nil
                                        adjustsFontSizesTowidth:NO
                                                  masksToBounds:NO
                                                   conrenRadius:0
                                                    BorderColor:nil
                                                    BorderWidth:0
                                      ContentHorizontalAligment:0];
    }
    return _SureBtn;
}

@end
