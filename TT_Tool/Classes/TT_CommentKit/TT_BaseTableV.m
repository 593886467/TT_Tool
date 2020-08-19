//
//  TT_BaseTableV.m
//  tengteng
//
//  Created by tengtengdang on 2018/8/23.
//  Copyright © 2018年 腾腾. All rights reserved.
//

#import "TT_BaseTableV.h"
#import "TT_BaseCell.h"
@interface TT_BaseTableV ()<UIGestureRecognizerDelegate>





@end


@implementation TT_BaseTableV


#pragma mark 生命周期

+ (instancetype)setupTableVCellClass:(Class)cellClass Frame:(CGRect)Frame style:(UITableViewStyle)style{
    return [[cellClass alloc]initWithFrame:Frame style:style];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self configCellXIB];
        [self setupNewConfiguration];
        [self setupDefaultConfiguration];
        [self changeDefaultConfigguration];
    }
    return self;
}

#pragma mark 回调代理

// 返回YES表示可以继续传递触摸事件，这样两个嵌套的scrollView才能同时滚动
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return self.is_GestureEvent;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    if (self.infodata.count  == 0) {
        return 0;
    }else {
        id result  = self.infodata[0];
        if ([result isKindOfClass:[NSArray class]] || [result isKindOfClass:[NSMutableArray class]]) {
            id arr = self.infodata[section];
            if ([arr isKindOfClass:[NSArray class]] || [arr isKindOfClass:[NSMutableArray class]]) {
                NSArray *tt = arr;
                return tt.count;
            }else {
                return 1;
            }
        }else {
            return self.infodata.count;
        }
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     if (self.infodata.count  != 0) {
        id result  = self.infodata[0];
        if ([result isKindOfClass:[NSArray class]] || [result isKindOfClass:[NSMutableArray class]]) {
            return self.infodata.count;
        }else {
            return 1;
        }
    }else {
        return 1;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 60;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TT_BaseCell *cell  =[TT_BaseCell cellWithTableView:tableView CellClass:[TT_BaseCell class]];
    cell.lable.text = self.infodata[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.ShowSelect) {
        [self cellselectStatechangeIndex:indexPath];
    }
    if (self.TT_delegate != nil && [self.TT_delegate respondsToSelector:@selector(tapcellTriggereventIndex:model:)]) {
        if (self.is_twoarr) {
            [self celltapDelegateIndexPath:indexPath data:self.infodata[indexPath.section][indexPath.row]];
        }else {
            [self celltapDelegateIndexPath:indexPath data:self.infodata[indexPath.row]];
        }
    }
}

- (void)celltapDelegateIndexPath:(NSIndexPath *)indexPath data:(id)data{
    if (self.TT_delegate && [self.TT_delegate respondsToSelector:@selector(tapcellTriggereventIndex:model:)]) {
        [self.TT_delegate tapcellTriggereventIndex:indexPath model:data];
    }
}

/// 已经开始滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    [self scroloffY:offsetY];
    if (self.TT_delegate && [self.TT_delegate respondsToSelector:@selector(scrollviewdidscroll:)]) {
        [self.TT_delegate scrollviewdidscroll:scrollView];
    }
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
//    NSLog(@"offsetY: = %f ---------------- bottomOffset = %f ---------------- height = %f",offsetY,bottomOffset,height);
    if (offsetY > 100 && bottomOffset <= height * 1.5 && !self.Is_firstload && self.is_refreshfoot) {
        if (self.havemore) {
            self.ispullload = NO;
            self.Is_firstload = YES;
            self.Page = self.Page + 1;
            [self setRefreshDataType:2];
        }
    }
    if (self.TT_delegate != nil && [self.TT_delegate respondsToSelector:@selector(scrollviewoffsetY:)]) {
        [self.TT_delegate scrollviewoffsetY:offsetY];
    }
    if (self.Is_firstSlide) {
        [self setUpOrDownForScrollview:scrollView];
    }
}

- (void)scroloffY:(CGFloat)Y {
    
}

/// 将要开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.oldcontentOffsetY = scrollView.contentOffset.y;
}

/// 已经开始拖拽
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self setUpOrDownForScrollview:scrollView];
}

/// 当滚动视图滚动到最顶端后，执行该方法
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    [self setUpOrDownForScrollview:scrollView];
}

/// 滑动视图，当手指离开屏幕那一霎那，调用该方法。一次有效滑动，只执行一次。
/// decelerate,指代，当我们手指离开那一瞬后，视图是否还将继续向前滚动（一段距离），经过测试，decelerate=YES
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self setUpOrDownForScrollview:scrollView];
    }
}


#pragma mark 公开方法

/// 数据赋值
- (void)configData:(id)Data {

}

/// 设置XIB
- (void)configCellXIB {
    
}

/// 修改属性
- (void)changeDefaultConfigguration {
    
}
/// 数据是否有更多
- (void)configDataNew:(id)Data has_more:(BOOL)has_more{
    self.havemore = has_more;
    self.Is_firstload = NO;
    if (self.Page == DefaultPAGE) {
        [self.infodata removeAllObjects];
    }
    [self.infodata addObjectsFromArray:Data];
    [self configIstoweer];
    if (!has_more && _is_refreshfoot) {
        self.mj_footer.state = MJRefreshStateNoMoreData;
    }
    [self endRefresh];
}

- (void)configIstoweer {
    if (self.infodata.count != 0) {
        id result = self.infodata[0];
        if ([result isKindOfClass:[NSArray class]] || [result isKindOfClass:[NSMutableArray class]]) {
            self.is_twoarr = YES;
        }else {
            self.is_twoarr = NO;
        }
    }else {
        self.is_twoarr = NO;
    }
}

