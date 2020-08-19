//
//  TT_BaseCell.h
//  tengteng
//
//  Created by tengtengdang on 2018/8/23.
//  Copyright © 2018年 腾腾. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TT_BaseCell : UITableViewCell

@property (nonatomic , strong) UILabel *lable;
/// 是否选中
@property (nonatomic , assign) BOOL is_select;
/// 通用回调
@property (nonatomic , copy) void(^currencyClose)(NSInteger num);

@property (nonatomic , copy) void(^currencyparameterClose) (NSInteger type, id Data);

+ (instancetype)cellWithTableView:(UITableView *)tableview CellClass:(Class)cellClass;
- (instancetype)cellwithTableview:(UITableView *)tableview cellclass:(Class)cellclass ;
- (void)configData:(id)Data;
- (void)setupSubviewS;
- (void)setupSubViewsFrame;
- (void)configtapclose:(NSInteger)num;


@end
