//
//  FTT_Helper.m
//  测试
//
//  Created by 樊腾 on 16/11/28.
//  Copyright © 2016年 FTT. All rights reserved.
//

#import "FTT_Helper.h"
#import "sys/utsname.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <AdSupport/AdSupport.h>

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <arpa/inet.h>


#import <sys/mount.h>
#import <sys/sysctl.h>
#import <mach/mach.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <UserNotifications/UserNotifications.h>
#import "TT_ControlTool.h"
#import "TT_GeneralProfile.h"
#import "TT_CommentCat.h"
static NSString *const kAppVersion = @"appVersion";
@implementation FTT_Helper
/**
 时间字符串的转换
 
 @param inputString 输入的时间字符串
 @param type        想要得到的字符串格式
 @param is_yyyy     是否年是2016 格式 还是 16格式
 
 @return            返回想要的时间格式
 */
+ (NSString *)converDataString:(NSString *)inputString FTT_HelperDateStringType:(FTT_HelperDateStringType)type is_yyyy:(BOOL)is_yyyy {
    
    NSString *yy,*MM,*dd,*HH,*ss, *SS;

    if (is_yyyy) {
        yy = [inputString substringWithRange:NSMakeRange(0, 4)];
        MM = [inputString substringWithRange:NSMakeRange(4, 2)];
        dd = [inputString substringWithRange:NSMakeRange(6, 2)];
        HH = [inputString substringWithRange:NSMakeRange(8, 2)];
        ss = [inputString substringWithRange:NSMakeRange(10, 2)];
        SS = [inputString substringWithRange:NSMakeRange(12, 2)];
    }else {
        NSString *ye = @"20";
        yy = [ye stringByAppendingString:[inputString substringToIndex:2]];
        MM = [inputString substringWithRange:NSMakeRange(2, 2)];
        dd = [inputString substringWithRange:NSMakeRange(4, 2)];
        HH = [inputString substringWithRange:NSMakeRange(6, 2)];
        ss = [inputString substringWithRange:NSMakeRange(8, 2)];
    }
    NSString *timer;
    if (type == FTT_HelperDateStringTypeHHss) {
        timer = [NSString stringWithFormat:@"%@:%@ %@/%@/%@",HH,ss,yy,MM,dd];
    }else if (type == FTT_HelperDateStringTypeYYMM) {
        timer = [NSString stringWithFormat:@"%@.%@.%@ %@:%@",yy,MM,dd,HH,ss];
    }else {
        timer = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",yy,MM,dd,HH,ss,SS];
    }
    return timer;
}

/**
 把字符串转换成NSDate

 @param string 时间字符串

 @return NSDate
 */
+ (NSDate*)dateFromString:(NSString*)string
{
    // 设置转换格式
    NSDateFormatter*formatter=[[NSDateFormatter alloc]init];
    // 此为世界时间与我们的时间错了8个小时
    // [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    // NSString转NSDate
    NSDate*date=[formatter dateFromString:string];
    return date;
}


+ (NSDate *)dateFromString:(NSString *)string dateFormat:(NSString *)dateFormat {
    NSDateFormatter*formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:dateFormat];
    NSDate*date=[formatter dateFromString:string];
    return date;
}
/**
 计算指定时间与现在时间的时间差
 
 @param timer 指定的时间
 
 @return 返回距离的时间差
 */
+ (NSString *)TimeDifference:(NSString *)timer {
    NSDate *date = [NSDate date];
    NSTimeInterval time = [[self dateFromString:timer] timeIntervalSinceDate:date];
    //计算天数、时、分、秒
    int days = ((int)time)/(3600*24);
    
    int hours = ((int)time)%(3600*24)/3600;
    
    int minutes = ((int)time)%(3600*24)%3600/60;
    
    int seconds = ((int)time)%(3600*24)%3600%60;
    if (days == 0 && hours == 0 && minutes ==0 && seconds == 0 ) {
        return @"现在";
    }else if (days ==0 && hours == 0 && minutes == 0){
        return [[NSString alloc] initWithFormat:@"仅剩%i秒",seconds];
    }else if (days == 0 && hours == 0){
        return [[NSString alloc] initWithFormat:@"仅剩%i分%i秒",minutes,seconds];
    }else if (days == 0){
        return [[NSString alloc] initWithFormat:@"仅剩%i小时%i分%i秒",hours,minutes,seconds];
    }else {
        return [[NSString alloc] initWithFormat:@"仅剩%i天%i小时%i分%i秒",days,hours,minutes,seconds];
    }
}

+ (BOOL)TimeDfiffer:(NSString *)timer {
    NSDate *date = [NSDate date];
    NSTimeInterval time = [[self dateFromString:timer] timeIntervalSinceDate:date];
    //计算天数、时、分、秒
    int days = ((int)time)/(3600*24);

    int hours = ((int)time)%(3600*24)/3600;

    int minutes = ((int)time)%(3600*24)%3600/60;

    int seconds = ((int)time)%(3600*24)%3600%60;
    if (days == 0 && hours == 0 && minutes ==0 && seconds == 0 ) {
        return NO;
    }else if (days ==0 && hours == 0 && minutes == 0){
        if (seconds > 5 ) {
            return YES;
        }else {
            return NO;
        }
    }else if (days == 0 && hours == 0){
        return YES;
    }else if (days == 0){
        return YES;
    }else {
        return YES;
    }
}

+ (BOOL)FTT_Help_TimeDiffer:(NSString *)timer secondTime:(int)secondTime {
    NSDate *date = [NSDate date];
    NSTimeInterval time = [[self dateFromString:timer] timeIntervalSinceDate:date];
    int t = (int)time;
    if (t == secondTime) {
        return YES;
    }else {
        return NO;
    }
}


+ (NSString *)LoadTimeAndNowTime:(NSString *)time {
    NSDate *date = [NSDate date];
    NSTimeInterval timer = [[self dateFromString:time] timeIntervalSinceDate:date];
    //计算天数、时、分、秒
    int days = ((int)timer)/(3600*24);

    if ((timer) < 0) {
        return [NSString stringWithFormat:@"预约订单:%@-%@ %@:%@",[time substringWithRange:NSMakeRange(4, 2)],[time substringWithRange:NSMakeRange(6, 2)],[time substringWithRange:NSMakeRange(8, 2)],[time substringWithRange:NSMakeRange(10, 2)]];
    }else {
        if (days == 0){
            return [[NSString alloc] initWithFormat:@"预约订单:今天%@:%@",[time substringWithRange:NSMakeRange(8, 2)],[time substringWithRange:NSMakeRange(10, 2)]];
        }else if (days == 1){
            return [[NSString alloc] initWithFormat:@"预约订单:明天%@:%@",[time substringWithRange:NSMakeRange(8, 2)],[time substringWithRange:NSMakeRange(10, 2)]];
        }else {
            return [[NSString alloc] initWithFormat:@"预约订单:后天%@:%@",[time substringWithRange:NSMakeRange(8, 2)],[time substringWithRange:NSMakeRange(10, 2)]
                    ];
        }
    }
}


+(NSString *)timestampSwitchTime:(NSString *)timestamp andFormatter:(NSString *)format{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSTimeInterval second = timestamp.longLongValue / 1000.0;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:second];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
    
}

/// 获取当前时间戳 秒
+(NSString *)getNowTimeTimestamp{
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    return timeSp;
}


/// 获取当前时间戳 毫秒
+(NSString *)getNowTimeTimestamp3{

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970]*1000)];
    return timeSp;
}

/**
 当前时间转换成字符串

 @param formate 转换的格式 例如@ "yyyyMMddHHmmss"

 @return 返回转换后的时间
 */
+ (NSString*)loadNewTime:(NSString *)formate{
    // 获取当前时间，日期
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];;
    return dateString;
}

/**
 根据字体的内容，最大宽度，字体大小来计算文字的高度
 
 @param content  需要计算的字符串
 @param width   最大的宽度
 @param font    字体的大小
 
 @return 返回字符串的高度
 */
+ (CGSize)contentSizeOfString:(NSString*)content maxWidth:(CGFloat)width font:(UIFont*)font {
    if (content.length == 0) {
        return CGSizeZero ;
    }
    CGRect  rect = [content  boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size ;
}


/**
 根据输入的图片的宽高，计算图片缩放后的大小
 
 @param inputImgWith    输入的图片的宽度
 @param inputImgHeight  输入的图片的高度
 @param width           默认的图片的宽度
 
 @return 返回图片的宽高
 */
+ (CGSize)imageSize:(NSString *)inputImgWith height:(NSString *)inputImgHeight restictWidth:(CGFloat)width{
    // 如果没有图片的宽高，返回zero
    if (inputImgHeight.length == 0 || inputImgWith.length == 0) {
        return CGSizeZero;
    }
    // 计算出在X 方向上的缩放因子
    CGFloat  scalex = width * 1.0 / [inputImgWith integerValue];
    // 由于是等比例缩放 ，所以高度乘以相同的缩放因子
    CGFloat  height = [inputImgHeight  integerValue ] *scalex ;
    return CGSizeMake(width, height);
}


//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
+ (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
}

//+ (NSString *)stringWithTimelineDate:(NSDate *)date {
//    if (!date) return @"";
//
//    static NSDateFormatter *formatterYesterday;
//    static NSDateFormatter *formatterSameYear;
//    static NSDateFormatter *formatterFullDate;
//
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        formatterYesterday = [[NSDateFormatter alloc] init];
//        [formatterYesterday setDateFormat:@"昨天 HH:mm"];
//        [formatterYesterday setLocale:[NSLocale currentLocale]];
//
//        formatterSameYear = [[NSDateFormatter alloc] init];
//        [formatterSameYear setDateFormat:@"MM-d HH:mm"];
//        [formatterSameYear setLocale:[NSLocale currentLocale]];
//
//        formatterFullDate = [[NSDateFormatter alloc] init];
//        [formatterFullDate setDateFormat:@"yy-MM-dd HH:mm"];
//        [formatterFullDate setLocale:[NSLocale currentLocale]];
//    });
//
//    NSDate *now = [NSDate new];
//    NSTimeInterval delta = now.timeIntervalSince1970 - date.timeIntervalSince1970;
//    if (delta < -60 * 10) { // 本地时间有问题
//        return [formatterFullDate stringFromDate:date];
//    } else if (delta < 60 * 1) { // 10分钟内
//        return @"刚刚";
//    } else if (delta < 60 * 60) { // 1小时内
//        return [NSString stringWithFormat:@"%d分钟前", (int)(delta / 60.0)];
//    } else if (date.isToday) {
//        return [NSString stringWithFormat:@"%d小时前", (int)(delta / 60.0 / 60.0)];
//    } else if (date.isYesterday) {
//        return [formatterYesterday stringFromDate:date];
//    } else if (date.year == now.year) {
//        return [formatterSameYear stringFromDate:date];
//    } else {
//        return [formatterFullDate stringFromDate:date];
//    }
//}
/**
 get方法接口拼接
 
 @param indexUrl URL
 @param dic      参数
 
 @return 完整的URL
 */
+ (NSString *)getRequestWithUrL:(NSString *)indexUrl  param:(NSMutableDictionary *)dic {
    // 初始化参数变量
    NSString *str = @"";
    // 快速遍历参数数组
    for(id key in dic) {
        str = [str stringByAppendingString:key];
        str = [str stringByAppendingString:@"＝"];
        str = [str stringByAppendingString:[dic objectForKey:key]];
        str = [str stringByAppendingString:@"&"];
    }
    // 处理多余的&以及返回含参url
    if (str.length > 1) {
        // 去掉末尾的&
        str = [str substringToIndex:str.length - 1];
        // 返回含参url
        return [indexUrl stringByAppendingString:str];
    }
    return Nil;
}
/**
 获取本地的设备的IP地址
 
 @return 返回设备的IP
 */
+ (NSString *)getIPAddress {
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    
    NSMutableArray *ips = [NSMutableArray array];
    
    int BUFFERSIZE = 4096;
    
    struct ifconf ifc;
    
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    
    struct ifreq *ifr, ifrcopy;
    
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0){
        
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            
            ifr = (struct ifreq *)ptr;
            int len = sizeof(struct sockaddr);
            
            if (ifr->ifr_addr.sa_len > len) {
                len = ifr->ifr_addr.sa_len;
            }
            
            ptr += sizeof(ifr->ifr_name) + len;
            if (ifr->ifr_addr.sa_family != AF_INET) continue;
            if ((cptr = (char *)strchr(ifr->ifr_name, ':')) != NULL) *cptr = 0;
            if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0) continue;
            
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            
            if ((ifrcopy.ifr_flags & IFF_UP) == 0) continue;
            
            NSString *ip = [NSString  stringWithFormat:@"%s", inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    
    close(sockfd);
    NSString *deviceIP = @"";
    
    for (int i=0; i < ips.count; i++) {
        if (ips.count > 0) {
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
        }
    }
    return deviceIP;

}
/**
 获取手机的mac地址
 
 @return 返回手机的MAC地址
 */
+ (NSString *)macaddress {
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    
    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return [outstring uppercaseString];
}
/**
 获取电池状态

 @return 返回电池剩余多少
 */
+ (CGFloat)getBatteryQuantity
{
    return [[UIDevice currentDevice] batteryLevel];
}
/**
 获取手机总内存的大小
 
 @return 返回内存的大小
 */
+ (long long)getTotalDiskSize
{
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0)
    {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_blocks);
    }
    return freeSpace;
}
/**
 获取当前设备可用内存(单位：MB）

 @return 当前设备可用内存(单位：MB）
 */
+ (double)availableMemory
{
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0)
    {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
    }
    return freeSpace;
}

/**
 获取当前任务所占用的内存（单位：MB）

 @return 当前任务所占用的内存（单位：MB）
 */
+ (double)usedMemory
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS
        ) {
        return NSNotFound;
    }
    
    return taskInfo.resident_size / 1024.0 / 1024.0;
}
/**
 判读字符串是否为null
 
 @param string string
 
 @return BOOL
 */
+ (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isEqual:[NSNull null]]) {
        return YES;
    }
    return NO;
}
/**
 判断字符串是汉字还是字母

 @param string 字符串
 @return YES 表示汉字 NO 表示字母
 */
