//
//  FTT_Helper.h
//  测试
//
//  Created by 樊腾 on 16/11/28.
//  Copyright © 2016年 FTT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#ifdef DEBUG

#define FNSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define FNSLog(...)
#endif



typedef NS_ENUM(NSInteger , FTT_HelperDateStringType) {
    FTT_HelperDateStringTypeHHss = 0,// HH:ss yyyy:MM:dd
    FTT_HelperDateStringTypeyyyyMM ,// yyyy:MM:dd HH:ss
    FTT_HelperDateStringTypeYYMM   // yyyy.mm.dd HH:SS
    
};

typedef void (^NoAction)(void);
typedef void (^SureAction)(void);
typedef void (^ClearSuccess)(void);

@interface FTT_Helper : NSObject

/**
 时间字符串的转换

 @param inputString 输入的时间字符串
 @param type        想要得到的字符串格式
 @param is_yyyy     是否年是2016 格式 还是 16格式

 @return            返回想要的时间格式
 */
+ (NSString *)converDataString:(NSString *)inputString FTT_HelperDateStringType:(FTT_HelperDateStringType)type is_yyyy:(BOOL)is_yyyy;

/**
 预约时间转换

 @param time 后天返回时间
 @return 返回时间
 */
+ (NSString *)LoadTimeAndNowTime:(NSString *)time ;
//+ (NSString *)stringWithTimelineDate:(NSDate *)date;
/**
 把字符串转换成NSDate

 @param string 时间字符串

 @return NSDate
 */
+ (NSDate*)dateFromString:(NSString*)string;
+ (NSDate *)dateFromString:(NSString *)string dateFormat:(NSString *)dateFormat;
/**
 计算指定时间与现在时间的时间差

 @param timer 指定的时间

 @return 返回距离的时间差
 */
+ (NSString *)TimeDifference:(NSString *)timer ;


+ (BOOL)TimeDfiffer:(NSString *)timer;

/**
 当前时间转换成字符串
 
 @param formate 转换的格式 例如@ "YYMMddhhmmss"
 
 @return 返回转换后的时间
 */


+ (NSString*)loadNewTime:(NSString *)formate ;


/**
 根据字体的内容，最大宽度，字体大小来计算文字的高度

 @param content  需要计算的字符串
 @param width   最大的宽度
 @param font    字体的大小

 @return 返回字符串的高度
 */
+ (CGSize)contentSizeOfString:(NSString*)content maxWidth:(CGFloat)width font:(UIFont*)font ;

