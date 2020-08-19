//
//  NSString+URL.h
//  tengteng
//
//  Created by 腾腾 on 2017/12/1.
//  Copyright © 2017年 腾腾. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URL)

/**
 *  URLEncode
 */
- (NSString *)URLEncodedString;

- (NSString *)changeTelephone:(NSString*)teleStr;

/**
 *  URLDecode
 */
-(NSString *)URLDecodedString;

- (BOOL)isValidUrl;

-(NSString *)base64EncodeString:(NSString *)string;

-(NSString *)base64DecodeString:(NSString *)string;

- (BOOL)isEmpty ;

+ (NSString *)App_Name;
/// 千万级别的转换
- (NSString *)changeAsset:(NSString *)amountStr;

-(NSMutableAttributedString *)setAttributedString:(NSString *)str;
//计算html字符串高度
-(CGFloat )getHTMLHeightByStr:(NSString *)str;

-(NSString *)removeFloatAllZero:(NSString *)string;

//判断是否为整形：

- (BOOL)isPureInt:(NSString*)string;
@end
