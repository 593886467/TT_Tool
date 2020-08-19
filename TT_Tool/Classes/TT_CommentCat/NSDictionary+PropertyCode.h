//
//  NSDictionary+PropertyCode.h
//  FTT_AuxiliaryTools
//
//  Created by 樊腾 on 17/6/8.
//  Copyright © 2017年 FTT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (PropertyCode)
/**
 生成所需要的属性对吗
 */
- (void)propertyCode;

+ (id)changeType:(id)myObj;
/// 字典排序
+ (NSString *)sortedDictionary:(NSDictionary *)dict;
@end
