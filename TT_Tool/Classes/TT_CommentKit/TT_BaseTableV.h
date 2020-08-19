//
//  TT_BaseTableV.h
//  tengteng
//
//  Created by tengtengdang on 2018/8/23.
//  Copyright © 2018年 腾腾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TT_TitleV.h"
#import "TT_BaseCell.h"
#import "TT_NothingV.h"
#import <MJRefresh/MJRefresh.h>
#import "TT_CommentMaco.h"
@protocol TT_BaseTableVDelegate<NSObject>



@optional
/// 上下啦刷新触发方法
- (void)refreshDataType:(NSInteger)type;
/// 滚动的距离
- (void)scrollviewoffsetY:(CGFloat)Y;
/// 向上 向下 滑动
- (void)scrollviewSlideupandDown:(BOOL)YorN scrollview:(UIScrollView *)scrollview;
/// 点击cell
- (void)tapcellTriggereventIndex:(NSIndexPath *)index model:(id)model;
/// 点击控件触发方法
- (void)tapviewActiontype:(NSInteger)type model:(id)model;


- (void)scrollviewdidscroll:(UIScrollView *)scrollview;
@end


@interface TT_BaseTableV : UITableView <UITableViewDelegate,UITableViewDataSource>
/// 代理
@property (nonatomic , weak) id<TT_BaseTableVDelegate> TT_delegate;
/// 数据信息
@property (nonatomic , strong) NSMutableArray *infodata;
/// 页数
@property (nonatomic , assign) NSInteger Page;
/// 是否有更多的数据
@property (nonatomic , assign) BOOL havemore;
/// 是否选中状态
@property (nonatomic , assign) BOOL ShowSelect;
/// 上啦刷新
@property (nonatomic , assign) BOOL is_refreshHeader;
/// 下拉刷新
@property (nonatomic , assign) BOOL is_refreshfoot;
/// 上 下 移动
@property (nonatomic , assign) BOOL upOrDown;
/// 第一次获取
@property (nonatomic , assign) BOOL Is_firstload;
/// 第一时间响应滑动事件
@property (nonatomic , assign) BOOL Is_firstSlide;

/// 是否出发多重手势
@property (nonatomic , assign) BOOL is_GestureEvent;
/// 是否是二维数组
@property (nonatomic , assign) BOOL is_twoarr;
/// 选中的cell的index
@property (nonatomic , strong) NSIndexPath *Selectindexpath;
/// 上一次滑动的位置
@property (nonatomic , assign) CGFloat oldcontentOffsetY;
/// 通用的触发事件
@property (nonatomic , copy) void(^tapClose)(NSInteger num, id data);
/// 上啦 下啦
@property (nonatomic , assign) NSInteger pushOrpull;
/// 是否上啦加载
@property (nonatomic , assign) BOOL ispullload;
/// 空数据界面
@property (nonatomic , strong) TT_NothingV *NothingV;
/// 大标题
@property (nonatomic , strong) TT_TitleV *BigTitleV;
/// 创建table
+ (instancetype)setupTableVCellClass:(Class)cellClass Frame:(CGRect)Frame style:(UITableViewStyle)style;
/// 数据赋值
- (void)configData:(id)Data;

- (void)setupNewConfiguration;
/// 增加是否有 更多数据
- (void)configDataNew:(id)Data has_more:(BOOL)has_more;

- (void)celltapDelegateIndexPath:(NSIndexPath *)indexPath data:(id)data;
/// 设置XIB
- (void)configCellXIB;
/// 修改属性
- (void)changeDefaultConfigguration;
/// 结束刷新
- (void)endRefresh;
/// 设置大标题
- (void)configbigTitle:(NSString *)title ImageName:(NSString *)ImageName comple:(void(^)(void))comple;
///// 数据转换
//- (void)configPagewithData:(NSMutableArray *)Data YorN:(BOOL)YorN;
/// 点击cell 状态改变
- (void)cellselectStatechangeIndex:(NSIndexPath *)index;
/// 显示空数据界面
- (void)tengteng_configNothingVishide:(BOOL)ishide;
/// 回调通用方法
- (void)generaltriggermethodType:(NSInteger)type data:(id)data;
- (void)scroloffY:(CGFloat)Y;
/// 设置上下啦刷新的代理
- (void)setRefreshDataType:(NSInteger)type;
- (void)configIstoweer;

@end
