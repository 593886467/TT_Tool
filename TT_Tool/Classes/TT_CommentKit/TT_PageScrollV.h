//
//  TT_PageScrollV.h
//  XXX
//
//  Created by 樊腾 on 2019/9/22.
//  Copyright © 2019 绑耀. All rights reserved.
//

#import "TT_BaseV.h"
#import "TT_PageTabItemLable.h"

typedef NS_ENUM(NSInteger, TT_PageTabTitleStyle) {
    TT_PageTabTitleStyleDefault, //正常
    TT_PageTabTitleStyleGradient, //渐变
    TT_PageTabTitleStyleBlend , //填充
    TT_PageTabTitleStyleBg      // 背景
};

typedef NS_ENUM(NSInteger, TT_PageTabIndicatorStyle) {
    TT_PageTabIndicatorStyleDefault, //正常，自定义宽度
    TT_PageTabIndicatorStyleFollowText, //跟随文本长度变化
    TT_PageTabIndicatorStyleStretch, //拉伸
    TT_PageTabIndicatorStyleBg
};

@protocol TT_PageTabViewDelegate <NSObject>

@optional

- (void)titleColorBeginChange:(NSInteger)selectIndex;
/*切换完成代理方法*/
- (void)pageTabViewDidEndChange;

- (void)pageContentScrollViewWillBeginDragging;

@end

NS_ASSUME_NONNULL_BEGIN

@interface TT_PageScrollV : TT_BaseV

@property (nonatomic, weak) id<TT_PageTabViewDelegate> delegate;

//tab
@property (nonatomic, strong) UIScrollView *tabView;
@property (nonatomic, strong) UIView *indicatorView;

//body
@property (nonatomic, strong) UIScrollView *bodyView;

/*设置当前选择项（无动画效果）*/
@property (nonatomic, assign) NSInteger selectedTabIndex;
/*一页展示最多的item个数，如果比item总数少，按照item总数计算*/
@property (nonatomic, assign) NSInteger maxNumberOfPageItems;
/*tab size，默认(self.width, 38.0)*/
@property (nonatomic, assign) CGSize tabSize;
/*item的字体大小*/
@property (nonatomic, strong) UIFont *tabItemFont;
/*未选择颜色*/
@property (nonatomic, strong) UIColor *unSelectedColor;
/*当前选中颜色*/
@property (nonatomic, strong) UIColor *selectedColor;
/*tab背景色，默认white*/
@property (nonatomic, strong) UIColor *tabBackgroundColor;
/*body背景色，默认white*/
@property (nonatomic, strong) UIColor *bodyBackgroundColor;
/// 字体背景颜色
@property (nonatomic , strong) UIColor *title_BGColor;
/// 字体背景模块
@property (nonatomic , strong) UIView *title_BG;


/*是否打开body的边界弹动效果*/
@property (nonatomic, assign) BOOL bodyBounces;

@property (nonatomic, strong) NSMutableArray *tabItems;

/*Title效果设置*/
@property (nonatomic, assign) TT_PageTabTitleStyle titleStyle;
/*字体渐变，未选择的item的scale，默认是0.8（0~1）。仅XXPageTabTitleStyleScale生效*/
@property (nonatomic, assign) CGFloat minScale;

/*Indicator效果设置*/
@property (nonatomic, assign) TT_PageTabIndicatorStyle indicatorStyle;
/*下标高度，默认是2.0*/
@property (nonatomic, assign) CGFloat indicatorHeight;
/*下标宽度，默认是0。XXPageTabIndicatorStyleFollowText时无效*/
@property (nonatomic, assign) CGFloat indicatorWidth;
/** 已购 下边增加的下划线*/
@property (nonatomic, assign)NSInteger   isShowLine;

@property (nonatomic , assign) CGFloat tabItemX;
/// 倒叙
@property (nonatomic , assign) BOOL Is_exchange;
/// body 是否滚动
@property (nonatomic , assign) BOOL is_bodyScroll;

- (instancetype)initWithChildControllers:(NSArray<UIViewController *> *)childControllers
                             childTitles:(NSArray<NSString *> *)childTitles;

- (instancetype)initWithFrame:(CGRect)frame Controllers:(NSArray<UIViewController *> *)childControllers childTitles:(NSArray<NSString *> *)childTitles;

- (void)configControllers:(NSArray<UIViewController *> *)childControllers childTitles:(NSArray<NSString *> *)childTitles;
@end

NS_ASSUME_NONNULL_END
