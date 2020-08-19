//
//  TT_BaseScrollView.h
//   
//
//  Created by 樊腾 on 2020/4/9.
//  Copyright © 2020 绑耀. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TT_BaseScrollView;
NS_ASSUME_NONNULL_BEGIN


@protocol TT_BaseScrollViewDelegate <NSObject>

/// scrollview 是否真实手动滑动 0   不滑动 1
@optional
- (void)scrollviewisslippagetyep:(NSInteger)type ScrollView:(UIScrollView *)ScrollView;
- (void)TT_scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)tengteng_configtapchilds:(NSInteger)num data:(id)data;
- (BOOL)nestScrollView:(TT_BaseScrollView *)scrollView gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer;

- (BOOL)nestScrollView:(TT_BaseScrollView *)scrollView gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;

@end

@interface TT_BaseScrollView : UIScrollView<UIScrollViewDelegate>
/// 是否响应多手势
@property (nonatomic , assign) BOOL isgestureEvent;
/// 回调
@property (nonatomic , weak) id <TT_BaseScrollViewDelegate> TTscrolldelegate;
/// 修改默认值 或 配置属性
- (void)tengteng_changeDefault;

- (void)tengteng_addsubviewS;

- (void)tengteng_setupFrameS;
@end

NS_ASSUME_NONNULL_END