/// 结束刷新
- (void)endRefresh {
    if (self.pushOrpull == 1) {
        if (self.mj_header != nil) {
           [self.mj_header endRefreshing];
        }
    }else {
        if (self.mj_footer != nil) {
            [self.mj_footer endRefreshing];
        }
    }
    [self reloadData];
 
}

/// 添加大标题
- (void)configbigTitle:(NSString *)title ImageName:(NSString *)ImageName comple:(void(^)(void))comple {
    self.BigTitleV.ImageName = ImageName;
    self.BigTitleV.title     = title;
    self.tableHeaderView = self.BigTitleV;
    self.BigTitleV.SearchClick = ^{
        if (comple) {
            comple();
        }
    };
}


/// 点击cell 状态改变
- (void)cellselectStatechangeIndex:(NSIndexPath *)index {
    if (self.Selectindexpath != nil && self.Selectindexpath != index) {
        TT_BaseCell *cell = [self cellForRowAtIndexPath:self.Selectindexpath];
        cell.is_select = NO;
    }
    self.Selectindexpath = index;
    TT_BaseCell *cell = [self cellForRowAtIndexPath:index];
    cell.is_select = YES;
}

- (void)tengteng_configNothingVishide:(BOOL)ishide {
    if (ishide) {
        [self.NothingV removeFromSuperview];
    }else {
        [self addSubview:self.NothingV];
    }
}
- (void)generaltriggermethodType:(NSInteger)type data:(id)data {
    if (self.tapClose) {
        self.tapClose(type, data);
    }
}
#pragma mark 触发方法

/// 下啦刷新触发方法
- (void)headerRefresh {
    self.pushOrpull = 1;
    self.Page = DefaultPAGE;
    [self setRefreshDataType:1];
}

/// 上啦刷新触发方法
- (void)footerRefresh {
    self.pushOrpull = 2;
    if (self.havemore) {
        self.ispullload = YES;
        self.Page = self.Page + 1;
        [self setRefreshDataType:2];
    }else {
        self.mj_footer.state = MJRefreshStateNoMoreData;
    }
}

#pragma mark 私有方法
/// 设置默认属性
- (void)setupDefaultConfiguration {
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.estimatedSectionFooterHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedRowHeight = 0;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    UIView *footv = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableFooterView = footv;
    self.dataSource = self;
    self.delegate   = self;
    self.is_GestureEvent = NO;
    self.Page       = DefaultPAGE;
    self.is_refreshHeader = NO;
    self.is_refreshfoot   = NO;
    
}

- (void)dealloc {
    if (self.is_refreshHeader) {
        //删除指定的key路径监听器
        [self.mj_header removeObserver:self forKeyPath:@"state"];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([object isEqual:self.mj_header] && self.mj_header.state == MJRefreshStatePulling) {
        [self feedbackGenerator];
    }
    else if ([object isEqual:self.mj_footer] && self.mj_footer.state == MJRefreshStatePulling) {
        [self feedbackGenerator];
    }
}

- (void)feedbackGenerator {
    UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
    [generator prepare];
    [generator impactOccurred];
}

- (void)setupNewConfiguration {
    
}

/// 设置下啦刷新
- (void)setupPullHeaderRefresh {
    MJRefreshHeader *heade = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.mj_header = heade;
    // 增加KVO监听
    [self.mj_header addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
}

/// 设置上啦刷新
- (void)setupPushFootRefresh {
    MJRefreshFooter *footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    self.mj_footer = footer;
}

/// 设置上下啦刷新的代理
- (void)setRefreshDataType:(NSInteger)type {
    if (self.TT_delegate != nil && [self.TT_delegate respondsToSelector:@selector(refreshDataType:)]) {
        [self.TT_delegate refreshDataType:type];
    }
}

/// 设置上下 方向代理
- (void)setUpOrDownForScrollview:(UIScrollView *)Scrollview {
    BOOL YorN;
    if (Scrollview.contentOffset.y > self.oldcontentOffsetY) {
        YorN = NO;
    }else {
        YorN = YES;
    }
    if (self.TT_delegate != nil && [self.TT_delegate respondsToSelector:@selector(scrollviewSlideupandDown:scrollview:)]) {
        [self.TT_delegate scrollviewSlideupandDown:YorN scrollview:Scrollview];
    }
}

#pragma mark 存取方法

- (void)setHavemore:(BOOL)havemore {
    _havemore = havemore;
    if (self.is_refreshfoot && !havemore) {
        self.mj_footer.state = MJRefreshStateNoMoreData;
    }
}

- (void)setIs_refreshHeader:(BOOL)is_refreshHeader {
    _is_refreshHeader = is_refreshHeader;
    if (is_refreshHeader) {
        [self setupPullHeaderRefresh];
    }
}

- (void)setIs_refreshfoot:(BOOL)is_refreshfoot {
    _is_refreshfoot = is_refreshfoot;
    if (is_refreshfoot) {
        [self setupPushFootRefresh];
    }
}

- (TT_TitleV *)BigTitleV {
    if (!_BigTitleV) {
        _BigTitleV  = [[TT_TitleV alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 52)];
    }
    return _BigTitleV;
}

- (TT_NothingV *)NothingV {
    if (!_NothingV) {
        IPhoneXHeigh
        _NothingV = [[TT_NothingV alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, security_H)];
    }
    return _NothingV;
}

- (NSMutableArray *)infodata {
    if (!_infodata) {
        _infodata = [NSMutableArray new];
    }
    return _infodata;
}


@end
