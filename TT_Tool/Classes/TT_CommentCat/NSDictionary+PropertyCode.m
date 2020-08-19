//
//  NSDictionary+PropertyCode.m
//  FTT_AuxiliaryTools
//
//  Created by 樊腾 on 17/6/8.
//  Copyright © 2017年 FTT. All rights reserved.
//

#import "NSDictionary+PropertyCode.h"

@implementation NSDictionary (PropertyCode)
- (void)propertyCode {
    // 属性跟字典的key一一对应
    NSMutableString *codes = [NSMutableString string];
    // 遍历字典中所有key取出来
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        // key:属性名
        NSString *code;
        if ([obj isKindOfClass:[NSString class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic ,strong) NSString *%@;",key];
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            code = [NSString stringWithFormat:@"@property (nonatomic ,assign) BOOL %@;",key];
        }else if ([obj isKindOfClass:[NSNumber class]]){
            code = [NSString stringWithFormat:@"@property (nonatomic ,assign) NSInteger %@;",key];
        }else if ([obj isKindOfClass:[NSArray class]]){
            code = [NSString stringWithFormat:@"@property (nonatomic ,strong) NSArray *%@;",key];
        }else if ([obj isKindOfClass:[NSDictionary class]]){
            code = [NSString stringWithFormat:@"@property (nonatomic ,strong) NSDictionary *%@;",key];
        }
        [codes appendFormat:@"\n%@\n",code];

    }];
}


/** 将NSDictionary中的Null类型的项目转化成@"" */
+(NSDictionary *)nullDic:(NSDictionary *)myDic
{
    NSArray *keyArr = [myDic allKeys];
    NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < keyArr.count; i ++)
    {
        id obj = [myDic objectForKey:keyArr[i]];
        
        obj = [self changeType:obj];
        
        [resDic setObject:obj forKey:keyArr[i]];
    }
    return resDic;
}

/** 将NSArray中的Null类型的项目转化成@"" */
+(NSArray *)nullArr:(NSArray *)myArr
{
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < myArr.count; i ++)
    {
        id obj = myArr[i];
        
        obj = [self changeType:obj];
        
        [resArr addObject:obj];
    }
    return resArr;
}

/** 将NSString类型的原路返回 */
+(NSString *)stringToString:(NSString *)string
{
    return string;
}

/** 将Null类型的项目转化成@"" */
+(NSString *)nullToString
{
    return @"";
}

/** 主要方法 */
/** 类型识别:将所有的NSNull类型转化成@"" */
+(id)changeType:(id)myObj
{
    if ([myObj isKindOfClass:[NSDictionary class]])
    {
        return [self nullDic:myObj];
    }
    else if([myObj isKindOfClass:[NSArray class]])
    {
        return [self nullArr:myObj];
    }
    else if([myObj isKindOfClass:[NSString class]])
    {
        return [self stringToString:myObj];
    }
    else if([myObj isKindOfClass:[NSNull class]])
    {
        return [self nullToString];
    }
    else
    {
        return myObj;
    }
}


+ (NSString *)sortedDictionary:(NSDictionary *)dict{
    //将所有的key放进数组
    NSArray *allKeyArray = [dict allKeys];
    //序列化器对数组进行排序的block 返回值为排序后的数组
    NSArray *afterSortKeyArray = [allKeyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id _Nonnull obj2) {
        //排序操作
        NSComparisonResult resuest = [obj1 compare:obj2];
        return resuest;
    }];
    NSString *json = @"";
    for (int i = 0; i < afterSortKeyArray.count; i++) {
        NSString *key = afterSortKeyArray[i];
        NSString *value = dict[key];
        NSString *jss = [NSString stringWithFormat:@"\"%@\":\"%@\"",key,value];
        json = [json stringByAppendingFormat:@"%@",jss];
        if (i != afterSortKeyArray.count - 1) {
            json = [json stringByAppendingFormat:@","];
        }
    }
    json = [NSString stringWithFormat:@"{%@}",json];
    return json;
//
//    NSLog(@"%@",dic);
//    return dic;
}





@end