//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
+ (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font;


/**
 根据输入的图片的宽高，计算图片缩放后的大小

 @param inputImgWith    输入的图片的宽度
 @param inputImgHeight  输入的图片的高度
 @param width           默认的图片的宽度

 @return 返回图片的宽高
 */
+ (CGSize)imageSize:(NSString *)inputImgWith height:(NSString *)inputImgHeight restictWidth:(CGFloat)width ;


/**
 时间戳 转换为时间

 @param timestamp 时间戳
 @param format （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
 @return 时间
 */
+ (NSString *)timestampSwitchTime:(NSString *)timestamp andFormatter:(NSString *)format;

/**
 get方法接口拼接

 @param indexUrl URL
 @param dic      参数

 @return 完整的URL
 */
+ (NSString *)getRequestWithUrL:(NSString *)indexUrl  param:(NSMutableDictionary *)dic;


/**
 获取本地的设备的IP地址

 @return 返回设备的IP
 */
+ (NSString *)getIPAddress;


/**
 获取手机的mac地址

 @return 返回手机的MAC地址
 */
+ (NSString *) macaddress;


/**
 获取电池状态
 
 @return 返回电池剩余多少
 */
+ (CGFloat)getBatteryQuantity;


/**
 获取手机总内存的大小
 
 @return 返回内存的大小
 */
+ (long long)getTotalDiskSize;


/**
 获取当前设备可用内存(单位：MB）
 
 @return 当前设备可用内存(单位：MB）
 */
+ (double)availableMemory;

/** 判断银行卡 */
+ (BOOL)isBankCard:(NSString *)cardNumber;

/**
 获取当前任务所占用的内存（单位：MB）
 
 @return 当前任务所占用的内存（单位：MB）
 */
+ (double)usedMemory;


/**
 判读字符串是否为null
 
 @param string string
 
 @return BOOL
 */
+ (BOOL) isBlankString:(NSString *)string;


/**
 判断字符串是汉字还是字母

 @param string 字符串
 @return YES 表示汉字 NO 表示字母
 */
+ (BOOL) isCharOrChineseCharacter:(NSString *)string;
/**
 获取项目版本号

 @return 版本号
 */
+ (NSString *)LoadappCurVersion;
/**
 输入全是汉字

 @param str 内容
 @return YES NO
 */
+(BOOL)IsChinese:(NSString *)str;
/**
确定 取消

@param title 标题
@param message 信息
@param CantionTitle 取消按钮字体
@param SureTitle 确定字体按钮
@param preferredStyle 风格
@param SC 确定回调
@param Nc 取消回调
@param Controller 视图
*/
+ (void)CreateTitle:(NSString *)title message:(NSString *)message CantionTitle:(NSString *)CantionTitle Sure:(NSString *)SureTitle preferredStyle:(UIAlertControllerStyle)preferredStyle SureAC:(SureAction)SC NoAC:(NoAction)Nc  ViewController:(UIViewController *)Controller;

/**
 确定

 @param title 标题
 @param message 信息
 @param SureTitle 确定字体
 @param preferredStyle 风格
 @param ac 确定回调
 @param Controller 视图
 */
+ (void)CreateTitle:(NSString *)title message:(NSString *)message  Sure:(NSString *)SureTitle preferredStyle:(UIAlertControllerStyle)preferredStyle action:(SureAction)ac ViewController:(UIViewController *)Controller;

/**
 显示缓存

 @return float
 */
+  (float)filePath;

/**
 清理缓存

 @param CS 成功回调
 */
+ (void)clearFileClearSuccess:(ClearSuccess)CS;
/**
 正则匹配用户密码6-18位数字和字母组合

 @param password 密码
 @return BOOL
 */
+ (BOOL)checkPassword:(NSString *) password;
/**
 正则匹配用户身份证号

 @param idCard 身份证号
 @return BOOL
 */
+ (BOOL)checkUserIdCard: (NSString *) idCard;
/**
 正则匹员工号,12位的数字

 @param number 员工号
 @return BOOL
 */
+ (BOOL)checkEmployeeNumber : (NSString *) number;
/**
 正则匹配URL

 @param url url
 @return BOOL
 */
+ (BOOL)checkURL : (NSString *) url;
/**
 正则匹配昵称

 @param nickname 昵称
 @return BOOL
 */
+ (BOOL) checkNickname:(NSString *) nickname;

+ (BOOL)FTT_Help_TimeDiffer:(NSString *)timer secondTime:(int)secondTime;
/**
 正则匹配银行卡号

 @param bankNumber 银行卡号
 @return BOOL
 */
+ (BOOL) checkBankNumber:(NSString *) bankNumber;
/**
 正则只能输入数字和字母

 @param CheJiaNumber 内容
 @return BOOL
 */
+ (BOOL) checkTeshuZifuNumber:(NSString *) CheJiaNumber;
/**
 车牌号验证

 @param CarNumber 车牌号
 @return BOOL
 */
+ (BOOL) checkCarNumber:(NSString *) CarNumber;
/**
 获取运营商

 @return 移动,联通,电信
 */
+ (NSString *)getIMSI;

/**
 记录应用程序打开次数
 */
+ (void)RecordAppLoadNum;

/**
 第一次打开软件

 @return BOOL
 */
+ (BOOL)isFirstLoadApp;
/**
 判断手机号

 @param mobile 手机号
 @return    BOOL
 */
+ (BOOL)isMobile:(NSString *)mobile;

/**
 字典转json

 @param dict 需要的字典
 @return Json
 */
+ (NSString *)convertToJsonData:(NSDictionary *)dict;

/**
 Json 转 字典

 @param jsonString json数据
 @return 字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 获取手机型号

 @return 手机型号
 */
+ (NSString *)getCurrentDeviceModel;

/**
 NULL 转换为@""

 @param dic 数据源
 @return 转换后的数据源
 */
+ (NSDictionary *)NullTransformationEmpty:(NSDictionary *)dic;
+ (NSString *)getDeviceId;

/**
 针对SD_Image 403 的错误 添加的方法

 @return usergent
 */
+ (NSString *)SD_imageAddinstructions;

/** 根据卡号 获取名字 */
+ (NSString *)returnBankName:(NSString*) idCard;
/**
 *
 *更具日期星期获取今天是星期几
 */
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;

/*
 view 是要设置渐变字体的控件   bgVIew是view的父视图  colors是渐变的组成颜色  startPoint是渐变开始点 endPoint结束点
 */
+(void)TextGradientview:(UIView *)view bgVIew:(UIView *)bgVIew gradientColors:(NSArray *)colors gradientStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

/*
 control 是要设置渐变字体的控件   bgVIew是control的父视图  colors是渐变的组成颜色  startPoint是渐变开始点 endPoint结束点
 */
+(void)TextGradientControl:(UIControl *)control bgVIew:(UIView *)bgVIew gradientColors:(NSArray *)colors gradientStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

+ (BOOL)isUrlAddress:(NSString*)url;

/**
 html 富文本设置

 @param str html 未处理的字符串
 @param font 设置字体
 @param lineSpacing 设置行高
 @return 默认不将 \n替换<br/> 返回处理好的富文本
 */
+ (NSMutableAttributedString *)setAttributedString:(NSString *)str font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing;


/**
 计算html字符串高度

 @param str html 未处理的字符串
 @param font 字体设置
 @param lineSpacing 行高设置
 @param width 容器宽度设置
 @return 富文本高度
 */
+ (CGFloat )getHTMLHeightByStr:(NSString *)str font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing width:(CGFloat)width;
/// 获取系统推送是否打开
+ (BOOL)loadNotificationSettingsisopen;
/// 跳到设置界面
+ (void)opensettingsurl;

/// 截图
/// @param vc 当前视图
/// @param SavedPhotos 是否保存到相册
+ (UIImage *)doScreenShot:(UIViewController *)vc SavedPhotos:(BOOL)SavedPhotos;

+ (int)CreateCurrent:(NSString *)current;

+ (NSString *)getHmacmd5:(NSString *)clearText withSecret:(NSString *)secret;
/// 获取当前时间戳 秒
+(NSString *)getNowTimeTimestamp;
/// 获取包名
+ (NSString *)getBundleIdentifier;
//获取版本号
+ (NSString *)getAppVersion;
//获取应用名称
+ (NSString *)getAppDisplayName;
/// 创建带背景视图
+ (UIView *)tengteng_configlineV:(CGRect)frame backcolor:(UIColor *)backcolor ;
/// 设置默认字体
+ (UIFont *)confignormalfontsize:(NSInteger)fontsize;
/// 设置加粗字体
+ (UIFont *)confignormalboldfontsize:(NSInteger)fontsiez;
/// 获取当前视图
+ (UIViewController *)topViewController;



@end

