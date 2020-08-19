//
//  NSString+URL.m
//  tengteng
//
//  Created by 腾腾 on 2017/12/1.
//  Copyright © 2017年 腾腾. All rights reserved.
//

#import "NSString+URL.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (URL)

- (NSString *)URLEncodedString
{
    NSString * charaters = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:charaters] invertedSet];
    return [self stringByAddingPercentEncodingWithAllowedCharacters:set];
}

- (BOOL)isEmpty ///< 是否为空或者是空格
{
    
    NSString * newSelf = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(nil == self
       || self.length ==0
       || [self isEqualToString:@""]
       || [self isEqualToString:@"<null>"]
       || [self isEqualToString:@"(null)"]
       || [self isEqualToString:@"null"]
       || newSelf.length ==0
       || [newSelf isEqualToString:@""]
       || [newSelf isEqualToString:@"<null>"]
       || [newSelf isEqualToString:@"(null)"]
       || [newSelf isEqualToString:@"null"]
       || [self isKindOfClass:[NSNull class]] ){
        
        return YES;
        
    }else{
        // <object returned empty description> 会来这里
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
        
        return [trimedString isEqualToString: @""];
    }
    
    return NO;
}


-(NSString *)changeTelephone:(NSString*)teleStr{
    NSString * string = @"请填写手机号";
    if (teleStr) {
         string = [teleStr stringByReplacingOccurrencesOfString:[teleStr substringWithRange:NSMakeRange(3,4)]withString:@"****"];
    }
    
  
    return string;
}

/**
 *  URLDecode
 */
-(NSString *)URLDecodedString
{
    return [self stringByRemovingPercentEncoding];
}

- (BOOL)isValidUrl
{
    NSString *regex =@"[a-zA-z]+://[^\\s]*";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:self];
}

-(NSString *)base64EncodeString:(NSString *)string{
    //1、先转换成二进制数据
    NSData *data =[string dataUsingEncoding:NSUTF8StringEncoding];
    //2、对二进制数据进行base64编码，完成后返回字符串
    return [data base64EncodedStringWithOptions:0];
}

-(NSString *)base64DecodeString:(NSString *)string{
    //注意：该字符串是base64编码后的字符串
    //1、转换为二进制数据（完成了解码的过程）
    NSData *data=[[NSData alloc]initWithBase64EncodedString:string options:0];
    //2、把二进制数据转换成字符串
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString *)App_Name {
    return [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleDisplayName"];
}

/// 千万级别的转换
- (NSString *)changeAsset:(NSString *)amountStr {
    if(amountStr && ![amountStr isEqualToString:@""]){
        NSInteger num = [amountStr floatValue];
        if(num >=1000000000000){
            NSString *str = [NSString stringWithFormat:@"%.2f",num/1000000000000.0];
            return[NSString stringWithFormat:@"%@万亿",str];
        }else if(num >=100000000){
            NSString *str = [NSString stringWithFormat:@"%.2f",num/100000000.0];
            return[NSString stringWithFormat:@"%@亿",str];
        } else if(num >=10000000){
            NSString *str = [NSString stringWithFormat:@"%.2f",num/10000000.0];
            return[NSString stringWithFormat:@"%@千万",str];
        }else if(num >=10000){
            NSString *str = [NSString stringWithFormat:@"%.2f",num/10000.0];
            return[NSString stringWithFormat:@"%@万",str];
        }
    }
    return amountStr;
}

-(NSMutableAttributedString *)setAttributedString:(NSString *)str
{
    //如果有换行，把\n替换成<br/>
    //如果有需要把换行加上
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
    //设置HTML图片的宽度
    str = [NSString stringWithFormat:@"<head><style>img{width:%f !important;height:auto}</style></head>%@",[UIScreen mainScreen].bounds.size.width,str];
    NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
    //设置富文本字的大小
    [htmlString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} range:NSMakeRange(0, htmlString.length)];
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    [htmlString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [htmlString length])];
    return htmlString;
}

//计算html字符串高度
-(CGFloat )getHTMLHeightByStr:(NSString *)str
{
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
    str = [NSString stringWithFormat:@"<head><style>img{width:%f !important;height:auto}</style></head>%@",[UIScreen mainScreen].bounds.size.width,str];

    NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
    [htmlString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} range:NSMakeRange(0, htmlString.length)];
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:5];
    [htmlString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [htmlString length])];
    
    CGSize contextSize = [htmlString boundingRectWithSize:(CGSize){[UIScreen mainScreen].bounds.size.width,
        CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    return contextSize.height ;
    
}

-(NSString *)removeFloatAllZero:(NSString *)string{
    NSString * testNumber = string;
    NSString * outNumber = [NSString stringWithFormat:@"%@",@(testNumber.floatValue)];
    //价格格式化显示
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    NSString * formatterString = [formatter stringFromNumber:[NSNumber numberWithFloat:[outNumber doubleValue]]];
    //获取要截取的字符串位置
    NSRange range = [formatterString rangeOfString:@"."];
    if (range.length >0 ) {
        NSString * result = [formatterString substringFromIndex:range.location];
        if (result.length >= 4) {
            formatterString = [formatterString substringToIndex:formatterString.length - 1];
        }
    }
    return formatterString;
}

//判断是否为整形：

- (BOOL)isPureInt:(NSString*)string{

    NSScanner* scan = [NSScanner scannerWithString:string];

    int val;

    return[scan scanInt:&val] && [scan isAtEnd];
}

-(NSString *) md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[32];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}


@end
