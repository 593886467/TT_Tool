//
//  FTT_BombBox.m
//  95128
//
//  Created by 樊腾 on 17/6/24.
//  Copyright © 2017年 FTT. All rights reserved.
//

#import "FTT_BombBox.h"
#import "FTT_ButtonModule.h"
#import "TT_DarkmodeTool.h"

#define BGW 275

@interface FTT_BombBox ()<FTT_ButtonModuleDelegate>

/**
 提示语
 */
@property (nonatomic , strong) UILabel *MessageLabel;

@property (nonatomic , strong) UIView *BG;

@property (nonatomic , strong) FTT_ButtonModule *module;


@end


@implementation FTT_BombBox

- (void)FrameWithTilteMessage:(NSString *)Message CancerMessage:(NSString *)CancerMessage SureMessage:(NSString *)SureMessage andType:(FTT_ButtonModuleType)type {
    [self FrameWithTilteMessage:Message CancerMessage:CancerMessage SureMessage:SureMessage andType:type iskeywindow:YES];
}
/*
 计算

 @param Message 提示
 @param CancerMessage 取消
 @param SureMessage 确定
 */
- (void)FrameWithTilteMessage:(NSString *)Message CancerMessage:(NSString *)CancerMessage SureMessage:(NSString *)SureMessage andType:(FTT_ButtonModuleType)type iskeywindow:(BOOL)iskeywindow{
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    if (iskeywindow) {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.55];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }

    CGFloat MessageHight;
    CGSize MessageSize =  [self contentSizeOfString:Message maxWidth:BGW -30 font:[UIFont systemFontOfSize:16]];
    MessageHight = MessageSize.height;
    
    self.MessageLabel.frame = CGRectMake(15,20, BGW  - 30 , MessageHight);
    self.module.frame = CGRectMake(0, CGRectGetMaxY(self.MessageLabel.frame) + 20 , BGW, 40);
    [self.module CreateCancerMessage:CancerMessage SureMessage:SureMessage andType:type];
    self.BG.frame = CGRectMake(0 , 0, BGW, MessageHight + 80);
    self.MessageLabel.text = Message;
    
    [self.BG addSubview:self.MessageLabel];
    [self.BG addSubview:self.module];
    [self addSubview:self.BG];
    self.BG.center = self.center;
   
 
}


- (CGSize)contentSizeOfString:(NSString*)content maxWidth:(CGFloat)width font:(UIFont*)font {
    if (content.length == 0) {
        return CGSizeZero ;
    }
    CGRect  rect = [content  boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size ;
}

- (void)FTT_ButtonModuleSelectBtn:(NSInteger)tag {
    if (self.FTT_BoxDelegate && [self.FTT_BoxDelegate respondsToSelector:@selector(FTT_BombBoxSelectBtn:)]) {
        [self.FTT_BoxDelegate FTT_BombBoxSelectBtn:tag];
    }
   [self removeFromSuperview];
}


/**
 懒加载

 @return 信息
 */
- (UILabel *)MessageLabel {
    if (!_MessageLabel) {
        _MessageLabel = [[UILabel alloc]init];
        _MessageLabel.textColor = [TT_DarkmodeTool TT_norma333];
        _MessageLabel.font = [UIFont systemFontOfSize:16];
        _MessageLabel.textAlignment = NSTextAlignmentCenter;
        _MessageLabel.numberOfLines = 0;
    }
    return _MessageLabel;
}

- (UIView *)BG {
    if (!_BG) {
        _BG = [[UIView alloc]init];
        _BG.layer.masksToBounds = YES;
        _BG.layer.cornerRadius = 4;
        _BG.backgroundColor = [TT_DarkmodeTool TT_NormalWhite];
    }
    return _BG;
}

- (FTT_ButtonModule *)module {
    if (!_module) {
        _module = [[FTT_ButtonModule alloc]init];
        _module.delegate = self;
    }
    return _module;
}


@end