+ (BOOL)isCharOrChineseCharacter:(NSString *)string {
    NSInteger num = 0 , Cnum = 0;
    
    for (int i = 0 ; i < string.length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [string substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) == 3) {
            num = num + 3;
        }else if (strlen(cString) == 1){
            Cnum++;
        }
    }
    if ((num + Cnum) ==string.length) {
        return NO;
    }else {
        return YES;
    }
}
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
+ (void)CreateTitle:(NSString *)title message:(NSString *)message CantionTitle:(NSString *)CantionTitle Sure:(NSString *)SureTitle preferredStyle:(UIAlertControllerStyle)preferredStyle SureAC:(SureAction)SC NoAC:(NoAction)Nc  ViewController:(UIViewController *)Controller {


    UIAlertController *alc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    UIAlertAction *action1 =[UIAlertAction actionWithTitle:CantionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (Nc) {
            Nc();
        }
    }];
    [action1 setValue:[UIColor grayColor] forKey:@"titleTextColor"];
    
    UIAlertAction *action =[UIAlertAction actionWithTitle:SureTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (SC) {
            SC();
        }
    }];
    [action setValue:[UIColor getColor:@"#1675E1"] forKey:@"titleTextColor"];
    [alc addAction:action1];
    [alc addAction:action];
    [Controller presentViewController:alc animated:YES completion:nil];

}

/**
 确定

 @param title 标题
 @param message 信息
 @param SureTitle 确定字体
 @param preferredStyle 风格
 @param ac 确定回调
 @param Controller 视图
 */

+ (void)CreateTitle:(NSString *)title message:(NSString *)message  Sure:(NSString *)SureTitle preferredStyle:(UIAlertControllerStyle)preferredStyle action:(SureAction)ac ViewController:(UIViewController *)Controller{
    UIAlertController *alc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    UIAlertAction *action = [UIAlertAction actionWithTitle:SureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (ac) {
            ac();
        }
    }];
    [alc addAction:action];
    [Controller presentViewController:alc animated:YES completion:nil];
}

/**
 显示缓存

 @return float
 */
+  (float)filePath {
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)firstObject];
    return [self folderSizeAtPath:cachPath];
}

/**
 首先计算 单个文件大小

 @param filePath 路径
 @return 大小
 */
+ (long long)fileSizeAtPath:(NSString *)filePath {
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil]fileSize];
    }
    return 0 ;
}

/**
 遍历文件夹获得文件夹大小

 @param folderPath 路径
 @return M
 */
+ (float)folderSizeAtPath:(NSString *)folderPath {
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath]objectEnumerator ];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath :fileAbsolutePath];
    }
    return folderSize/(1024.0 * 1024.0);
}
// 清理缓存
+ (void)clearFileClearSuccess:(ClearSuccess)CS {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString * cachPath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory,NSUserDomainMask,YES)firstObject];
        NSArray * files = [[NSFileManager defaultManager]subpathsAtPath:cachPath];
        for (NSString *p in files) {
            NSError * error = nil ;
            NSString * path = [cachPath stringByAppendingPathComponent :p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }

    });
    dispatch_async(dispatch_get_main_queue(), ^{
        if (CS) {
            CS();
        }
    });
}
/**
 正则匹配用户密码6-18位数字和字母组合

 @param password 密码
 @return BOOL
 */
+ (BOOL)checkPassword:(NSString *)password {
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}
/**
 正则匹配用户身份证号

 @param idCard 身份证号
 @return BOOL
 */
+ (BOOL)checkUserIdCard:(NSString *)idCard {
    BOOL flag;
    if (idCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}
/**
 正则匹员工号,12位的数字

 @param number 员工号
 @return BOOL
 */
+ (BOOL)checkEmployeeNumber:(NSString *)number {
    NSString *pattern = @"^[0-9]{12}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
}

/**
 正则匹配URL

 @param url url
 @return BOOL
 */
+ (BOOL)checkURL:(NSString *)url {
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
}
/**
 正则匹配昵称

 @param nickname 昵称
 @return BOOL
 */
+ (BOOL)checkNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    BOOL isMatch = [pred evaluateWithObject:nickname];
    return isMatch;
}

/**
 正则匹配银行卡号

 @param bankNumber 银行卡号
 @return BOOL
 */
+ (BOOL)checkBankNumber:(NSString *)bankNumber{
    NSString *bankNum=@"^([0-9]{16}|[0-9]{19})$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    BOOL isMatch = [pred evaluateWithObject:bankNumber];
    return isMatch;

}

+ (BOOL)isBankCard:(NSString *)cardNumber {
    if(cardNumber.length==0){
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < cardNumber.length; i++){
        c = [cardNumber characterAtIndex:i];
        if (isdigit(c)){
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--){
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo){
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}

/**
 正则只能输入数字和字母

 @param CheJiaNumber 内容
 @return BOOL
 */
+ (BOOL)checkTeshuZifuNumber:(NSString *)CheJiaNumber{
    NSString *bankNum=@"^[A-Za-z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    BOOL isMatch = [pred evaluateWithObject:CheJiaNumber];
    return isMatch;
}
/**
 车牌号验证

 @param CarNumber 车牌号
 @return BOOL
 */
+ (BOOL)checkCarNumber:(NSString *)CarNumber{
    NSString *bankNum = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    BOOL isMatch = [pred evaluateWithObject:CarNumber];
    return isMatch;
}

/**
 获取运营商

 @return 移动,联通,电信
 */
+ (NSString *)getIMSI {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc]init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSString *currentCountry = [carrier carrierName];
    return currentCountry;
}

// 记录应用程序打开的次数
+ (void)RecordAppLoadNum {
    // 去沙盒里面取一个key 的值
    NSInteger num = [[NSUserDefaults  standardUserDefaults]integerForKey:kAppVersion];
    num++ ;
    // 保存
    [[NSUserDefaults standardUserDefaults]setInteger:num forKey:kAppVersion];
    [[NSUserDefaults  standardUserDefaults] synchronize];
}

/**
 *  是否是第一次打开
 */

+ (BOOL)isFirstLoadApp {
    NSInteger num = [[NSUserDefaults standardUserDefaults]integerForKey:kAppVersion];
    if (num == 1) {
        return YES ;
    }else {
        return NO ;
    }
}
/**
 判断手机号

 @param mobile 手机号
 @return    BOOL
 */
+ (BOOL)isMobile:(NSString *)mobile {
    NSString *MOBILE = @"^1[3456789]\\d{9}$";
    NSPredicate *regexTestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    if ([regexTestMobile evaluateWithObject:mobile]) {
        return YES;
    }else {
        return NO;
    }
}

+ (NSString *)getDeviceId
{
//    NSString * currentDeviceUUIDStr = [SAMKeychain passwordForService:@" "account:@"uuid"];
//    if (currentDeviceUUIDStr == nil || [currentDeviceUUIDStr isEqualToString:@""])
//    {
//        NSUUID * currentDeviceUUID  = [UIDevice currentDevice].identifierForVendor;
//        currentDeviceUUIDStr = currentDeviceUUID.UUIDString;
//        currentDeviceUUIDStr = [currentDeviceUUIDStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
//        currentDeviceUUIDStr = [currentDeviceUUIDStr lowercaseString];
//        [SAMKeychain setPassword: currentDeviceUUIDStr forService:@" "account:@"uuid"];
//    }
//    return currentDeviceUUIDStr;
    return nil;
}
/**
 字典转json

 @param dict 需要的字典
 @return Json
 */
+ (NSString *)convertToJsonData:(NSDictionary *)dict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@"" withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
}

+ (NSString*)dictionaryToJson:(NSDictionary *)dic {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

/**
 Json 转 字典

 @param jsonString json数据
 @return 字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        FNSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

/**
 获取项目版本号

 @return 版本号
 */
+ (NSString *)LoadappCurVersion {
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    return version;
}
/**
 输入全是汉字

 @param str 内容
 @return YES NO
 */
+(BOOL)IsChinese:(NSString *)str {
    NSInteger count = str.length;
    NSInteger result = 0;
    for(int i=0; i< [str length];i++)
    {
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)//判断输入的是否是中文
        {
            result++;
        }
    }
    if (count == result) {//当字符长度和中文字符长度相等的时候
        return YES;
    }
    return NO;
}

