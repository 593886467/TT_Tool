//
//  TT_ControlTool.h
//  捕鱼达人
//
//  Created by tengtengdang on 2019/3/26.
//  Copyright © 2019 FTT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TT_Custonbtn.h"
#import "TT_CustonTF.h"
typedef void(^LabelBlock)(void);
//NS_ASSUME_NONNULL_BEGIN

@interface TT_ControlTool : NSObject

/**
 创建CALayer
 
 @param Frame       frame
 @param ImageName   图片名字
 @param Color       背景颜色
 @param borderColor 边颜色
 @param borderWidth 边宽
 @param mask        是否剪切
 @param radius      圆角
 @return            CALayer
 */
+ (CALayer *)FTT_ControlToolCALayerFrame:(CGRect)Frame
                            AndImageName:(NSString *)ImageName
                      AndBackgtoundColor:(UIColor *)Color
                             BorderColor:(UIColor *)borderColor
                             BorderWidth:(CGFloat)borderWidth
                           masksToBounds:(BOOL)mask
                             corerRadius:(CGFloat)radius;

/**
 创建CATextLayer
 
 @param Frame    frame
 @param title    文字
 @param Fontsize 字体大小
 @param Color    字体颜色
 @param Mode     字体缩减格式
 @return         CATextLayer
 */
+ (CATextLayer *)FTT_ControlToolCATextLayerFrame:(CGRect)Frame
                                        AndTitle:(NSString *)title
                                     AndFontSize:(int)Fontsize
                              AndForegroundColor:(UIColor *)Color
                               AndTruncationMode:(NSString *)Mode ;

/**
 创建LAbel
 
 @param Frame     frame
 @param Title     文字
 @param Fontsize  字体大小
 @param Color     字体颜色
 @param num       行数
 @param sizewidth 适应自宽
 @param mask      剪切
 @param radius    圆角
 @param User      是否触发事件
 @param back      触发事件回调
 @param IS_Show   是否显示细线
 @return          UILabel
 */

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
                               lineFrame:(CGRect)lineFrame;


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
                 ContentHorizontalAligment:(UIControlContentHorizontalAlignment)ContentHorizontalAligment;



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
                           ContentHorizontalAligment:(UIControlContentHorizontalAlignment)ContentHorizontalAligment;


/**
 创建ImageView
 
 @param Frame       frame
 @param ImageName   图片
 @param Enabled     触发事件
 @param mask        剪切
 @param radius      圆角
 @param borderColor 边颜色
 @param borderwidth 边宽
 @param back        触发回调
 @return            UIImageView
 */
+ (UIImageView *)FTT_ControlToolUIImageViewFrame:(CGRect)Frame
                                       ImageName:(NSString *)ImageName
                          userInteractionEnabled:(BOOL)Enabled
                                   MasksToBounds:(BOOL)mask
                                   ConrenrRadius:(CGFloat)radius
                                     BorderColor:(UIColor *)borderColor
                                     BorderWidth:(CGFloat)borderwidth
                                      LabelBlock:(LabelBlock)back;

/**
 创建TF
 
 @param Frame            frame
 @param placeHolder      占位符
 @param LiftImage        左边图片
 @param RightImage       右边图片
 @param LiftImageFrame   左边图片大小
 @param RightImageFrame  右边图片大小
 @param tag              标示
 @param BoardType        键盘类型
 @param clearMode        清除键状态
 @param returntype       确定按钮风格
 @param IS_Show          是否展示下划线
 @return                 TF
 */
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
                                       lineFrame:(CGRect)lineFrame;

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
                                    lineFrame:(CGRect)lineFrame;

/**
 创建UIView
 
 @param Frame frame
 @param Backgroundcolor 背景颜色
 @param mask 是否剪切
 @Param radius 切圆角
 @return UIview
 */
+ (UIView *)FTT_ControlToolUIViewFrame:(CGRect)Frame
                       BackgroundColor:(UIColor *)Backgroundcolor
                         MasksToBounds:(boolean_t)mask
                         ConrenrRadius:(CGFloat)radius;
@end

//NS_ASSUME_NONNULL_END
