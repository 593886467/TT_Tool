//
//  TT_ControlTool.m
//  捕鱼达人
//
//  Created by tengtengdang on 2019/3/26.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "TT_ControlTool.h"
#import "FTT_Helper.h"
@implementation TT_ControlTool

+ (CALayer *)FTT_ControlToolCALayerFrame:(CGRect)Frame
                            AndImageName:(NSString *)ImageName
                      AndBackgtoundColor:(UIColor *)Color
                             BorderColor:(UIColor *)borderColor
                             BorderWidth:(CGFloat)borderWidth
                           masksToBounds:(BOOL)mask
                             corerRadius:(CGFloat)radius {
    CALayer * layer = [CALayer layer];
    layer.frame = Frame;
    if (ImageName) {
        layer.contents = (__bridge id)[UIImage imageNamed:ImageName].CGImage;
    }else {
        layer.backgroundColor = Color.CGColor;
    }
    if (mask) {
        layer.masksToBounds = mask;
        layer.cornerRadius  = radius;
        layer.borderWidth   = borderWidth;
        layer.borderColor   = borderColor.CGColor;
    }
    layer.contentsScale   = [UIScreen mainScreen].scale;
    return layer;
}
/**
 Mode
 NSString * const kCATruncationNone;    // 不剪裁，默认
 NSString * const kCATruncationStart;   // 剪裁开始部分
 NSString * const kCATruncationEnd;     // 剪裁结束部分
 NSString * const kCATruncationMiddle;  // 剪裁中间部分
 */


/**
 alignmentMode
 
 NSString * const kCAAlignmentNatural;   // 自然对齐，默认
 NSString * const kCAAlignmentLeft;      // 左对齐
 NSString * const kCAAlignmentRight;     // 右对齐
 NSString * const kCAAlignmentCenter;    // 居中
 NSString * const kCAAlignmentJustified; // 两端对齐
 */

+ (CATextLayer *)FTT_ControlToolCATextLayerFrame:(CGRect)Frame
                                        AndTitle:(NSString *)title
                                     AndFontSize:(int)Fontsize
                              AndForegroundColor:(UIColor *)Color
                               AndTruncationMode:(NSString *)Mode {
    CATextLayer *textlayer    = [CATextLayer layer];
    textlayer.string          = title;
    textlayer.frame           = Frame;
    textlayer.foregroundColor = Color.CGColor;
    textlayer.fontSize        = Fontsize;
    textlayer.truncationMode  = Mode;
    textlayer.contentsScale   = [UIScreen mainScreen].scale;
    
    return textlayer;
}


+ (UILabel *)FTT_ControlToolUILabelFrame:(CGRect)Frame
                                AndTitle:(NSString *)Title
                             AndFontSize:(int)Fontsize
                           AndTitleColor:(UIColor *)Color
                           Numberoflines:(NSInteger)num
                           TextAlignment:(NSTextAlignment)TextAlignment
                adjustesFontSizesTowidth:(BOOL)sizewidth
                           masksToBounds:(BOOL)mask
                           conrenrRadius:(CGFloat)radius
                  userInteractionEnabled:(BOOL)User
                              LabelBlock:(LabelBlock)back
                              lineIsShow:(BOOL)IS_Show
                               lineFrame:(CGRect)lineFrame {
    UILabel *label                   = [[UILabel alloc]initWithFrame:Frame];
    label.text                       = Title;
    label.font                       = [UIFont systemFontOfSize:Fontsize];
    label.textColor                  = Color;
    label.numberOfLines              = num;
    label.textAlignment              = TextAlignment;
    label.adjustsFontSizeToFitWidth  = sizewidth;
    if (mask) {
        label.layer.masksToBounds    = mask;
        label.layer.cornerRadius     = radius;
    }
    label.userInteractionEnabled = User;
    if (User) {
       
    }
    if (IS_Show) {
        [label.layer addSublayer:[TT_ControlTool FTT_ControlToolCALayerFrame:lineFrame AndImageName:nil AndBackgtoundColor:[UIColor lightGrayColor] BorderColor:nil BorderWidth:0 masksToBounds:NO corerRadius:0]];
    }
    return label;
    
}


