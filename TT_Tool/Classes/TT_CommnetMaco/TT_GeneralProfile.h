//
//  TT_GeneralProfile.h
//  TT_Wkweb
//
//  Created by tengtengdang on 2018/12/21.
//  Copyright © 2018 FTT. All rights reserved.
//

#ifndef TT_GeneralProfile_h
#define TT_GeneralProfile_h

#import "TT_CommentTool.h"
// =================== APP信息 =================== //



// =================== 设备尺寸 =================== //


/// 是否有刘海 1 代表有 0 代表无
#define IPHONEX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})
#define IPX IPHONEX
#define IPHONE_X (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && IPX)

/// 判断系统版本
#define iOS11_1Later ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f)

///电池条的高度
#define StatusHeight   [[UIApplication sharedApplication] statusBarFrame].size.height

/// 高
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
/// 宽
#define KScreenWidth  [UIScreen mainScreen].bounds.size.width

#define IPhoneXHeigh                                    \
CGFloat security_H;                                              \
CGFloat securityNew_H;\
CGFloat securitytop_Y;\
CGFloat securityBottom_H;                                     \
if(IPHONE_X) {                                          \
securityBottom_H = 34;\
securitytop_Y = 88;\
}else {\
securitytop_Y = 64;\
securityBottom_H = 0;                                        \
}\
CGFloat bottom_H = 0;\
if ([FTT_Helper topViewController].navigationController.viewControllers.count == 1) {\
     bottom_H = securityBottom_H + 49;\
}\
security_H = [UIScreen mainScreen].bounds.size.height - securitytop_Y - bottom_H;\
securityNew_H = [UIScreen mainScreen].bounds.size.height - securitytop_Y;\




// =================== 工程需要 =================== //

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif




#ifdef DEBUG
#define NSLog(FORMAT, ...) {\
NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];\
[dateFormatter setDateStyle:NSDateFormatterMediumStyle];\
[dateFormatter setTimeStyle:NSDateFormatterShortStyle];\
[dateFormatter setDateFormat:@"HH:mm:ss:SSSSSS"]; \
NSString *str = [dateFormatter stringFromDate:[NSDate date]];\
fprintf(stderr,"时间:%s %s:%d\t\n%s\n",[str UTF8String],[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);\
}\

#else
#define NSLog(...)
#endif



#define NSUSER [NSUserDefaults standardUserDefaults]
#define SYNCHR [NSUSER synchronize];
/** 存 */
#define SaveObject(x,y)\
[NSUSER setObject:x forKey:y];\
SYNCHR\

#define SaveFloat(x,y)\
[NSUSER setFloat:x forKey:y];\
SYNCHR\

#define SaveBool(x,y)\
[NSUSER setBool:x forKey:y];\
SYNCHR\

#define SaveInteger(x,y)\
[NSUSER setInteger:x forKey:y];\
SYNCHR\

#define SaveURL(x,y)\
[NSUSER setURL:x forKey:y];\
SYNCHR\

#define SaveValue(x,y)\
[NSUSER setValue:x forKey:y];\
SYNCHR\


/** 取 */
#define TakeOutExist(x)\
id Takeoutkey;\
Exist(x){\
Takeoutkey = [NSUSER objectForKey:x];\
}else {\
Takeoutkey = @"BCZ";\
}\
\

/** 取 */
#define TakeOut(x)\
[[NSUserDefaults standardUserDefaults]objectForKey:x]\

/** 判断 key 存在 */
#define Exist(X)      if (![[NSUSER objectForKey:X] isKindOfClass:[NSNull class]] && [NSUSER objectForKey:X]!= nil && [NSUSER objectForKey:X] !=NULL)

/// 判断这个key不存在
#define BuCunZai(X)    if ([[NSUSER objectForKey:X] isKindOfClass:[NSNull class]] || [NSUSER objectForKey:X]== nil || [NSUSER objectForKey:X] ==NULL)


/// 清除
#define Eliminate(x) \
[NSUSER removeObjectForKey:x];\
SYNCHR\




/**  发通知  */
#define SendMessage(name,dic)  [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:dic];
/**  收通知  */
#define ResiveMessage(name,DoSoming) [[NSNotificationCenter defaultCenter] addObserverForName:name object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) { NSLog(@"%@",note); DoSoming }];
/**  移除通知  */
#define RemovoResiveMessage(name) [[NSNotificationCenter defaultCenter]removeObserver:self name:name object:nil];


// =================== 手机色彩 =================== //

/// RGB格式
#define TT_RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
/// RGBA格式
#define TT_RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
/// 随机颜色
#define TT_RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

#define TT_UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


// =================== 系统对象 =================== //


//APP对象 （单例对象）
#define TT_Application [UIApplication sharedApplication]
//主窗口 （keyWindow）
#define TT_KeyWindow [UIApplication sharedApplication].keyWindow
//APP版本号
#define TT_Version [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]
//系统版本号
#define TT_SystemVersion [[UIDevice currentDevice] systemVersion]



// =================== 通用方法 =================== //


/// 属性快速声明
#define TT_PropertyString(name) @property(nonatomic,copy) NSString *name;
#define TT_PropertyStrong(type,name) @property(nonatomic,strong) type *name;
#define TT_PropertyAssign(type,name) @property(nonatomic,assign) type name;

/// View 圆角
#define TT_ViewRadius(View, Radius)\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\

/// View 圆角和加边框
#define TT_ViewBorderRadius(View, Radius, Width, Color)\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]\

// =================== 获取时间 =================== //

/// 获得当前的年份
#define  TT_CurrentYear  [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:[NSDate date]];
/// 获得当前的月份
#define  TT_CurrentMonth [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:[NSDate date]];
/// 获得当前的日期
#define  TT_CurrentDay   [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:[NSDate date]];
/// 获得当前的小时
#define  TT_CurrentHour  [[NSCalendar currentCalendar] component:NSCalendarUnitHour fromDate:[NSDate date]];
/// 获得当前的分
#define  TT_CurrentMin   [[NSCalendar currentCalendar] component:NSCalendarUnitMinute fromDate:[NSDate date]];
/// 获得当前的秒
#define  TT_CurrentSec   [[NSCalendar currentCalendar] component:NSCalendarUnitSecond fromDate:[NSDate date]];


// =================== 沙盒路径 =================== //
//获取沙盒 temp
#define TT_PathTemp     NSTemporaryDirectory()
//获取沙盒 Document
#define TT_PathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define TT_PathCache    [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
//Library/Caches 文件路径
#define TT_FilePath     ([[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil])



// =================== 判空 =================== //
//字符串是否为空
#define TT_ISNullString(str)     ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define TT_ISNullArray(array)    (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0 ||[array isEqual:[NSNull null]])
//字典是否为空
#define TT_ISNullDict(dic)       (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0 || [dic isEqual:[NSNull null]])
//是否是空对象
#define TT_ISNullObject(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))



// =================== 单利 =================== //

#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define SINGLETON_FOR_IMPLEMENTATION(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

// =================== BASE =================== //

#define DefaultPAGE 1

#define DefauleCode @"code"

#define DefaultSuccess 0

#define DefaultBackIMG @"back_black"

#define DefaultStr @"TT"

#endif /* TT_GeneralProfile_h */
