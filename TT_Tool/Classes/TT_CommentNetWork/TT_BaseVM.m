//
//  PZ_BaseVM.m
//  tengteng
//
//  Created by tengtengdang on 2018/9/5.
//  Copyright © 2018年 腾腾. All rights reserved.
//

#import "TT_BaseVM.h"

@interface TT_BaseVM ()

@end

@implementation TT_BaseVM


+ (instancetype)setupVMclass:(Class)VMclass {
    return [[VMclass alloc]init];
}


- (void)testloadDataResuletBlock:(void (^)(NSMutableArray *, BOOL, BOOL))resulteBlock {
    resulteBlock([self configtextData],YES,YES);
}

- (NSMutableArray *)configtextData {
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i < 10 ; i++) {
        [arr addObject:@"TT"];
    }
    return arr;
}

- (void)loadDataNetWorkWithAnswersParams:(NSMutableDictionary *)Params
                             networkName:(NSString *)networkName
                            networkClass:(Class)networkClass
                            ResuletBlcok:(void(^)(id allData ,NSMutableArray *Data , BOOL SucessORfail , BOOL has_more , NSString *mark))resulteBlock {
    [self loadDataNetWorkWithAnswersParams:Params
                               networkName:networkName
                               networkMark:networkName
                              networkClass:networkClass
                              ResuletBlcok:resulteBlock];
}



- (void)loadDataNetWorkWithAnswersParams:(NSMutableDictionary *)Params
                             networkName:(NSString *)networkName
                             networkMark:(NSString *)networkMark
                            networkClass:(Class)networkClass
                            ResuletBlcok:(void(^)(id allData ,NSMutableArray *Data , BOOL SucessORfail , BOOL has_more , NSString *mark))resulteBlock {

}

- (void)cancerlAllnet {

}


@end