+ (TT_Custonbtn *)FTT_ControlToolFTT_CustonbtnFrame:(CGRect)Frame
                                              taeget:(id)target
                                                 sel:(SEL)sel
                                                 tag:(NSInteger)tag
                                AndTitleAndImageType:(UIButtonTitleAndImageType)type
                                           AndImageW:(CGFloat)ImageW
                                              ImageH:(CGFloat)ImageH
                                              TitleW:(CGFloat)titleW
                                              TitleH:(CGFloat)TitleH
                                            AndImage:(UIImage *)Image
                                               title:(NSString *)title
                                          titleColor:(UIColor *)titleColor
                                           BackColor:(UIColor *)BackColor
                                            TextFont:(CGFloat)font
                                         BorderColor:(UIColor *)borderColor
                                         BorderWidth:(CGFloat)borderWidth
                                       masksToBounds:(BOOL)mask
                                         corerRadius:(CGFloat)radius
                                                 pxy:(CGFloat)pxy
                           ContentHorizontalAligment:(UIControlContentHorizontalAlignment)ContentHorizontalAligment {
    
    TT_Custonbtn *btn    = [TT_Custonbtn buttonWithType:UIButtonTypeCustom];
    btn.frame             = Frame;
    btn.PYX               = pxy;
    btn.type              = type;
    if (titleW == -1) {
        btn.TtileW = [FTT_Helper getWidthWithText:title height:TitleH font:font];
    }else {
        btn.TtileW = titleW;
    }
    btn.ImageW            = ImageW;
    btn.ImageH            = ImageH;
    btn.TitleH            = TitleH;
    
    btn.tag               = tag;
    btn.backgroundColor   = BackColor;
    btn.layer.borderWidth = borderWidth;
    btn.layer.borderColor = borderColor.CGColor;
    if (mask) {
        btn.layer.masksToBounds = mask;
        btn.layer.cornerRadius  = radius;
    }
    btn.contentHorizontalAlignment = ContentHorizontalAligment;
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setImage:Image forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (UIButton *)FTT_ControlToolUIButtonFrame:(CGRect)Frame
                                    taeget:(id)target
                                       sel:(SEL)sel
                                       tag:(NSInteger)tag
                                  AntTitle:(NSString *)title
                                 titleFont:(NSInteger)titleFont
                                titleColor:(UIColor *)TilteColor
                                  andImage:(NSString *)image
                              AndBackColor:(UIColor *)Color
                   adjustsFontSizesTowidth:(BOOL)sizeWith
                             masksToBounds:(BOOL)mask
                              conrenRadius:(CGFloat)radius
                               BorderColor:(UIColor *)borderColor
                               BorderWidth:(CGFloat)borderWidth
                 ContentHorizontalAligment:(UIControlContentHorizontalAlignment)ContentHorizontalAligment {
    UIButton *btn                            = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame                                = Frame;
    btn.titleLabel.font                      = [UIFont systemFontOfSize:titleFont];
    btn.layer.borderWidth                    = borderWidth;
    btn.layer.borderColor                    = borderColor.CGColor;
    btn.layer.cornerRadius                   = radius;
    btn.titleLabel.adjustsFontSizeToFitWidth = sizeWith;
    btn.contentHorizontalAlignment           = ContentHorizontalAligment;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:TilteColor forState:UIControlStateNormal];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    if (Color) {
        [btn setBackgroundColor:Color];
    }
    if (mask) {
        btn.layer.masksToBounds = mask;
        btn.layer.cornerRadius  = radius;
    }
    if (image) {
        [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [btn.imageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    if (tag != 0) {
        btn.tag                                  = tag;
    }
    return btn;
}



+ (UIImageView *)FTT_ControlToolUIImageViewFrame:(CGRect)Frame
                                       ImageName:(NSString *)ImageName
                          userInteractionEnabled:(BOOL)Enabled
                                   MasksToBounds:(BOOL)mask
                                   ConrenrRadius:(CGFloat)radius
                                     BorderColor:(UIColor *)borderColor
                                     BorderWidth:(CGFloat)borderwidth
                                      LabelBlock:(LabelBlock)back {
    
    UIImageView *imageView         = [[UIImageView alloc]initWithFrame:Frame];
    imageView.image                = [UIImage imageNamed:ImageName];
    imageView.layer.masksToBounds  = mask;
    imageView.layer.borderColor    = borderColor.CGColor;
    imageView.layer.borderWidth    = borderwidth;
    if (mask) {
        imageView.layer.cornerRadius = radius;
    }
    if (Enabled) {
        
    }
    imageView.userInteractionEnabled = Enabled;
    return imageView;
}



+ (TT_CustonTF *)FTT_ControlToolUITextFieldFrame:(CGRect)Frame
                                      PlaceHolder:(NSString *)placeHolder
                                      andLifImage:(UIImage *)LiftImage
                                    AndRightImage:(UIImage *)RightImage
                                   LiftImageFrame:(CGRect )LiftImageFrame
                                  RightImageFrame:(CGRect )RightImageFrame
                                           AndTag:(NSInteger)tag
                                  AndKeyboardType:(UIKeyboardType)BoardType
                                  clearButtonMode:(UITextFieldViewMode)clearMode
                                 AndReturnKeyType:(UIReturnKeyType)returntype
                                       lineIsShow:(BOOL)IS_Show
                                       lineFrame:(CGRect)lineFrame{
    TT_CustonTF *tf    = [[TT_CustonTF alloc]initWithFrame:Frame];
    tf.placeholder     = placeHolder;
    tf.keyboardType    = BoardType;
    tf.clearButtonMode = clearMode;
    tf.returnKeyType   = returntype;
    tf.tag             = tag;
    
    if (LiftImage) {
        UIImageView *lift = [[UIImageView alloc]initWithImage:LiftImage];
        lift.contentMode  = UIViewContentModeLeft;
        lift.frame        = LiftImageFrame;
        tf.leftView       = lift;
        tf.leftViewMode   = UITextFieldViewModeAlways;
    }
    if (RightImage) {
        UIImageView *right = [[UIImageView alloc]initWithImage:RightImage];
        right.contentMode  = UIViewContentModeRight;
        right.frame        = RightImageFrame;
        tf.rightView       = right;
        tf.rightViewMode   = UITextFieldViewModeAlways;
    }
    if (IS_Show) {
        [tf.layer addSublayer:[TT_ControlTool FTT_ControlToolCALayerFrame:lineFrame AndImageName:nil AndBackgtoundColor:[UIColor lightGrayColor] BorderColor:nil BorderWidth:0 masksToBounds:NO corerRadius:0]];
    }
    return tf;
}

+ (TT_CustonTF *)TT_ControlToolTextFieldFrame:(CGRect)Frame
                                  PlaceHolder:(NSString *)placeHolder
                                  andLifImage:(UIView *)LiftIV
                                AndRightImage:(UIView *)RightV
                               LiftImageFrame:(CGRect )LiftVFrame
                              RightImageFrame:(CGRect )RighVFrame
                                       AndTag:(NSInteger)tag
                              AndKeyboardType:(UIKeyboardType)BoardType
                              clearButtonMode:(UITextFieldViewMode)clearMode
                             AndReturnKeyType:(UIReturnKeyType)returntype
                                   lineIsShow:(BOOL)IS_Show
                                    lineFrame:(CGRect)lineFrame {
    TT_CustonTF *tf    = [[TT_CustonTF alloc]initWithFrame:Frame];
    tf.placeholder     = placeHolder;
    tf.keyboardType    = BoardType;
    tf.clearButtonMode = clearMode;
    tf.returnKeyType   = returntype;
    tf.tag             = tag;
    if (LiftIV) {
        tf.leftView       = LiftIV;
        tf.leftViewMode   = UITextFieldViewModeAlways;
    }
    if (RightV) {
        tf.rightView       = RightV;
        tf.rightViewMode   = UITextFieldViewModeAlways;
    }
    if (IS_Show) {
        [tf.layer addSublayer:[TT_ControlTool FTT_ControlToolCALayerFrame:lineFrame AndImageName:nil AndBackgtoundColor:[UIColor lightGrayColor] BorderColor:nil BorderWidth:0 masksToBounds:NO corerRadius:0]];
    }
    return tf;
    
}


+ (UIView *)FTT_ControlToolUIViewFrame:(CGRect)Frame
                       BackgroundColor:(UIColor *)Backgroundcolor
                         MasksToBounds:(boolean_t)mask
                         ConrenrRadius:(CGFloat)radius{
    UIView *view = [[UIView alloc]initWithFrame:Frame];
    view.backgroundColor = Backgroundcolor;
    if (mask) {
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius  = radius;
    }
    return view;
}


@end
