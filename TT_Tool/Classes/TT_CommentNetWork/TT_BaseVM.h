//
//  PZ_BaseVM.h
//  tengteng
//
//  Created by tengtengdang on 2018/9/5.
//  Copyright © 2018年 腾腾. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TT_BaseVM : NSObject

@property (nonatomic , copy) void(^New_Close)(id allData , NSMutableArray *Data , BOOL SucessORfail , BOOL has_more, NSString *mark);
/// 初始化
+ (instancetype)setupVMclass:(Class)VMclass;
/// 测试数据回调
- (void)testloadDataResuletBlock:(void(^)(NSMutableArray *Data , BOOL SucessORfail , BOOL has_more))resulteBlock;
/// 可同时进行多个网络请求
- (void)loadDataNetWorkWithAnswersParams:(NSMutableDictionary *)Params
                             networkName:(NSString *)networkName
                            networkClass:(Class)networkClass
                            ResuletBlcok:(void(^)(id allData ,NSMutableArray *Data , BOOL SucessORfail , BOOL has_more , NSString *mark))resulteBlock;

- (void)loadDataNetWorkWithAnswersParams:(NSMutableDictionary *)Params
                             networkName:(NSString *)networkName
                             networkMark:(NSString *)networkMark
                            networkClass:(Class)networkClass
                            ResuletBlcok:(void(^)(id allData ,NSMutableArray *Data , BOOL SucessORfail , BOOL has_more , NSString *mark))resulteBlock;
/// 配置测试数据
- (NSMutableArray *)configtextData;

- (void)cancerlAllnet;

@end
