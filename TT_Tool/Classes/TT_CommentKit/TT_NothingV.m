//
//  TT_NothingV.m
//  捕鱼达人
//
//  Created by tengtengdang on 2019/4/15.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "TT_NothingV.h"
#import "TT_GeneralProfile.h"
#import "TT_DarkmodeTool.h"
#import "TT_ControlTool.h"
#import "UIColor+Categpry.h"
@interface TT_NothingV ()

@end

@implementation TT_NothingV




#pragma mark 生命周期

#pragma mark 回调协议

#pragma mark 触发方法

- (void)Tap {
    [self endEditing:YES];
    if (self.ViewtapClose) {
        self.ViewtapClose(0, self.textLayer.string);
    }
    [self removeFromSuperview];
}

#pragma mark 公开方法

- (void)tt_setupViews {
    self.backgroundColor = [TT_DarkmodeTool TT_NormalWhite];
    [self addSubview:self.ImageLayer];
    [self.layer addSublayer:self.textLayer];
    [self tt_setupViewsFrame];
}

- (void)tt_setupViewsFrame {
    self.ImageLayer.frame = CGRectMake(0 ,0, 100,92);
    self.ImageLayer.center = self.center;
    self.textLayer.frame  = CGRectMake(0, CGRectGetMaxY(self.ImageLayer.frame) + 20, self.V_screnW, 30);
}



- (void)configImageName:(NSString *)ImaageName titleName:(NSString *)titleName is_Tap:(BOOL)is_Tap{
    if (ImaageName) {
         self.ImageLayer.image = [UIImage imageNamed:ImaageName];
    }
    if (titleName) {
       self.textLayer.string    = titleName;
    }
    self.is_tap = is_Tap;
}
#pragma mark 私有方法

#pragma mark 存取方法


- (void)setIs_tap:(BOOL)is_tap {
    _is_tap = is_tap;
    if (is_tap) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tap)];
        [self addGestureRecognizer:tap];
    }
}

- (UIImageView *)ImageLayer {
    if (!_ImageLayer) {
        _ImageLayer = [TT_ControlTool FTT_ControlToolUIImageViewFrame:CGRectZero
                                                            ImageName:@"k"
                                               userInteractionEnabled:NO
                                                        MasksToBounds:NO
                                                        ConrenrRadius:0
                                                          BorderColor:nil
                                                          BorderWidth:0
                                                           LabelBlock:nil];
        
    }
    return _ImageLayer;
    
}


- (CATextLayer *)textLayer {
    if (!_textLayer) {
        _textLayer = [TT_ControlTool FTT_ControlToolCATextLayerFrame:CGRectZero
                                                            AndTitle:@""
                                                         AndFontSize:18
                                                  AndForegroundColor:[UIColor getColor:@"#999999"]
                                                   AndTruncationMode:kCATruncationEnd];
        _textLayer.alignmentMode = kCAAlignmentCenter;
    }
    return _textLayer;
}



@end