+ (NSString *)getCurrentDeviceModel{
   struct utsname systemInfo;
   uname(&systemInfo);
   
   NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
   
   
if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
if ([deviceModel isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
if ([deviceModel isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
// 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
if ([deviceModel isEqualToString:@"iPhone10,1"])   return @"iPhone_8";
if ([deviceModel isEqualToString:@"iPhone10,4"])   return @"iPhone_8";
if ([deviceModel isEqualToString:@"iPhone10,2"])   return @"iPhone_8_Plus";
if ([deviceModel isEqualToString:@"iPhone10,5"])   return @"iPhone_8_Plus";
if ([deviceModel isEqualToString:@"iPhone10,3"])   return @"iPhone X";
if ([deviceModel isEqualToString:@"iPhone10,6"])   return @"iPhone X";
if ([deviceModel isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
if ([deviceModel isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
if ([deviceModel isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
if ([deviceModel isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
if ([deviceModel isEqualToString:@"iPhone12,1"])   return @"iPhone 11";
if ([deviceModel isEqualToString:@"iPhone12,3"])   return @"iPhone 11 Pro";
if ([deviceModel isEqualToString:@"iPhone12,5"])   return @"iPhone 11 Pro Max";
if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
if ([deviceModel isEqualToString:@"iPad1,2"])      return @"iPad 3G";
if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2";
if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2";
if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad Mini";
if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3";
if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4";
if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
if ([deviceModel isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
if ([deviceModel isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
if ([deviceModel isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
if ([deviceModel isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
if ([deviceModel isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
if ([deviceModel isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
if ([deviceModel isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
if ([deviceModel isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
if ([deviceModel isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
if ([deviceModel isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
if ([deviceModel isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
if ([deviceModel isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";

if ([deviceModel isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2";
if ([deviceModel isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3";
if ([deviceModel isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3";
if ([deviceModel isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4";

if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    return deviceModel;
}

+ (NSDictionary *)NullTransformationEmpty:(NSDictionary *)dic {
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([FTT_Helper isBlankString:obj]) {
            [dic setValue:@"" forKey:key];
        }
    }];
    return dic;
}

+ (NSString *)SD_imageAddinstructions {
    NSString *userAgent = @"";
    userAgent = [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)", [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleExecutableKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];

    if (userAgent) {
        if (![userAgent canBeConvertedToEncoding:NSASCIIStringEncoding]) {
            NSMutableString *mutableUserAgent = [userAgent mutableCopy];
            if (CFStringTransform((__bridge CFMutableStringRef)(mutableUserAgent), NULL, (__bridge CFStringRef)@"Any-Latin; Latin-ASCII; [:^ASCII:] Remove", false)) {
                userAgent = mutableUserAgent;
            }
        }
    }
    return userAgent;
}



+ (NSString *)returnBankName:(NSString*) idCard{

    //"发卡行.卡种名称",
    NSArray* bankName = @[
                          @"邮储银行·绿卡通" , @"邮储银行·绿卡银联标准卡" , @"邮储银行·绿卡银联标准卡" , @"邮储银行·绿卡专用卡" , @"邮储银行·绿卡银联标准卡",
                          @"邮储银行·绿卡(银联卡)" , @"邮储银行·绿卡VIP卡" , @"邮储银行·银联标准卡" , @"邮储银行·中职学生资助卡" , @"邮政储蓄银行·IC绿卡通VIP卡",
                          @"邮政储蓄银行·IC绿卡通" , @"邮政储蓄银行·IC联名卡" , @"邮政储蓄银行·IC预付费卡" , @"邮储银行·绿卡银联标准卡" , @"邮储银行·绿卡通",
                          @"邮政储蓄银行·武警军人保障卡" ,@"邮政储蓄银行·中国旅游卡（金卡）" ,@"邮政储蓄银行·普通高中学生资助卡" ,@"邮政储蓄银行·中国旅游卡（普卡）",
                          @"邮政储蓄银行·福农卡" , @"工商银行·牡丹运通卡金卡" , @"工商银行·牡丹运通卡金卡" , @"工商银行·牡丹运通卡金卡" , @"工商银行·牡丹VISA卡(单位卡)",
                          @"工商银行·牡丹VISA信用卡" , @"工商银行·牡丹VISA卡(单位卡)" , @"工商银行·牡丹VISA信用卡" , @"工商银行·牡丹VISA信用卡" , @"工商银行·牡丹VISA信用卡",
                          @"工商银行·牡丹VISA信用卡" , @"工商银行·牡丹运通卡普通卡" , @"工商银行·牡丹VISA信用卡" , @"工商银行·牡丹VISA白金卡" , @"工商银行·牡丹贷记卡(银联卡)",
                          @"工商银行·牡丹贷记卡(银联卡)" , @"工商银行·牡丹贷记卡(银联卡)" , @"工商银行·牡丹贷记卡(银联卡)" , @"工商银行·牡丹欧元卡" , @"工商银行·牡丹欧元卡",
                          @"工商银行·牡丹欧元卡" , @"工商银行·牡丹万事达国际借记卡" , @"工商银行·牡丹VISA信用卡" , @"工商银行·海航信用卡" , @"工商银行·牡丹VISA信用卡",
                          @"工商银行·牡丹万事达信用卡" , @"工商银行·牡丹万事达信用卡" , @"工商银行·牡丹万事达信用卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡",
                          @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹万事达白金卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡",
                          @"工商银行·海航信用卡个人普卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡",
                          @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡",
                          @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡",
                          @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡",
                          @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡",
                          @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡",
                          @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡",
                          @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡",
                          @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡",
                          @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡",
                          @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡",
                          @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡",
                          @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡",
                          @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡",
                          @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡",
                          @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡",
                          @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡" , @"工商银行·牡丹灵通卡",
                          @"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·E时代卡" ,@"工商银行·E时代卡" ,@"工商银行·理财金卡" ,@"工商银行·准贷记卡(个普)" , @"工商银行·准贷记卡(个普)" , @"工商银行·准贷记卡(个普)" , @"工商银行·准贷记卡(个普)" , @"工商银行·准贷记卡(个普)" , @"工商银行·牡丹灵通卡" ,@"工商银行·准贷记卡(商普)" , @"工商银行·牡丹卡(商务卡)" , @"工商银行·准贷记卡(商金)" , @"工商银行·牡丹卡(商务卡)" , @"工商银行·贷记卡(个普)" , @"工商银行·牡丹卡(个人卡)" , @"工商银行·牡丹卡(个人卡)" , @"工商银行·牡丹卡(个人卡)" , @"工商银行·牡丹卡(个人卡)" , @"工商银行·贷记卡(个金)" , @"工商银行·牡丹交通卡" ,@"工商银行·准贷记卡(个金)" , @"工商银行·牡丹交通卡" ,@"工商银行·贷记卡(商普)" , @"工商银行·贷记卡(商金)" , @"工商银行·牡丹卡(商务卡)" , @"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹交通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·牡丹贷记卡" ,@"工商银行·牡丹贷记卡" ,@"工商银行·牡丹贷记卡" ,@"工商银行·牡丹贷记卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·中央预算单位公务卡" ,@"工商银行·牡丹灵通卡" ,@"工商银行·财政预算单位公务卡" ,@"工商银行·牡丹卡白金卡" ,@"工商银行·牡丹卡普卡" ,@"工商银行·国航知音牡丹信用卡" ,@"工商银行·国航知音牡丹信用卡" ,@"工商银行·国航知音牡丹信用卡" ,@"工商银行·国航知音牡丹信用卡" ,@"工商银行·银联标准卡" ,@"工商银行·中职学生资助卡" ,@"工商银行·专用信用消费卡" ,@"工商银行·牡丹社会保障卡" ,@"中国工商银行·牡丹东航联名卡" ,@"中国工商银行·牡丹东航联名卡" ,@"中国工商银行·牡丹运通白金卡" ,@"中国工商银行·福农灵通卡" ,@"中国工商银行·福农灵通卡" ,@"工商银行·灵通卡" ,@"工商银行·灵通卡" ,@"中国工商银行·中国旅行卡" ,@"工商银行·牡丹卡普卡" ,@"工商银行·国际借记卡" ,@"工商银行·国际借记卡" ,@"工商银行·国际借记卡" ,@"工商银行·国际借记卡" ,@"中国工商银行·牡丹JCB信用卡" , @"中国工商银行·牡丹JCB信用卡" , @"中国工商银行·牡丹JCB信用卡" , @"中国工商银行·牡丹JCB信用卡" , @"中国工商银行·牡丹多币种卡" ,@"中国工商银行·武警军人保障卡" ,@"工商银行·预付芯片卡" ,@"工商银行·理财金账户金卡" ,@"工商银行·灵通卡" ,@"工商银行·牡丹宁波市民卡" ,@"中国工商银行·中国旅游卡" ,@"中国工商银行·中国旅游卡" ,@"中国工商银行·中国旅游卡" ,@"中国工商银行·借记卡" ,@"中国工商银行·借贷合一卡" ,@"中国工商银行·普通高中学生资助卡" ,@"中国工商银行·牡丹多币种卡" ,@"中国工商银行·牡丹多币种卡" ,@"中国工商银行·牡丹百夫长信用卡" ,@"中国工商银行·牡丹百夫长信用卡" ,@"工商银行·工银财富卡" ,@"中国工商银行·中小商户采购卡" ,@"中国工商银行·中小商户采购卡" ,@"中国工商银行·环球旅行金卡" ,@"中国工商银行·环球旅行白金卡" ,@"中国工商银行·牡丹工银大来卡" ,@"中国工商银行·牡丹工银大莱卡" ,@"中国工商银行·IC金卡" ,@"中国工商银行·IC白金卡" ,@"中国工商银行·工行IC卡（红卡）" , @"中国工商银行布鲁塞尔分行·借记卡" , @"中国工商银行布鲁塞尔分行·预付卡" , @"中国工商银行布鲁塞尔分行·预付卡" , @"中国工商银行金边分行·借记卡" , @"中国工商银行金边分行·信用卡" , @"中国工商银行金边分行·借记卡" , @"中国工商银行金边分行·信用卡" , @"中国工商银行加拿大分行·借记卡" , @"中国工商银行加拿大分行·借记卡" , @"中国工商银行加拿大分行·预付卡" , @"中国工商银行巴黎分行·借记卡" , @"中国工商银行巴黎分行·借记卡" , @"中国工商银行巴黎分行·贷记卡" , @"中国工商银行法兰克福分行·贷记卡" , @"中国工商银行法兰克福分行·借记卡" , @"中国工商银行法兰克福分行·贷记卡" , @"中国工商银行法兰克福分行·贷记卡" , @"中国工商银行法兰克福分行·借记卡" , @"中国工商银行法兰克福分行·预付卡" , @"中国工商银行法兰克福分行·预付卡" , @"中国工商银行印尼分行·借记卡" , @"中国工商银行印尼分行·信用卡" , @"中国工商银行米兰分行·借记卡" , @"中国工商银行米兰分行·预付卡" , @"中国工商银行米兰分行·预付卡" , @"中国工商银行阿拉木图子行·借记卡" , @"中国工商银行阿拉木图子行·贷记卡" , @"中国工商银行阿拉木图子行·借记卡" , @"中国工商银行阿拉木图子行·预付卡" , @"中国工商银行万象分行·借记卡" , @"中国工商银行万象分行·贷记卡" , @"中国工商银行卢森堡分行·借记卡" , @"中国工商银行卢森堡分行·贷记卡" , @"中国工商银行澳门分行·E时代卡" , @"中国工商银行澳门分行·E时代卡" , @"中国工商银行澳门分行·E时代卡" , @"中国工商银行澳门分行·理财金账户" , @"中国工商银行澳门分行·理财金账户" , @"中国工商银行澳门分行·理财金账户" , @"中国工商银行澳门分行·预付卡" , @"中国工商银行澳门分行·预付卡" , @"中国工商银行澳门分行·工银闪付预付卡" , @"中国工商银行澳门分行·工银银联公司卡" , @"中国工商银行澳门分行·Diamond" ,@"中国工商银行阿姆斯特丹·借记卡" ,@"中国工商银行卡拉奇分行·借记卡" ,@"中国工商银行卡拉奇分行·贷记卡" ,@"中国工商银行新加坡分行·贷记卡" ,@"中国工商银行新加坡分行·贷记卡" ,@"中国工商银行新加坡分行·借记卡" ,@"中国工商银行新加坡分行·预付卡" ,@"中国工商银行新加坡分行·预付卡" ,@"中国工商银行新加坡分行·借记卡" ,@"中国工商银行新加坡分行·借记卡" ,@"中国工商银行马德里分行·借记卡" ,@"中国工商银行马德里分行·借记卡" ,@"中国工商银行马德里分行·预付卡" ,@"中国工商银行马德里分行·预付卡" ,@"中国工商银行伦敦子行·借记卡" ,@"中国工商银行伦敦子行·工银伦敦借记卡" , @"中国工商银行伦敦子行·借记卡" , @"农业银行·金穗贷记卡" ,@"农业银行·中国旅游卡" ,@"农业银行·普通高中学生资助卡" ,@"农业银行·银联标准卡" ,@"农业银行·金穗贷记卡(银联卡)" , @"农业银行·金穗贷记卡(银联卡)" , @"农业银行·金穗贷记卡(银联卡)" , @"农业银行·金穗贷记卡(银联卡)" , @"农业银行·金穗贷记卡(银联卡)" , @"农业银行·金穗贷记卡(银联卡)" , @"农业银行·VISA白金卡" ,@"农业银行·万事达白金卡" ,@"农业银行·金穗贷记卡(银联卡)" , @"农业银行·金穗贷记卡(银联卡)" , @"农业银行·金穗贷记卡(银联卡)" , @"农业银行·金穗贷记卡(银联卡)" , @"农业银行·金穗贷记卡" ,@"农业银行·中职学生资助卡" ,@"农业银行·专用惠农卡" ,@"农业银行·武警军人保障卡" ,@"农业银行·金穗校园卡(银联卡)" , @"农业银行·金穗星座卡(银联卡)" , @"农业银行·金穗社保卡(银联卡)" , @"农业银行·金穗旅游卡(银联卡)" , @"农业银行·金穗青年卡(银联卡)" , @"农业银行·复合介质金穗通宝卡" , @"农业银行·金穗海通卡" ,@"农业银行·退役金卡" ,@"农业银行·金穗贷记卡" ,@"农业银行·金穗贷记卡" ,@"农业银行·金穗通宝卡(银联卡)" , @"农业银行·金穗惠农卡" ,@"农业银行·金穗通宝银卡" ,@"农业银行·金穗通宝卡(银联卡)" , @"农业银行·金穗通宝卡(银联卡)" , @"农业银行·金穗通宝卡" ,@"农业银行·金穗通宝卡(银联卡)" , @"农业银行·金穗通宝卡(银联卡)" , @"农业银行·金穗通宝钻石卡" ,@"农业银行·掌尚钱包" ,@"农业银行·银联IC卡金卡" , @"农业银行·银联预算单位公务卡金卡" , @"农业银行·银联IC卡白金卡" , @"农业银行·金穗公务卡" ,@"中国农业银行贷记卡·IC普卡" ,@"中国农业银行贷记卡·IC金卡" ,@"中国农业银行贷记卡·澳元卡" ,@"中国农业银行贷记卡·欧元卡" ,@"中国农业银行贷记卡·金穗通商卡" ,@"中国农业银行贷记卡·金穗通商卡" ,@"中国农业银行贷记卡·银联白金卡" ,@"中国农业银行贷记卡·中国旅游卡" ,@"中国农业银行贷记卡·银联IC公务卡" , @"宁波市农业银行·市民卡B卡" , @"中国银行·联名卡" ,@"中国银行·个人普卡" ,@"中国银行·个人金卡" ,@"中国银行·员工普卡" ,@"中国银行·员工金卡" ,@"中国银行·理财普卡" ,@"中国银行·理财金卡" ,@"中国银行·理财银卡" ,@"中国银行·理财白金卡" ,@"中国银行·中行金融IC卡白金卡" , @"中国银行·中行金融IC卡普卡" , @"中国银行·中行金融IC卡金卡" , @"中国银行·中银JCB卡金卡" , @"中国银行·中银JCB卡普卡" , @"中国银行·员工普卡" ,@"中国银行·个人普卡" ,@"中国银行·中银威士信用卡员" ,@"中国银行·中银威士信用卡员" ,@"中国银行·个人白金卡" ,@"中国银行·中银威士信用卡" ,@"中国银行·长城公务卡" ,@"中国银行·长城电子借记卡" ,@"中国银行·中银万事达信用卡" ,@"中国银行·中银万事达信用卡" ,@"中国银行·中银万事达信用卡" ,@"中国银行·中银万事达信用卡" ,@"中国银行·中银万事达信用卡" ,@"中国银行·中银威士信用卡员" ,@"中国银行·长城万事达信用卡" ,@"中国银行·长城万事达信用卡" ,@"中国银行·长城万事达信用卡" ,@"中国银行·长城万事达信用卡" ,@"中国银行·长城万事达信用卡" ,@"中国银行·中银奥运信用卡" ,@"中国银行·长城信用卡" ,@"中国银行·长城信用卡" ,@"中国银行·长城信用卡" ,@"中国银行·长城万事达信用卡" ,@"中国银行·长城公务卡" ,@"中国银行·长城公务卡" ,@"中国银行·中银万事达信用卡" ,@"中国银行·中银万事达信用卡" ,@"中国银行·长城人民币信用卡" ,@"中国银行·长城人民币信用卡" ,@"中国银行·长城人民币信用卡" ,@"中国银行·长城信用卡" ,@"中国银行·长城人民币信用卡" ,@"中国银行·长城人民币信用卡" ,@"中国银行·长城信用卡" ,@"中国银行·银联单币贷记卡" ,@"中国银行·长城信用卡" ,@"中国银行·长城信用卡" ,@"中国银行·长城信用卡" ,@"中国银行·长城电子借记卡" ,@"中国银行·长城人民币信用卡" ,@"中国银行·银联标准公务卡" ,@"中国银行·一卡双账户普卡" ,@"中国银行·财互通卡" ,@"中国银行·电子现金卡" ,@"中国银行·长城人民币信用卡" ,@"中国银行·长城单位信用卡普卡" ,@"中国银行·中银女性主题信用卡" ,@"中国银行·长城单位信用卡金卡" ,@"中国银行·白金卡" ,@"中国银行·中职学生资助卡" ,@"中国银行·银联标准卡" ,@"中国银行·金融IC卡" , @"中国银行·长城社会保障卡" ,@"中国银行·世界卡" ,@"中国银行·社保联名卡" ,@"中国银行·社保联名卡" ,@"中国银行·医保联名卡" ,@"中国银行·医保联名卡" ,@"中国银行·公司借记卡" ,@"中国银行·银联美运顶级卡" ,@"中国银行·长城福农借记卡金卡" ,@"中国银行·长城福农借记卡普卡" ,@"中国银行·中行金融IC卡普卡" , @"中国银行·中行金融IC卡金卡" , @"中国银行·中行金融IC卡白金卡" , @"中国银行·长城银联公务IC卡白金卡" , @"中国银行·中银旅游信用卡" ,@"中国银行·长城银联公务IC卡金卡" , @"中国银行·中国旅游卡" ,@"中国银行·武警军人保障卡" ,@"中国银行·社保联名借记IC卡" , @"中国银行·社保联名借记IC卡" , @"中国银行·医保联名借记IC卡" , @"中国银行·医保联名借记IC卡" , @"中国银行·借记IC个人普卡" , @"中国银行·借记IC个人金卡" , @"中国银行·借记IC个人普卡" , @"中国银行·借记IC白金卡" , @"中国银行·借记IC钻石卡" , @"中国银行·借记IC联名卡" , @"中国银行·普通高中学生资助卡" , @"中国银行·长城环球通港澳台旅游金卡" , @"中国银行·长城环球通港澳台旅游白金卡" , @"中国银行·中银福农信用卡" ,@"中国银行金边分行·借记卡" ,@"中国银行雅加达分行·借记卡" ,@"中国银行首尔分行·借记卡" ,@"中国银行澳门分行·人民币信用卡" ,@"中国银行澳门分行·人民币信用卡" ,@"中国银行澳门分行·中银卡" ,@"中国银行澳门分行·中银卡" ,@"中国银行澳门分行·中银卡" ,@"中国银行澳门分行·中银银联双币商务卡" , @"中国银行澳门分行·预付卡" ,@"中国银行澳门分行·澳门中国银行银联预付卡" , @"中国银行澳门分行·澳门中国银行银联预付卡" , @"中国银行澳门分行·熊猫卡" ,@"中国银行澳门分行·财富卡" ,@"中国银行澳门分行·银联港币卡" ,@"中国银行澳门分行·银联澳门币卡" ,@"中国银行马尼拉分行·双币种借记卡" ,@"中国银行胡志明分行·借记卡" ,@"中国银行曼谷分行·借记卡" ,@"中国银行曼谷分行·长城信用卡环球通" , @"中国银行曼谷分行·借记卡" ,@"建设银行·龙卡准贷记卡" ,@"建设银行·龙卡准贷记卡金卡" ,@"建设银行·中职学生资助卡" ,@"建设银行·乐当家银卡VISA" ,@"建设银行·乐当家金卡VISA" ,@"建设银行·乐当家白金卡" ,@"建设银行·龙卡普通卡VISA" ,@"建设银行·龙卡储蓄卡" ,@"建设银行·VISA准贷记卡(银联卡)" , @"建设银行·VISA准贷记金卡" , @"建设银行·乐当家" ,@"建设银行·乐当家" ,@"建设银行·准贷记金卡" ,@"建设银行·乐当家白金卡" ,@"建设银行·金融复合IC卡" , @"建设银行·银联标准卡" ,@"建设银行·银联理财钻石卡" ,@"建设银行·金融IC卡" , @"建设银行·理财白金卡" ,@"建设银行·社保IC卡" , @"建设银行·财富卡私人银行卡" ,@"建设银行·理财金卡" ,@"建设银行·福农卡" ,@"建设银行·武警军人保障卡" ,@"建设银行·龙卡通" ,@"建设银行·银联储蓄卡" ,@"建设银行·龙卡储蓄卡(银联卡)" , @"建设银行·准贷记卡" ,@"建设银行·理财白金卡" ,@"建设银行·理财金卡" ,@"建设银行·准贷记卡普卡" ,@"建设银行·准贷记卡金卡" ,@"建设银行·龙卡信用卡" ,@"建设银行·建行陆港通龙卡" ,@"中国建设银行·普通高中学生资助卡" ,@"中国建设银行·中国旅游卡" ,@"中国建设银行·龙卡JCB金卡" , @"中国建设银行·龙卡JCB白金卡" , @"中国建设银行·龙卡JCB普卡" , @"中国建设银行·龙卡贷记卡公司卡" , @"中国建设银行·龙卡贷记卡" ,@"中国建设银行·龙卡国际普通卡VISA" , @"中国建设银行·龙卡国际金卡VISA" , @"中国建设银行·VISA白金信用卡" , @"中国建设银行·龙卡国际白金卡" , @"中国建设银行·龙卡国际普通卡MASTER" , @"中国建设银行·龙卡国际金卡MASTER" , @"中国建设银行·龙卡万事达金卡" , @"中国建设银行·龙卡贷记卡" ,@"中国建设银行·龙卡万事达白金卡" ,@"中国建设银行·龙卡贷记卡" ,@"中国建设银行·龙卡万事达信用卡" ,@"中国建设银行·龙卡人民币信用卡" ,@"中国建设银行·龙卡人民币信用金卡" ,@"中国建设银行·龙卡人民币白金卡" ,@"中国建设银行·龙卡IC信用卡普卡" , @"中国建设银行·龙卡IC信用卡金卡" , @"中国建设银行·龙卡IC信用卡白金卡" , @"中国建设银行·龙卡银联公务卡普卡" , @"中国建设银行·龙卡银联公务卡金卡" , @"中国建设银行·中国旅游卡" ,@"中国建设银行·中国旅游卡" ,@"中国建设银行·龙卡IC公务卡" , @"中国建设银行·龙卡IC公务卡" , @"交通银行·交行预付卡" ,@"交通银行·世博预付IC卡" , @"交通银行·太平洋互连卡" ,@"交通银行·太平洋万事顺卡" ,@"交通银行·太平洋互连卡(银联卡)" , @"交通银行·太平洋白金信用卡" ,@"交通银行·太平洋双币贷记卡" ,@"交通银行·太平洋双币贷记卡" ,@"交通银行·太平洋双币贷记卡" ,@"交通银行·太平洋白金信用卡" ,@"交通银行·太平洋双币贷记卡" ,@"交通银行·太平洋万事顺卡" ,@"交通银行·太平洋人民币贷记卡" ,@"交通银行·太平洋人民币贷记卡" ,@"交通银行·太平洋双币贷记卡" ,@"交通银行·太平洋准贷记卡" ,@"交通银行·太平洋准贷记卡" ,@"交通银行·太平洋准贷记卡" ,@"交通银行·太平洋准贷记卡" ,@"交通银行·太平洋借记卡" ,@"交通银行·太平洋借记卡" ,@"交通银行·太平洋人民币贷记卡" ,@"交通银行·太平洋借记卡" ,@"交通银行·太平洋MORE卡" , @"交通银行·白金卡" ,@"交通银行·交通银行公务卡普卡" ,@"交通银行·太平洋人民币贷记卡" ,@"交通银行·太平洋互连卡" ,@"交通银行·太平洋借记卡" ,@"交通银行·太平洋万事顺卡" ,@"交通银行·太平洋贷记卡(银联卡)" , @"交通银行·太平洋贷记卡(银联卡)" , @"交通银行·太平洋贷记卡(银联卡)" , @"交通银行·太平洋贷记卡(银联卡)" , @"交通银行·交通银行公务卡金卡" , @"交通银行·交银IC卡" , @"交通银行香港分行·交通银行港币借记卡" , @"交通银行香港分行·港币礼物卡" , @"交通银行香港分行·双币种信用卡" , @"交通银行香港分行·双币种信用卡" , @"交通银行香港分行·双币卡" ,@"交通银行香港分行·银联人民币卡" ,@"交通银行澳门分行·银联借记卡" ,@"中信银行·中信借记卡" ,@"中信银行·中信借记卡" ,@"中信银行·中信国际借记卡" ,@"中信银行·中信国际借记卡" ,@"中信银行·中国旅行卡" ,@"中信银行·中信借记卡(银联卡)" , @"中信银行·中信借记卡(银联卡)" , @"中信银行·中信贵宾卡(银联卡)" , @"中信银行·中信理财宝金卡" ,@"中信银行·中信理财宝白金卡" ,@"中信银行·中信钻石卡" ,@"中信银行·中信钻石卡" ,@"中信银行·中信借记卡" ,@"中信银行·中信理财宝(银联卡)" , @"中信银行·中信理财宝(银联卡)" , @"中信银行·中信理财宝(银联卡)" , @"中信银行·借记卡" ,@"中信银行·理财宝IC卡" , @"中信银行·理财宝IC卡" , @"中信银行·理财宝IC卡" , @"中信银行·理财宝IC卡" , @"中信银行·理财宝IC卡" , @"中信银行·主账户复合电子现金卡" , @"光大银行·阳光商旅信用卡" ,@"光大银行·阳光商旅信用卡" ,@"光大银行·阳光商旅信用卡" ,@"光大银行·阳光卡(银联卡)" , @"光大银行·阳光卡(银联卡)" , @"光大银行·阳光卡(银联卡)" , @"光大银行·阳光卡(银联卡)" , @"光大银行·阳光卡(银联卡)" , @"光大银行·阳光卡(银联卡)" , @"光大银行·阳光卡(银联卡)" , @"光大银行·阳光卡(银联卡)" , @"光大银行·阳光卡(银联卡)" , @"光大银行·阳光卡(银联卡)" , @"光大银行·阳光卡(银联卡)" , @"光大银行·阳光卡(银联卡)" , @"光大银行·阳光卡(银联卡)" , @"光大银行·阳光卡(银联卡)" , @"光大银行·阳光卡(银联卡)" , @"光大银行·借记卡普卡" ,@"光大银行·社会保障IC卡" , @"光大银行·IC借记卡普卡" ,@"光大银行·手机支付卡" ,@"光大银行·联名IC卡普卡" , @"光大银行·借记IC卡白金卡" , @"光大银行·借记IC卡金卡" , @"光大银行·阳光旅行卡" ,@"光大银行·借记IC卡钻石卡" , @"光大银行·联名IC卡金卡" , @"光大银行·联名IC卡白金卡" , @"光大银行·联名IC卡钻石卡" , @"华夏银行·华夏卡(银联卡)" , @"华夏银行·华夏白金卡" ,@"华夏银行·华夏普卡" ,@"华夏银行·华夏金卡" ,@"华夏银行·华夏白金卡" ,@"华夏银行·华夏钻石卡" ,@"华夏银行·华夏卡(银联卡)" , @"华夏银行·华夏至尊金卡(银联卡)" , @"华夏银行·华夏丽人卡(银联卡)" , @"华夏银行·华夏万通卡" ,@"民生银行·民生借记卡(银联卡)" , @"民生银行·民生银联借记卡－金卡" , @"民生银行·钻石卡" ,@"民生银行·民生借记卡(银联卡)" , @"民生银行·民生借记卡(银联卡)" , @"民生银行·民生借记卡(银联卡)" , @"民生银行·民生借记卡" ,@"民生银行·民生国际卡" ,@"民生银行·民生国际卡(银卡)" , @"民生银行·民生国际卡(欧元卡)" , @"民生银行·民生国际卡(澳元卡)" , @"民生银行·民生国际卡" ,@"民生银行·民生国际卡" ,@"民生银行·薪资理财卡" ,@"民生银行·借记卡普卡" ,@"民生银行·民生MasterCard" , @"民生银行·民生MasterCard" , @"民生银行·民生MasterCard" , @"民生银行·民生MasterCard" , @"民生银行·民生JCB信用卡" , @"民生银行·民生JCB金卡" , @"民生银行·民生贷记卡(银联卡)" , @"民生银行·民生贷记卡(银联卡)" , @"民生银行·民生贷记卡(银联卡)" , @"民生银行·民生贷记卡(银联卡)" , @"民生银行·民生贷记卡(银联卡)" , @"民生银行·民生JCB普卡" , @"民生银行·民生贷记卡(银联卡)" , @"民生银行·民生贷记卡(银联卡)" , @"民生银行·民生信用卡(银联卡)" , @"民生银行·民生信用卡(银联卡)" , @"民生银行·民生银联白金信用卡" , @"民生银行·民生贷记卡(银联卡)" , @"民生银行·民生银联个人白金卡" , @"民生银行·公务卡金卡" ,@"民生银行·民生贷记卡(银联卡)" , @"民生银行·民生银联商务信用卡" , @"民生银行·民VISA无限卡" , @"民生银行·民生VISA商务白金卡" , @"民生银行·民生万事达钛金卡" ,@"民生银行·民生万事达世界卡" ,@"民生银行·民生万事达白金公务卡" ,@"民生银行·民生JCB白金卡" , @"民生银行·银联标准金卡" ,@"民生银行·银联芯片普卡" ,@"民生银行·民生运通双币信用卡普卡" ,@"民生银行·民生运通双币信用卡金卡" ,@"民生银行·民生运通双币信用卡钻石卡" , @"民生银行·民生运通双币标准信用卡白金卡" , @"民生银行·银联芯片金卡" ,@"民生银行·银联芯片白金卡" ,@"招商银行·招商银行信用卡" ,@"招商银行·招商银行信用卡" ,@"招商银行·招商银行信用卡" ,@"招商银行·招商银行信用卡" ,@"招商银行·招商银行信用卡" ,@"招商银行·两地一卡通" ,@"招商银行·招行国际卡(银联卡)" , @"招商银行·招商银行信用卡" ,@"招商银行·VISA商务信用卡" ,@"招商银行·招行国际卡(银联卡)" , @"招商银行·招商银行信用卡" ,@"招商银行·招商银行信用卡" ,@"招商银行·招行国际卡(银联卡)" , @"招商银行·世纪金花联名信用卡" , @"招商银行·招行国际卡(银联卡)" , @"招商银行·招商银行信用卡" ,@"招商银行·万事达信用卡" ,@"招商银行·万事达信用卡" ,@"招商银行·万事达信用卡" ,@"招商银行·万事达信用卡" ,@"招商银行·招商银行信用卡" ,@"招商银行·招商银行信用卡" ,@"招商银行·招商银行信用卡" ,@"招商银行·招商银行信用卡" ,@"招商银行·招商银行信用卡" ,@"招商银行·招商银行信用卡" ,@"招商银行·一卡通(银联卡)" , @"招商银行·万事达信用卡" ,@"招商银行·招商银行信用卡" ,@"招商银行·招商银行信用卡" ,@"招商银行·一卡通(银联卡)" , @"招商银行·公司卡(银联卡)" , @"招商银行·金卡" ,@"招商银行·招行一卡通" ,@"招商银行·招行一卡通" ,@"招商银行·万事达信用卡" ,@"招商银行·金葵花卡" ,@"招商银行·电子现金卡" ,@"招商银行·银联IC普卡" , @"招商银行·银联IC金卡" , @"招商银行·银联金葵花IC卡" , @"招商银行·IC公务卡" ,@"招商银行·招商银行信用卡" ,@"招商银行信用卡中心·美国运通绿卡" ,@"招商银行信用卡中心·美国运通金卡" ,@"招商银行信用卡中心·美国运通商务绿卡" , @"招商银行信用卡中心·美国运通商务金卡" , @"招商银行信用卡中心·VISA信用卡" , @"招商银行信用卡中心·MASTER信用卡" , @"招商银行信用卡中心·MASTER信用金卡" , @"招商银行信用卡中心·银联标准公务卡(金卡)" , @"招商银行信用卡中心·VISA信用卡" , @"招商银行信用卡中心·银联标准财政公务卡" , @"招商银行信用卡中心·芯片IC信用卡" , @"招商银行信用卡中心·芯片IC信用卡" , @"招商银行香港分行·香港一卡通" , @"兴业银行·兴业卡(银联卡)" , @"兴业银行·兴业卡(银联标准卡)" , @"兴业银行·兴业自然人生理财卡" , @"兴业银行·兴业智能卡(银联卡)" , @"兴业银行·兴业智能卡" ,@"兴业银行·visa标准双币个人普卡" , @"兴业银行·VISA商务普卡" ,@"兴业银行·VISA商务金卡" ,@"兴业银行·VISA运动白金信用卡" ,@"兴业银行·万事达信用卡(银联卡)" , @"兴业银行·VISA信用卡(银联卡)" , @"兴业银行·加菲猫信用卡" ,@"兴业银行·个人白金卡" ,@"兴业银行·银联信用卡(银联卡)" , @"兴业银行·银联信用卡(银联卡)" , @"兴业银行·银联白金信用卡" ,@"兴业银行·银联标准公务卡" ,@"兴业银行·VISA信用卡(银联卡)" , @"兴业银行·万事达信用卡(银联卡)" , @"兴业银行·银联标准贷记普卡" ,@"兴业银行·银联标准贷记金卡" ,@"兴业银行·银联标准贷记金卡" ,@"兴业银行·银联标准贷记金卡" ,@"兴业银行·兴业信用卡" ,@"兴业银行·兴业信用卡" ,@"兴业银行·兴业信用卡" ,@"兴业银行·银联标准贷记普卡" ,@"兴业银行·银联标准贷记普卡" ,@"兴业银行·兴业芯片普卡" ,@"兴业银行·兴业芯片金卡" ,@"兴业银行·兴业芯片白金卡" ,@"兴业银行·兴业芯片钻石卡" ,@"浦东发展银行·浦发JCB金卡" , @"浦东发展银行·浦发JCB白金卡" , @"浦东发展银行·信用卡VISA普通" , @"浦东发展银行·信用卡VISA金卡" , @"浦东发展银行·浦发银行VISA年青卡" , @"浦东发展银行·VISA白金信用卡" , @"浦东发展银行·浦发万事达白金卡" , @"浦东发展银行·浦发JCB普卡" , @"浦东发展银行·浦发万事达金卡" , @"浦东发展银行·浦发万事达普卡" , @"浦东发展银行·浦发单币卡" ,@"浦东发展银行·浦发银联单币麦兜普卡" , @"浦东发展银行·东方轻松理财卡" , @"浦东发展银行·东方-轻松理财卡普卡" , @"浦东发展银行·东方轻松理财卡" , @"浦东发展银行·东方轻松理财智业金卡" , @"浦东发展银行·东方卡(银联卡)" , @"浦东发展银行·东方卡(银联卡)" , @"浦东发展银行·东方卡(银联卡)" , @"浦东发展银行·公务卡金卡" ,@"浦东发展银行·公务卡普卡" ,@"浦东发展银行·东方卡" ,@"浦东发展银行·东方卡" ,@"浦东发展银行·浦发单币卡" ,@"浦东发展银行·浦发联名信用卡" ,@"浦东发展银行·浦发银联白金卡" ,@"浦东发展银行·轻松理财普卡" ,@"浦东发展银行·移动联名卡" ,@"浦东发展银行·轻松理财消贷易卡" ,@"浦东发展银行·轻松理财普卡（复合卡）" , @"浦东发展银行·贷记卡" ,@"浦东发展银行·贷记卡" ,@"浦东发展银行·东方借记卡（复合卡）" , @"浦东发展银行·电子现金卡（IC卡）" , @"浦东发展银行·移动浦发联名卡" , @"浦东发展银行·东方-标准准贷记卡" , @"浦东发展银行·轻松理财金卡（复合卡）" , @"浦东发展银行·轻松理财白金卡（复合卡）" , @"浦东发展银行·轻松理财钻石卡（复合卡）" , @"浦东发展银行·东方卡" ,@"恒丰银行·九州IC卡" , @"恒丰银行·九州借记卡(银联卡)" , @"恒丰银行·九州借记卡(银联卡)" , @"天津市商业银行·银联卡(银联卡)" , @"烟台商业银行·金通卡" ,@"潍坊银行·鸢都卡(银联卡)" , @"潍坊银行·鸳都卡(银联卡)" , @"临沂商业银行·沂蒙卡(银联卡)" , @"临沂商业银行·沂蒙卡(银联卡)" , @"日照市商业银行·黄海卡" ,@"日照市商业银行·黄海卡(银联卡)" , @"浙商银行·商卡" ,@"浙商银行·商卡" ,@"渤海银行·浩瀚金卡" ,@"渤海银行·渤海银行借记卡" ,@"渤海银行·金融IC卡" , @"渤海银行·渤海银行公司借记卡" , @"星展银行·星展银行借记卡" ,@"星展银行·星展银行借记卡" ,@"恒生银行·恒生通财卡" ,@"恒生银行·恒生优越通财卡" ,@"新韩银行·新韩卡" ,@"上海银行·慧通钻石卡" ,@"上海银行·慧通金卡" ,@"上海银行·私人银行卡" ,@"上海银行·综合保险卡" ,@"上海银行·申卡社保副卡(有折)" , @"上海银行·申卡社保副卡(无折)" , @"上海银行·白金IC借记卡" , @"上海银行·慧通白金卡(配折)" , @"上海银行·慧通白金卡(不配折)" , @"上海银行·申卡(银联卡)" , @"上海银行·申卡借记卡" ,@"上海银行·银联申卡(银联卡)" , @"上海银行·单位借记卡" ,@"上海银行·首发纪念版IC卡" , @"上海银行·申卡贷记卡" ,@"上海银行·申卡贷记卡" ,@"上海银行·J分期付款信用卡" ,@"上海银行·申卡贷记卡" ,@"上海银行·申卡贷记卡" ,@"上海银行·上海申卡IC" ,@"上海银行·申卡贷记卡" ,@"上海银行·申卡贷记卡普通卡" ,@"上海银行·申卡贷记卡金卡" ,@"上海银行·万事达白金卡" ,@"上海银行·万事达星运卡" ,@"上海银行·申卡贷记卡金卡" ,@"上海银行·申卡贷记卡普通卡" ,@"上海银行·安融卡" ,@"上海银行·分期付款信用卡" ,@"上海银行·信用卡" ,@"上海银行·个人公务卡" ,@"上海银行·安融卡" ,@"上海银行·上海银行银联白金卡" ,@"上海银行·贷记IC卡" , @"上海银行·中国旅游卡（IC普卡）" , @"上海银行·中国旅游卡（IC金卡）" , @"上海银行·中国旅游卡（IC白金卡）" , @"上海银行·万事达钻石卡" ,@"上海银行·淘宝IC普卡" , @"北京银行·京卡借记卡" ,@"北京银行·京卡(银联卡)" , @"北京银行·京卡借记卡" ,@"北京银行·京卡" ,@"北京银行·京卡" ,@"北京银行·借记IC卡" , @"北京银行·京卡贵宾金卡" ,@"北京银行·京卡贵宾白金卡" ,@"吉林银行·君子兰一卡通(银联卡)" , @"吉林银行·君子兰卡(银联卡)" , @"吉林银行·长白山金融IC卡" , @"吉林银行·信用卡" ,@"吉林银行·信用卡" ,@"吉林银行·公务卡" ,@"镇江市商业银行·金山灵通卡(银联卡)" , @"镇江市商业银行·金山灵通卡(银联卡)" , @"宁波银行·银联标准卡" ,@"宁波银行·汇通借记卡" ,@"宁波银行·汇通卡(银联卡)" , @"宁波银行·明州卡" ,@"宁波银行·汇通借记卡" ,@"宁波银行·汇通国际卡银联双币卡" ,@"宁波银行·汇通国际卡银联双币卡" ,@"平安银行·新磁条借记卡" ,@"平安银行·平安银行IC借记卡" , @"平安银行·万事顺卡" ,@"平安银行·平安银行借记卡" ,@"平安银行·平安银行借记卡" ,@"平安银行·万事顺借记卡" ,@"焦作市商业银行·月季借记卡(银联卡)" , @"焦作市商业银行·月季城市通(银联卡)" , @"焦作市商业银行·中国旅游卡" ,@"温州银行·金鹿卡" ,@"汉口银行·九通卡(银联卡)" , @"汉口银行·九通卡" ,@"汉口银行·借记卡" ,@"汉口银行·借记卡" ,@"盛京银行·玫瑰卡" ,@"盛京银行·玫瑰IC卡" , @"盛京银行·玫瑰IC卡" , @"盛京银行·玫瑰卡" ,@"盛京银行·玫瑰卡" ,@"盛京银行·玫瑰卡(银联卡)" , @"盛京银行·玫瑰卡(银联卡)" , @"盛京银行·盛京银行公务卡" ,@"洛阳银行·都市一卡通(银联卡)" , @"洛阳银行·都市一卡通(银联卡)" , @"洛阳银行·--" ,@"大连银行·北方明珠卡" ,@"大连银行·人民币借记卡" ,@"大连银行·金融IC借记卡" , @"大连银行·大连市社会保障卡" ,@"大连银行·借记IC卡" , @"大连银行·借记IC卡" , @"大连银行·大连市商业银行贷记卡" , @"大连银行·大连市商业银行贷记卡" , @"大连银行·银联标准公务卡" ,@"苏州市商业银行·姑苏卡" ,@"杭州商业银行·西湖卡" ,@"杭州商业银行·西湖卡" ,@"杭州商业银行·借记IC卡" , @"杭州商业银行·" ,@"南京银行·梅花信用卡公务卡" ,@"南京银行·梅花信用卡商务卡" ,@"南京银行·梅花贷记卡(银联卡)" , @"南京银行·梅花借记卡(银联卡)" , @"南京银行·白金卡" ,@"南京银行·商务卡" ,@"东莞市商业银行·万顺通卡(银联卡)" , @"东莞市商业银行·万顺通卡(银联卡)" , @"东莞市商业银行·万顺通借记卡" , @"东莞市商业银行·社会保障卡" ,@"乌鲁木齐市商业银行·雪莲借记IC卡" , @"乌鲁木齐市商业银行·乌鲁木齐市公务卡" , @"乌鲁木齐市商业银行·福农卡贷记卡" , @"乌鲁木齐市商业银行·福农卡准贷记卡" , @"乌鲁木齐市商业银行·雪莲准贷记卡" , @"乌鲁木齐市商业银行·雪莲贷记卡(银联卡)" , @"乌鲁木齐市商业银行·雪莲借记IC卡" , @"乌鲁木齐市商业银行·雪莲借记卡(银联卡)" , @"乌鲁木齐市商业银行·雪莲卡(银联卡)" , @"绍兴银行·兰花IC借记卡" , @"绍兴银行·社保IC借记卡" , @"绍兴银行·兰花公务卡" ,@"成都商业银行·芙蓉锦程福农卡" ,@"成都商业银行·芙蓉锦程天府通卡" ,@"成都商业银行·锦程卡(银联卡)" , @"成都商业银行·锦程卡金卡" ,@"成都商业银行·锦程卡定活一卡通金卡" , @"成都商业银行·锦程卡定活一卡通" , @"成都商业银行·锦程力诚联名卡" , @"成都商业银行·锦程力诚联名卡" , @"成都商业银行·锦程卡(银联卡)" , @"抚顺银行·借记IC卡" , @"临商银行·借记卡" ,@"宜昌市商业银行·三峡卡(银联卡)" , @"宜昌市商业银行·信用卡(银联卡)" , @"葫芦岛市商业银行·一通卡" ,@"葫芦岛市商业银行·一卡通(银联卡)" , @"天津市商业银行·津卡" ,@"天津市商业银行·津卡贷记卡(银联卡)" , @"天津市商业银行·贷记IC卡" , @"天津市商业银行·--" ,@"天津银行·商务卡" ,@"宁夏银行·宁夏银行公务卡" ,@"宁夏银行·宁夏银行福农贷记卡" ,@"宁夏银行·如意卡(银联卡)" , @"宁夏银行·宁夏银行福农借记卡" , @"宁夏银行·如意借记卡" ,@"宁夏银行·如意IC卡" , @"宁夏银行·宁夏银行如意借记卡" , @"宁夏银行·中国旅游卡" ,@"齐商银行·金达卡(银联卡)" , @"齐商银行·金达借记卡(银联卡)" , @"齐商银行·金达IC卡" , @"徽商银行·黄山卡" ,@"徽商银行·黄山卡" ,@"徽商银行·借记卡" ,@"徽商银行·徽商银行中国旅游卡（安徽）" , @"徽商银行合肥分行·黄山卡" ,@"徽商银行芜湖分行·黄山卡(银联卡)" , @"徽商银行马鞍山分行·黄山卡(银联卡)" , @"徽商银行淮北分行·黄山卡(银联卡)" , @"徽商银行安庆分行·黄山卡(银联卡)" , @"重庆银行·长江卡(银联卡)" , @"重庆银行·长江卡(银联卡)" , @"重庆银行·长江卡" ,@"重庆银行·借记IC卡" , @"哈尔滨银行·丁香一卡通(银联卡)" , @"哈尔滨银行·丁香借记卡(银联卡)" , @"哈尔滨银行·丁香卡" ,@"哈尔滨银行·福农借记卡" ,@"无锡市商业银行·太湖金保卡(银联卡)" , @"丹东银行·借记IC卡" , @"丹东银行·丹东银行公务卡" ,@"兰州银行·敦煌卡" ,@"南昌银行·金瑞卡(银联卡)" , @"南昌银行·南昌银行借记卡" ,@"南昌银行·金瑞卡" ,@"晋商银行·晋龙一卡通" ,@"晋商银行·晋龙一卡通" ,@"晋商银行·晋龙卡(银联卡)" , @"青岛银行·金桥通卡" ,@"青岛银行·金桥卡(银联卡)" , @"青岛银行·金桥卡(银联卡)" , @"青岛银行·金桥卡" ,@"青岛银行·借记IC卡" , @"吉林银行·雾凇卡(银联卡)" , @"吉林银行·雾凇卡(银联卡)" , @"南通商业银行·金桥卡(银联卡)" , @"南通商业银行·金桥卡(银联卡)" , @"日照银行·黄海卡、财富卡借记卡" , @"鞍山银行·千山卡(银联卡)" , @"鞍山银行·千山卡(银联卡)" , @"鞍山银行·千山卡" ,@"青海银行·三江银行卡(银联卡)" , @"青海银行·三江卡" ,@"台州银行·大唐贷记卡" ,@"台州银行·大唐准贷记卡" ,@"台州银行·大唐卡(银联卡)" , @"台州银行·大唐卡" ,@"台州银行·借记卡" ,@"台州银行·公务卡" ,@"泉州银行·海峡银联卡(银联卡)" , @"泉州银行·海峡储蓄卡" ,@"泉州银行·海峡银联卡(银联卡)" , @"泉州银行·海峡卡" ,@"泉州银行·公务卡" ,@"昆明商业银行·春城卡(银联卡)" , @"昆明商业银行·春城卡(银联卡)" , @"昆明商业银行·富滇IC卡（复合卡）" , @"阜新银行·借记IC卡" , @"嘉兴银行·南湖借记卡(银联卡)" , @"廊坊银行·白金卡" ,@"廊坊银行·金卡" ,@"廊坊银行·银星卡(银联卡)" , @"廊坊银行·龙凤呈祥卡" ,@"内蒙古银行·百灵卡(银联卡)" , @"内蒙古银行·成吉思汗卡" ,@"湖州市商业银行·百合卡" ,@"湖州市商业银行·" ,@"沧州银行·狮城卡" ,@"南宁市商业银行·桂花卡(银联卡)" , @"包商银行·雄鹰卡(银联卡)" , @"包商银行·包头市商业银行借记卡" , @"包商银行·雄鹰贷记卡" ,@"包商银行·包商银行内蒙古自治区公务卡" , @"包商银行·贷记卡" ,@"包商银行·借记卡" ,@"连云港市商业银行·金猴神通借记卡" ,@"威海商业银行·通达卡(银联卡)" , @"威海市商业银行·通达借记IC卡" , @"攀枝花市商业银行·攀枝花卡(银联卡)" , @"攀枝花市商业银行·攀枝花卡" ,@"绵阳市商业银行·科技城卡(银联卡)" , @"泸州市商业银行·酒城卡(银联卡)" , @"泸州市商业银行·酒城IC卡" , @"大同市商业银行·云冈卡(银联卡)" , @"三门峡银行·天鹅卡(银联卡)" , @"广东南粤银行·南珠卡(银联卡)" , @"张家口市商业银行·好运IC借记卡" , @"桂林市商业银行·漓江卡(银联卡)" , @"龙江银行·福农借记卡" ,@"龙江银行·联名借记卡" ,@"龙江银行·福农借记卡" ,@"龙江银行·龙江IC卡" , @"龙江银行·社会保障卡" ,@"龙江银行·--" ,@"江苏长江商业银行·长江卡" ,@"徐州市商业银行·彭城借记卡(银联卡)" , @"南充市商业银行·借记IC卡" , @"南充市商业银行·熊猫团团卡" ,@"莱商银行·银联标准卡" ,@"莱芜银行·金凤卡" ,@"莱商银行·借记IC卡" , @"德阳银行·锦程卡定活一卡通" ,@"德阳银行·锦程卡定活一卡通金卡" ,@"德阳银行·锦程卡定活一卡通" ,@"唐山市商业银行·唐山市城通卡" ,@"曲靖市商业银行·珠江源卡" ,@"曲靖市商业银行·珠江源IC卡" , @"温州银行·金鹿信用卡" ,@"温州银行·金鹿信用卡" ,@"温州银行·金鹿公务卡" ,@"温州银行·贷记IC卡" , @"汉口银行·汉口银行贷记卡" ,@"汉口银行·汉口银行贷记卡" ,@"汉口银行·九通香港旅游贷记普卡" ,@"汉口银行·九通香港旅游贷记金卡" ,@"汉口银行·贷记卡" ,@"汉口银行·九通公务卡" ,@"江苏银行·聚宝借记卡" ,@"江苏银行·月季卡" ,@"江苏银行·紫金卡" ,@"江苏银行·绿扬卡(银联卡)" , @"江苏银行·月季卡(银联卡)" , @"江苏银行·九州借记卡(银联卡)" , @"江苏银行·月季卡(银联卡)" , @"江苏银行·聚宝惠民福农卡" ,@"江苏银行·江苏银行聚宝IC借记卡" , @"江苏银行·聚宝IC借记卡VIP卡" , @"长治市商业银行·长治商行银联晋龙卡" , @"承德市商业银行·热河卡" ,@"承德银行·借记IC卡" , @"德州银行·长河借记卡" ,@"德州银行·--" ,@"遵义市商业银行·社保卡" ,@"遵义市商业银行·尊卡" ,@"邯郸市商业银行·邯银卡" ,@"邯郸市商业银行·邯郸银行贵宾IC借记卡" , @"安顺市商业银行·黄果树福农卡" , @"安顺市商业银行·黄果树借记卡" , @"江苏银行·紫金信用卡(公务卡)" , @"江苏银行·紫金信用卡" ,@"江苏银行·天翼联名信用卡" ,@"平凉市商业银行·广成卡" ,@"玉溪市商业银行·红塔卡" ,@"玉溪市商业银行·红塔卡" ,@"浙江民泰商业银行·金融IC卡" , @"浙江民泰商业银行·民泰借记卡" , @"浙江民泰商业银行·金融IC卡C卡" , @"浙江民泰商业银行·银联标准普卡金卡" , @"浙江民泰商业银行·商惠通" ,@"上饶市商业银行·三清山卡" ,@"东营银行·胜利卡" ,@"泰安市商业银行·岱宗卡" ,@"泰安市商业银行·市民一卡通" ,@"浙江稠州商业银行·义卡" ,@"浙江稠州商业银行·义卡借记IC卡" , @"浙江稠州商业银行·公务卡" ,@"自贡市商业银行·借记IC卡" , @"自贡市商业银行·锦程卡" ,@"鄂尔多斯银行·天骄公务卡" ,@"鹤壁银行·鹤卡" ,@"许昌银行·连城卡" ,@"铁岭银行·龙凤卡" ,@"乐山市商业银行·大福卡" ,@"乐山市商业银行·--" ,@"长安银行·长长卡" ,@"长安银行·借记IC卡" , @"重庆三峡银行·财富人生卡" ,@"重庆三峡银行·借记卡" ,@"石嘴山银行·麒麟借记卡" ,@"石嘴山银行·麒麟借记卡" ,@"石嘴山银行·麒麟公务卡" ,@"盘锦市商业银行·鹤卡" ,@"盘锦市商业银行·盘锦市商业银行鹤卡" , @"平顶山银行·平顶山银行公务卡" , @"朝阳银行·鑫鑫通卡" ,@"朝阳银行·朝阳银行福农卡" ,@"朝阳银行·红山卡" ,@"宁波东海银行·绿叶卡" ,@"遂宁市商业银行·锦程卡" ,@"遂宁是商业银行·金荷卡" ,@"保定银行·直隶卡" ,@"保定银行·直隶卡" ,@"凉山州商业银行·锦程卡" ,@"凉山州商业银行·金凉山卡" ,@"漯河银行·福卡" ,@"漯河银行·福源卡" ,@"漯河银行·福源公务卡" ,@"达州市商业银行·锦程卡" ,@"新乡市商业银行·新卡" ,@"晋中银行·九州方圆借记卡" ,@"晋中银行·九州方圆卡" ,@"驻马店银行·驿站卡" ,@"驻马店银行·驿站卡" ,@"驻马店银行·公务卡" ,@"衡水银行·金鼎卡" ,@"衡水银行·借记IC卡" , @"周口银行·如愿卡" ,@"周口银行·公务卡" ,@"阳泉市商业银行·金鼎卡" ,@"阳泉市商业银行·金鼎卡" ,@"宜宾市商业银行·锦程卡" ,@"宜宾市商业银行·借记IC卡" , @"库尔勒市商业银行·孔雀胡杨卡" , @"雅安市商业银行·锦城卡" ,@"雅安市商业银行·--" ,@"安阳银行·安鼎卡" ,@"信阳银行·信阳卡" ,@"信阳银行·公务卡" ,@"信阳银行·信阳卡" ,@"华融湘江银行·华融卡" ,@"华融湘江银行·华融卡" ,@"营口沿海银行·祥云借记卡" ,@"景德镇商业银行·瓷都卡" ,@"哈密市商业银行·瓜香借记卡" ,@"湖北银行·金牛卡" ,@"湖北银行·汉江卡" ,@"湖北银行·借记卡" ,@"湖北银行·三峡卡" ,@"湖北银行·至尊卡" ,@"湖北银行·金融IC卡" , @"西藏银行·借记IC卡" , @"新疆汇和银行·汇和卡" ,@"广东华兴银行·借记卡" ,@"广东华兴银行·华兴银联公司卡" ,@"广东华兴银行·华兴联名IC卡" , @"广东华兴银行·华兴金融IC借记卡" , @"濮阳银行·龙翔卡" ,@"宁波通商银行·借记卡" ,@"甘肃银行·神舟兴陇借记卡" ,@"甘肃银行·甘肃银行神州兴陇IC卡" , @"枣庄银行·借记IC卡" , @"本溪市商业银行·借记卡" ,@"盛京银行·医保卡" ,@"上海农商银行·如意卡(银联卡)" , @"上海农商银行·如意卡(银联卡)" , @"上海农商银行·鑫通卡" ,@"上海农商银行·国际如意卡" ,@"上海农商银行·借记IC卡" , @"常熟市农村商业银行·粒金贷记卡(银联卡)" , @"常熟市农村商业银行·公务卡" ,@"常熟市农村商业银行·粒金准贷卡" ,@"常熟农村商业银行·粒金借记卡(银联卡)" , @"常熟农村商业银行·粒金IC卡" , @"常熟农村商业银行·粒金卡" ,@"深圳农村商业银行·信通卡(银联卡)" , @"深圳农村商业银行·信通商务卡(银联卡)" , @"深圳农村商业银行·信通卡" ,@"深圳农村商业银行·信通商务卡" ,@"广州农村商业银行·福农太阳卡" ,@"广东南海农村商业银行·盛通卡" ,@"广东南海农村商业银行·盛通卡(银联卡)" , @"佛山顺德农村商业银行·恒通卡(银联卡)" , @"佛山顺德农村商业银行·恒通卡" , @"佛山顺德农村商业银行·恒通卡(银联卡)" , @"江阴农村商业银行·暨阳公务卡" , @"江阴市农村商业银行·合作贷记卡(银联卡)" , @"江阴农村商业银行·合作借记卡" , @"江阴农村商业银行·合作卡(银联卡)" , @"江阴农村商业银行·暨阳卡" ,@"重庆农村商业银行·江渝借记卡VIP卡" , @"重庆农村商业银行·江渝IC借记卡" , @"重庆农村商业银行·江渝乡情福农卡" , @"东莞农村商业银行·信通卡(银联卡)" , @"东莞农村商业银行·信通卡(银联卡)" , @"东莞农村商业银行·信通信用卡" , @"东莞农村商业银行·信通借记卡" , @"东莞农村商业银行·贷记IC卡" , @"张家港农村商业银行·一卡通(银联卡)" , @"张家港农村商业银行·一卡通(银联卡)" , @"张家港农村商业银行·" ,@"北京农村商业银行·信通卡" ,@"北京农村商业银行·惠通卡" ,@"北京农村商业银行·凤凰福农卡" ,@"北京农村商业银行·惠通卡" ,@"北京农村商业银行·中国旅行卡" ,@"北京农村商业银行·凤凰卡" ,@"天津农村商业银行·吉祥商联IC卡" , @"天津农村商业银行·信通借记卡(银联卡)" , @"天津农村商业银行·借记IC卡",
                          @"鄞州农村合作银行·蜜蜂借记卡(银联卡)" , @"宁波鄞州农村合作银行·蜜蜂电子钱包(IC)" , @"宁波鄞州农村合作银行·蜜蜂IC借记卡" , @"宁波鄞州农村合作银行·蜜蜂贷记IC卡" , @"宁波鄞州农村合作银行·蜜蜂贷记卡",
                          @"宁波鄞州农村合作银行·公务卡" ,@"成都农村商业银行·福农卡" ,@"成都农村商业银行·福农卡" ,@"珠海农村商业银行·信通卡(银联卡)" , @"太仓农村商业银行·郑和卡(银联卡)" , @"太仓农村商业银行·郑和IC借记卡" , @"无锡农村商业银行·金阿福" ,@"无锡农村商业银行·借记IC卡" , @"黄河农村商业银行·黄河卡" ,@"黄河农村商业银行·黄河富农卡福农卡" , @"黄河农村商业银行·借记IC卡" , @"天津滨海农村商业银行·四海通卡",
                          @"天津滨海农村商业银行·四海通e芯卡" , @"武汉农村商业银行·汉卡" ,@"武汉农村商业银行·汉卡" ,@"武汉农村商业银行·中国旅游卡" ,@"江南农村商业银行·阳湖卡(银联卡)" , @"江南农村商业银行·天天红火卡",
                          @"江南农村商业银行·借记IC卡" , @"海口联合农村商业银行·海口联合农村商业银行合卡" , @"湖北嘉鱼吴江村镇银行·垂虹卡" , @"福建建瓯石狮村镇银行·玉竹卡" , @"浙江平湖工银村镇银行·金平卡" , @"重庆璧山工银村镇银行·翡翠卡",
                          @"重庆农村商业银行·银联标准贷记卡" ,@"重庆农村商业银行·公务卡" ,@"南阳村镇银行·玉都卡" ,@"晋中市榆次融信村镇银行·魏榆卡" ,@"三水珠江村镇银行·珠江太阳卡" ,@"东营莱商村镇银行·绿洲卡" ,@"建设银行·单位结算卡" ,@"玉溪市商业银行·红塔卡"];

    //BIN号
    NSArray* bankBin = @[
                         @"621098", @"622150", @"622151", @"622181", @"622188", @"955100", @"621095", @"620062", @"621285", @"621798", @"621799",
                         @"621797", @"620529", @"622199", @"621096", @"621622", @"623219", @"621674", @"623218", @"621599",@"370246", @"370248",
                         @"370249", @"427010", @"427018", @"427019", @"427020", @"427029", @"427030", @"427039", @"370247", @"438125", @"438126",
                         @"451804",@"451810", @"451811", @"458071", @"489734", @"489735", @"489736", @"510529", @"427062", @"524091", @"427064",
                         @"530970", @"530990", @"558360", @"620200", @"620302", @"620402", @"620403" , @"620404", @"524047" , @"620406" , @"620407",
                         @"525498" , @"620409" , @"620410" , @"620411" ,@"620412" ,@"620502", @"620503", @"620405", @"620408", @"620512", @"620602",
                         @"620604", @"620607", @"620611", @"620612", @"620704", @"620706", @"620707", @"620708", @"620709", @"620710", @"620609", @"620712" , @"620713" , @"620714" , @"620802" , @"620711" , @"620904" , @"620905" , @"621001" , @"620902" , @"621103" , @"621105" , @"621106" , @"621107" , @"621102" , @"621203" , @"621204" , @"621205" , @"621206" , @"621207" , @"621208" , @"621209" , @"621210" , @"621302" , @"621303" , @"621202" , @"621305" , @"621306" , @"621307" , @"621309" , @"621311" , @"621313" , @"621211" , @"621315" , @"621304" , @"621402" , @"621404" , @"621405" , @"621406" , @"621407" , @"621408" , @"621409" , @"621410" , @"621502" , @"621317" , @"621511" , @"621602" , @"621603" , @"621604" , @"621605" , @"621608" , @"621609" , @"621610" , @"621611" , @"621612" , @"621613" , @"621614" , @"621615" , @"621616" , @"621617" , @"621607" , @"621606" , @"621804" , @"621807" , @"621813" , @"621814" , @"621817" , @"621901" , @"621904" , @"621905" , @"621906" , @"621907" , @"621908" , @"621909" , @"621910" , @"621911" , @"621912" , @"621913" , @"621915" , @"622002" , @"621903" , @"622004" , @"622005" , @"622006" , @"622007" , @"622008" , @"622010" , @"622011" , @"622012" , @"621914" , @"622015" , @"622016" , @"622003" , @"622018" , @"622019" , @"622020" , @"622102" , @"622103" , @"622104" , @"622105" , @"622013" , @"622111" , @"622114" , @"622200" , @"622017" , @"622202" , @"622203" , @"622208" , @"622210" , @"622211" , @"622212" , @"622213" , @"622214" , @"622110" , @"622220" , @"622223" , @"622225" , @"622229" , @"622230" , @"622231" , @"622232" , @"622233" , @"622234" , @"622235" , @"622237" , @"622215" , @"622239" , @"622240" , @"622245" , @"622224" , @"622303" , @"622304" , @"622305" , @"622306" , @"622307" , @"622308" , @"622309" , @"622238" , @"622314" , @"622315" , @"622317" , @"622302" , @"622402" , @"622403" , @"622404" , @"622313" , @"622504" , @"622505" , @"622509" , @"622513" , @"622517" , @"622502" , @"622604" , @"622605" , @"622606" , @"622510" , @"622703" , @"622715" , @"622806" , @"622902" , @"622903" , @"622706" , @"623002" , @"623006" , @"623008" , @"623011" , @"623012" , @"622904" , @"623015" , @"623100" , @"623202" , @"623301" , @"623400" , @"623500" , @"623602" , @"623803" , @"623901" , @"623014" , @"624100" , @"624200" , @"624301" , @"624402" , @"62451804" , @"62451810" , @"62451811" , @"62458071" , @"623700" , @"628288" , @"624000" , @"628286" , @"622206" , @"621225" , @"526836" , @"513685" , @"543098" , @"458441" , @"620058" , @"621281" , @"622246" , @"900000" , @"544210" , @"548943" , @"370267" , @"621558" , @"621559" , @"621722" , @"621723" , @"620086" , @"621226" , @"402791" , @"427028" , @"427038" , @"548259" , @"356879" , @"356880" , @"356881" , @"356882" , @"528856" , @"621618" , @"620516" , @"621227" , @"621721" , @"900010" , @"625330" , @"625331" , @"625332" , @"623062" , @"622236" , @"621670" , @"524374" , @"550213" , @"374738" , @"374739" , @"621288" , @"625708" , @"625709" , @"622597" , @"622599" , @"360883" , @"360884" , @"625865" , @"625866" , @"625899" , @"621376" , @"620054" , @"620142" , @"621428" , @"625939" , @"621434" , @"625987" , @"621761" , @"621749" , @"620184" , @"621300" , @"621378" , @"625114" , @"622159" , @"621720" , @"625021" , @"625022" , @"621379" , @"620114" , @"620146" , @"621724" , @"625918" , @"621371" , @"620143" , @"620149" , @"621414" , @"625914" , @"621375" , @"620187" , @"621433" , @"625986" , @"621370" , @"625925" , @"622926" , @"622927" , @"622928" , @"622929" , @"622930" , @"622931" , @"620124" , @"620183" , @"620561" , @"625116" , @"622227" , @"621372" , @"621464" , @"625942" , @"622158" , @"625917" , @"621765" , @"620094" , @"620186" , @"621719" , @"621719" , @"621750" , @"621377" , @"620148" , @"620185" , @"621374" , @"621731" , @"621781" , @"552599" , @"623206" , @"621671" , @"620059" , @"403361" , @"404117" , @"404118" , @"404119" , @"404120" , @"404121" , @"463758" , @"514027" , @"519412" , @"519413" , @"520082" , @"520083" , @"558730" , @"621282" , @"621336" , @"621619" , @"622821" , @"622822" , @"622823" , @"622824" , @"622825" , @"622826" , @"622827" , @"622828" , @"622836" , @"622837" , @"622840" , @"622841" , @"622843" , @"622844" , @"622845" , @"622846" , @"622847" , @"622848" , @"622849" , @"623018" , @"625996" , @"625997" , @"625998" , @"628268" , @"625826" , @"625827" , @"548478" , @"544243" , @"622820" , @"622830" , @"622838" , @"625336" , @"628269" , @"620501" , @"621660" , @"621661" , @"621662" , @"621663" , @"621665" , @"621667" , @"621668" , @"621669" , @"621666" , @"625908" , @"625910" , @"625909" , @"356833" , @"356835" , @"409665" , @"409666" , @"409668" , @"409669" , @"409670" , @"409671" , @"409672" , @"456351" , @"512315" , @"512316" , @"512411" , @"512412" , @"514957" , @"409667" , @"518378" , @"518379" , @"518474" , @"518475" , @"518476" , @"438088" , @"524865" , @"525745" , @"525746" , @"547766" , @"552742" , @"553131" , @"558868" , @"514958" , @"622752" , @"622753" , @"622755" , @"524864" , @"622757" , @"622758" , @"622759" , @"622760" , @"622761" , @"622762" , @"622763" , @"601382" , @"622756" , @"628388" , @"621256" , @"621212" , @"620514" , @"622754" , @"622764" , @"518377" , @"622765" , @"622788" , @"621283" , @"620061" , @"621725" , @"620040" , @"558869" , @"621330" , @"621331" , @"621332" , @"621333" , @"621297" , @"377677" , @"621568" , @"621569" , @"625905" , @"625906" , @"625907" , @"628313" , @"625333" , @"628312" , @"623208" , @"621620" , @"621756" , @"621757" , @"621758" , @"621759" , @"621785" , @"621786" , @"621787" , @"621788" , @"621789" , @"621790" , @"621672" , @"625337" , @"625338" , @"625568" , @"621648" , @"621248" , @"621249" , @"622750" , @"622751" , @"622771" , @"622772" , @"622770" , @"625145" , @"620531" , @"620210" , @"620211" , @"622479" , @"622480" , @"622273" , @"622274" , @"621231" , @"621638" , @"621334" , @"625140" , @"621395" , @"622725" , @"622728" , @"621284" , @"421349" , @"434061" , @"434062" , @"436728" , @"436742" , @"453242" , @"491031" , @"524094" , @"526410" , @"544033" , @"552245" , @"589970" , @"620060" , @"621080" , @"621081" , @"621466" , @"621467" , @"621488" , @"621499" , @"621598" , @"621621" , @"621700" , @"622280" , @"622700" , @"622707" , @"622966" , @"622988" , @"625955" , @"625956" , @"553242" , @"621082" , @"621673" , @"623211" , @"356896" , @"356899" , @"356895" , @"436718" , @"436738" , @"436745" , @"436748" , @"489592" , @"531693" , @"532450" , @"532458" , @"544887" , @"552801" , @"557080" , @"558895" , @"559051" , @"622166" , @"622168" , @"622708" , @"625964" , @"625965" , @"625966" , @"628266" , @"628366" , @"625362" , @"625363" , @"628316" , @"628317" , @"620021" , @"620521" , @"405512" , @"601428" , @"405512" , @"434910" , @"458123" , @"458124" , @"520169" , @"522964" , @"552853" , @"601428" , @"622250" , @"622251" , @"521899" , @"622254" , @"622255" , @"622256" , @"622257" , @"622258" , @"622259" , @"622253" , @"622261" , @"622284" , @"622656" , @"628216" , @"622252" , @"66405512" , @"622260" , @"66601428" , @"955590" , @"955591" , @"955592" , @"955593" , @"628218" , @"622262" , @"621069" , @"620013" , @"625028" , @"625029" , @"621436" , @"621002" , @"621335" , @"433670" , @"433680" , @"442729" , @"442730" , @"620082" , @"622690" , @"622691" , @"622692" , @"622696" , @"622698" , @"622998" , @"622999" , @"433671" , @"968807" , @"968808" , @"968809" , @"621771" , @"621767" , @"621768" , @"621770" , @"621772" , @"621773" , @"620527" , @"356837" , @"356838" , @"486497" , @"622660" , @"622662" , @"622663" , @"622664" , @"622665" , @"622666" , @"622667" , @"622669" , @"622670" , @"622671" , @"622672" , @"622668" , @"622661" , @"622674" , @"622673" , @"620518" , @"621489" , @"621492" , @"620535" , @"623156" , @"621490" , @"621491" , @"620085" , @"623155" , @"623157" , @"623158" , @"623159" , @"999999" , @"621222" , @"623020" , @"623021" , @"623022" , @"623023" , @"622630" , @"622631" , @"622632" , @"622633" , @"622615" , @"622616" , @"622618" , @"622622" , @"622617" , @"622619" , @"415599" , @"421393" , @"421865" , @"427570" , @"427571" , @"472067" , @"472068" , @"622620" , @"621691" , @"545392" , @"545393" , @"545431" , @"545447" , @"356859" , @"356857" , @"407405" , @"421869" , @"421870" , @"421871" , @"512466" , @"356856" , @"528948" , @"552288" , @"622600" , @"622601" , @"622602" , @"517636" , @"622621" , @"628258" , @"556610" , @"622603" , @"464580" , @"464581" , @"523952" , @"545217" , @"553161" , @"356858" , @"622623" , @"625911" , @"377152" , @"377153" , @"377158" , @"377155" , @"625912" , @"625913" , @"356885" , @"356886" , @"356887" , @"356888" , @"356890" , @"402658" , @"410062" , @"439188" , @"439227" , @"468203" , @"479228" , @"479229" , @"512425" , @"521302" , @"524011" , @"356889" , @"545620" , @"545621" , @"545947" , @"545948" , @"552534" , @"552587" , @"622575" , @"622576" , @"622577" , @"622579" , @"622580" , @"545619" , @"622581" , @"622582" , @"622588" , @"622598" , @"622609" , @"690755" , @"690755" , @"545623" , @"621286" , @"620520" , @"621483" , @"621485" , @"621486" , @"628290" , @"622578" , @"370285" , @"370286" , @"370287" , @"370289" , @"439225" , @"518710" , @"518718" , @"628362" , @"439226" , @"628262" , @"625802" , @"625803" , @"621299" , @"966666" , @"622909" , @"622908" , @"438588" , @"438589" , @"461982" , @"486493" , @"486494" , @"486861" , @"523036" , @"451289" , @"527414" , @"528057" , @"622901" , @"622902" , @"622922" , @"628212" , @"451290" , @"524070" , @"625084" , @"625085" , @"625086" , @"625087" , @"548738" , @"549633" , @"552398" , @"625082" , @"625083" , @"625960" , @"625961" , @"625962" , @"625963" , @"356851" , @"356852" , @"404738" , @"404739" , @"456418" , @"498451" , @"515672" , @"356850" , @"517650" , @"525998" , @"622177" , @"622277" , @"622516" , @"622517" , @"622518" , @"622520" , @"622521" , @"622522" , @"622523" , @"628222" , @"628221" , @"984301" , @"984303" , @"622176" , @"622276" , @"622228" , @"621352" , @"621351" , @"621390" , @"621792" , @"625957" , @"625958" , @"621791" , @"620530" , @"625993" , @"622519" , @"621793" , @"621795" , @"621796" , @"622500" , @"623078" , @"622384" , @"940034" , @"940015" , @"622886" , @"622391" , @"940072" , @"622359" , @"940066" , @"622857" , @"940065" , @"621019" , @"622309" , @"621268" , @"622884" , @"621453" , @"622684" , @"621016" , @"621015" , @"622950" , @"622951" , @"621072" , @"623183" , @"623185" , @"621005" , @"622172" , @"622985" , @"622987" , @"622267" , @"622278" , @"622279" , @"622468" , @"622892" , @"940021" , @"621050" , @"620522" , @"356827" , @"356828" , @"356830" , @"402673" , @"402674" , @"438600" , @"486466" , @"519498" , @"520131" , @"524031" , @"548838" , @"622148" , @"622149" , @"622268" , @"356829" , @"622300" , @"628230" , @"622269" , @"625099" , @"625953" , @"625350" , @"625351" , @"625352" , @"519961" , @"625839" , @"421317" , @"602969" , @"621030" , @"621420" , @"621468" , @"623111" , @"422160" , @"422161" , @"622865" , @"940012" , @"623131" , @"622178" , @"622179" , @"628358" , @"622394" , @"940025" , @"621279" , @"622281" , @"622316" , @"940022" , @"621418" , @"512431" , @"520194" , @"621626" , @"623058" , @"602907" , @"622986" , @"622989" , @"622298" , @"622338" , @"940032" , @"623205" , @"621977" , @"990027" , @"622325" , @"623029" , @"623105" , @"621244" , @"623081" , @"623108" , @"566666" , @"622455" , @"940039" , @"622466" , @"628285" , @"622420" , @"940041" , @"623118" , @"603708" , @"622993" , @"623070" , @"623069" , @"623172" , @"623173" , @"622383" , @"622385" , @"628299" , @"603506" , @"603367" , @"622878" , @"623061" , @"623209" , @"628242" , @"622595" , @"622303" , @"622305" , @"621259" , @"622596" , @"622333" , @"940050" , @"621439" , @"623010" , @"621751" , @"628278" , @"625502" , @"625503" , @"625135" , @"622476" , @"621754" , @"622143" , @"940001" , @"623026" , @"623086" , @"628291" , @"621532" , @"621482" , @"622135" , @"622152" , @"622153" , @"622154" , @"622996" , @"622997" , @"940027" , @"623099" , @"623007" , @"940055" , @"622397" , @"622398" , @"940054" , @"622331" , @"622426" , @"625995" , @"621452" , @"628205" , @"628214" , @"625529" , @"622428" , @"621529" , @"622429" , @"621417" , @"623089" , @"623200" , @"940057" , @"622311" , @"623119" , @"622877" , @"622879" , @"621775" , @"623203" , @"603601" , @"622137" , @"622327" , @"622340" , @"622366" , @"622134" , @"940018" , @"623016" , @"623096" , @"940049" , @"622425" , @"622425" , @"621577" , @"622485" , @"623098" , @"628329" , @"621538" , @"940006" , @"621269" , @"622275" , @"621216" , @"622465" , @"940031" , @"621252" , @"622146" , @"940061" , @"621419" , @"623170" , @"622440" , @"940047" , @"940017" , @"622418" , @"623077" , @"622413" , @"940002" , @"623188" , @"622310" , @"940068" , @"622321" , @"625001" , @"622427" , @"940069" , @"623039" , @"628273" , @"622370" , @"683970" , @"940074" , @"621437" , @"628319" , @"990871" , @"622308" , @"621415" , @"623166" , @"622132" , @"621340" , @"621341" , @"622140" , @"623073" , @"622147" , @"621633" , @"622301" , @"623171" , @"621422" , @"622335" , @"622336" , @"622165" , @"622315" , @"628295" , @"625950" , @"621760" , @"622337" , @"622411" , @"623102" , @"622342" , @"623048" , @"622367" , @"622392" , @"623085" , @"622395" , @"622441" , @"622448" , @"621413" , @"622856" , @"621037" , @"621097" , @"621588" , @"623032" , @"622644" , @"623518" , @"622870" , @"622866" , @"623072" , @"622897" , @"628279" , @"622864" , @"621403" , @"622561" , @"622562" , @"622563" , @"622167" , @"622777" , @"621497" , @"622868" , @"622899" , @"628255" , @"625988" , @"622566" , @"622567" , @"622625" , @"622626" , @"625946" , @"628200" , @"621076" , @"504923" , @"622173" , @"622422" , @"622447" , @"622131" , @"940076" , @"621579" , @"622876" , @"622873" , @"622962" , @"622936" , @"623060" , @"622937" , @"623101" , @"621460" , @"622939" , @"622960" , @"623523" , @"621591" , @"622961" , @"628210" , @"622283" , @"625902" , @"621010" , @"622980" , @"623135" , @"621726" , @"621088" , @"620517" , @"622740" , @"625036" , @"621014" , @"621004" , @"622972" , @"623196" , @"621028" , @"623083" , @"628250" , @"623121" , @"621070" , @"628253" , @"622979" , @"621035" , @"621038" , @"621086" , @"621498" , @"621296" , @"621448" , @"622945" , @"621755" , @"622940" , @"623120" , @"628355" , @"621089" , @"623161" , @"628339" , @"621074" , @"621515" , @"623030" , @"621345" , @"621090" , @"623178" , @"621091" , @"623168" , @"621057" , @"623199" , @"621075" , @"623037" , @"628303" , @"621233" , @"621235" , @"621223" , @"621780" , @"621221" , @"623138" , @"628389" , @"621239" , @"623068" , @"621271" , @"628315" , @"621272" , @"621738" , @"621273" , @"623079" , @"621263" , @"621325" , @"623084" , @"621327" , @"621753" , @"628331" , @"623160" , @"621366" , @"621388" , @"621348" , @"621359" , @"621360" , @"621217" , @"622959" , @"621270" , @"622396" , @"622511" , @"623076" , @"621391" , @"621339" , @"621469" , @"621625" , @"623688" , @"623113" , @"621601" , @"621655" , @"621636" , @"623182" , @"623087" , @"621696" , @"622955" , @"622478" , @"940013" , @"621495" , @"621688" , @"623162" , @"622462" , @"628272" , @"625101" , @"622323" , @"623071" , @"603694" , @"622128" , @"622129" , @"623035" , @"623186" , @"621522" , @"622271" , @"940037" , @"940038" , @"985262" , @"622322" , @"628381" , @"622481" , @"622341" , @"940058" , @"623115" , @"621258" , @"621465" , @"621528" , @"622328" , @"940062" , @"625288" , @"623038" , @"625888" , @"622332" , @"940063" , @"623123" , @"622138" , @"621066" , @"621560" , @"621068" , @"620088" , @"621067" , @"622531" , @"622329" , @"623103" , @"622339" , @"620500" , @"621024" , @"622289" , @"622389" , @"628300" , @"625516" , @"621516" , @"622859" , @"622869" , @"623075" , @"622895" , @"623125" , @"622947" , @"621561" , @"623095" , @"621073" , @"623109" , @"621361" , @"623033" , @"623207" , @"622891" , @"621363" , @"623189" , @"623510" , @"622995" , @"621053" , @"621230" , @"621229" , @"622218" , @"628267" , @"621392" , @"621481" , @"621310" , @"621396" , @"623251" , @"628351"];

    int index = -1;

    if(idCard==nil || idCard.length<16 || idCard.length>19){
        return @"";
    }
    //6位Bin号
    NSString* cardbin_6 = [idCard substringWithRange:NSMakeRange(0, 6)];
    for (int i = 0; i < bankBin.count; i++) {
        if ([cardbin_6 isEqualToString:bankBin[i]]) {
            index = i;
        }
    }
    if (index != -1) {
        return bankName[index];
    }

    //8位Bin号
    NSString* cardbin_8 = [idCard substringWithRange:NSMakeRange(0, 8)];
    for (int i = 0; i < bankBin.count; i++) {
        if ([cardbin_8 isEqualToString:bankBin[i]]) {
            index = i;
        }
    }
    if (index != -1) {
        return bankName[index];
    }

    return @"";
}

/**
 *
 *更具日期星期获取今天是星期几
 */
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

#pragma mark 包大小转换工具类（将包大小转换成合适单位）
+ (NSString *)getDataSizeString:(int) nSize
{
    NSString *string = nil;
    if (nSize<1024)
    {
        string = [NSString stringWithFormat:@"%dB", nSize];
    }
    else if (nSize<1048576)
    {
        string = [NSString stringWithFormat:@"%dK", (nSize/1024)];
    }
    else if (nSize<1073741824)
    {
        if ((nSize%1048576)== 0 )
        {
            string = [NSString stringWithFormat:@"%dM", nSize/1048576];
        }
        else
        {
            int decimal = 0; //小数
            NSString* decimalStr = nil;
            decimal = (nSize%1048576);
            decimal /= 1024;

            if (decimal < 10)
            {
                decimalStr = [NSString stringWithFormat:@"%d", 0];
            }
            else if (decimal >= 10 && decimal < 100)
            {
                int i = decimal / 10;
                if (i >= 5)
                {
                    decimalStr = [NSString stringWithFormat:@"%d", 1];
                }
                else
                {
                    decimalStr = [NSString stringWithFormat:@"%d", 0];
                }

            }
            else if (decimal >= 100 && decimal < 1024)
            {
                int i = decimal / 100;
                if (i >= 5)
                {
                    decimal = i + 1;

                    if (decimal >= 10)
                    {
                        decimal = 9;
                    }

                    decimalStr = [NSString stringWithFormat:@"%d", decimal];
                }
                else
                {
                    decimalStr = [NSString stringWithFormat:@"%d", i];
                }
            }

            if (decimalStr == nil || [decimalStr isEqualToString:@""])
            {
                string = [NSString stringWithFormat:@"%dMss", nSize/1048576];
            }
            else
            {
                string = [NSString stringWithFormat:@"%d.%@M", nSize/1048576, decimalStr];
            }
        }
    }
    else	// >1G
{
        string = [NSString stringWithFormat:@"%dG", nSize/1073741824];
    }
    return string;
}

/*
 view 是要设置渐变字体的控件   bgVIew是view的父视图  colors是渐变的组成颜色  startPoint是渐变开始点 endPoint结束点
 */

/**
 <#Description#>

 @param view <#view description#>
 @param bgVIew <#bgVIew description#>
 @param colors <#colors description#>
 @param startPoint <#startPoint description#>
 @param endPoint <#endPoint description#>
 */
+(void)TextGradientview:(UIView *)view bgVIew:(UIView *)bgVIew gradientColors:(NSArray *)colors gradientStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    
    CAGradientLayer* gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = view.frame;
    gradientLayer1.colors = colors;
    gradientLayer1.startPoint =startPoint;
    gradientLayer1.endPoint = endPoint;
    [bgVIew.layer addSublayer:gradientLayer1];
    gradientLayer1.mask = view.layer;
    view.frame = gradientLayer1.bounds;
}




/*
 control 是要设置渐变字体的控件   bgVIew是control的父视图  colors是渐变的组成颜色  startPoint是渐变开始点 endPoint结束点
 */
+(void)TextGradientControl:(UIControl *)control bgVIew:(UIView *)bgVIew gradientColors:(NSArray *)colors gradientStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    
    CAGradientLayer* gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = control.frame;
    gradientLayer1.colors = colors;
    gradientLayer1.startPoint =startPoint;
    gradientLayer1.endPoint = endPoint;
    [bgVIew.layer addSublayer:gradientLayer1];
    gradientLayer1.mask = control.layer;
    control.frame = gradientLayer1.bounds;
}

+ (BOOL)isUrlAddress:(NSString*)url {
    NSString*reg =@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSPredicate*urlPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    return[urlPredicate evaluateWithObject:url];

}

/**
 html 富文本设置

 @param str html 未处理的字符串
 @param font 设置字体
 @param lineSpacing 设置行高
 @return 默认不将 \n替换<br/> 返回处理好的富文本
 */
+ (NSMutableAttributedString *)setAttributedString:(NSString *)str font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing
{
    //如果有换行，把\n替换成<br/>
    //如果有需要把换行加上
//    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
    //设置HTML图片的宽度
    if (![str containsString:@"<head><style>img{max-width:"]) {
        str = [NSString stringWithFormat:@"<head><style>img{max-width:%f !important;height:auto}</style></head>%@",[UIScreen mainScreen].bounds.size.width,str];
    }

    NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
    //设置富文本字的大小
  //  [htmlString addAttributes:@{NSFontAttributeName:font} range:NSMakeRange(0, htmlString.length)];
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [htmlString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [htmlString length])];
    
    return htmlString;
}

/**
 计算html字符串高度

 @param str html 未处理的字符串
 @param font 字体设置
 @param lineSpacing 行高设置
 @param width 容器宽度设置
 @return 富文本高度
 */
+ (CGFloat )getHTMLHeightByStr:(NSString *)str font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing width:(CGFloat)width
{
     
    if (![str containsString:@"<head><style>img{max-width:"]) {
         str = [NSString stringWithFormat:@"<head><style>img{max-width:%f !important;height:auto}</style></head>%@",[UIScreen mainScreen].bounds.size.width,str];
     
    }
    
    NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
    //[htmlString addAttributes:@{NSFontAttributeName:font} range:NSMakeRange(0, htmlString.length)];
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:lineSpacing];
    [htmlString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [htmlString length])];
    
    CGSize contextSize = [htmlString boundingRectWithSize:(CGSize){width, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    return contextSize.height ;
}

/// 获取系统推送是否打开
+ (BOOL)loadNotificationSettingsisopen {
    __block BOOL YorN;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [[UNUserNotificationCenter currentNotificationCenter]getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined) {
            YorN = NO;
        }else if (settings.authorizationStatus == UNAuthorizationStatusDenied) {
            YorN = NO;
        }else {
            YorN = YES;
        }
        dispatch_semaphore_signal(semaphore);
    }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return YorN;
}

+ (void)opensettingsurl {
    // 跳转到系统设置
    NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:settingURL options:[NSDictionary dictionary] completionHandler:nil];
    }
}


+ (UIImage *)doScreenShot:(UIViewController *)vc SavedPhotos:(BOOL)SavedPhotos{
    // 开启图片上下文
    UIGraphicsBeginImageContextWithOptions(vc.view.bounds.size, NO, 0);
    // 获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 截图:实际是把layer上面的东西绘制到上下文中
    [vc.view.layer renderInContext:ctx];
    // 获取截图
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图片上下文
    UIGraphicsEndImageContext();
    if (SavedPhotos) {
        // 保存相册
        UIImageWriteToSavedPhotosAlbum(image, NULL, NULL, NULL);
    }
    return image;

}


+ (int)CreateCurrent:(NSString *)current {
    NSArray *array = [current componentsSeparatedByString:@"."];
    NSArray *numarray = @[@(1000),@(100),@(10),@(1)];
    int num = 0;
    for (int i = 0; i < array.count; i++) {
        num = [array[i] intValue] * [numarray[i] intValue] + num;
    }
    return num;
}

+ (NSString *)getHmacmd5:(NSString *)clearText withSecret:(NSString *)secret{
   CCHmacContext ctx;
  //使用GBK编码
  unsigned long encode =   CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
  const char *key = [secret cStringUsingEncoding:encode];
  const char *str = [clearText cStringUsingEncoding:encode];
  unsigned char mac[CC_MD5_DIGEST_LENGTH];
  char hexmac[2 * CC_MD5_DIGEST_LENGTH + 1];
  char *p;
  CCHmacInit(&ctx, kCCHmacAlgMD5, key, strlen(key));
  CCHmacUpdate(&ctx, str, strlen(str));
  CCHmacFinal(&ctx, mac);
  p = hexmac;
  for (int i = 0; i < CC_MD5_DIGEST_LENGTH;i++) {
      snprintf(p,3,"%02x", mac[ i ]);
      p += 2;
  }
  return [NSString stringWithCString:hexmac encoding:encode];
}

/// 获取包名
+ (NSString *)getBundleIdentifier {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

//获取版本号
+ (NSString *)getAppVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

//获取应用名称
+ (NSString *)getAppDisplayName{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}


+ (UIView *)tengteng_configlineV:(CGRect)frame backcolor:(UIColor *)backcolor {
    return [TT_ControlTool FTT_ControlToolUIViewFrame:frame
                                              BackgroundColor:backcolor
                                                MasksToBounds:NO
                                                ConrenrRadius:0];
    
}

+ (UIFont *)confignormalfontsize:(NSInteger)fontsize {
    return [UIFont fontWithName:@"PingFang-SC-Regular" size:fontsize];
}

+ (UIFont *)confignormalboldfontsize:(NSInteger)fontsiez {
    return [UIFont fontWithName:@"Helvetica-Bold" size:fontsiez];
}


+ (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end
