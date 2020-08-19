

//
//  TT_BaseScrollView.m
//   
//
//  Created by 樊腾 on 2020/4/9.
//  Copyright © 2020 绑耀. All rights reserved.
//

#import "TT_BaseScrollView.h"

@implementation TT_BaseScrollView


#pragma mark 生命周期

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self tengteng_config];
    }
    return self;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self tengteng_config];
    }
    return self;
}

#pragma mark 代理回调

///scrollView正在滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (self.TTscrolldelegate && [self.TTscrolldelegate respondsToSelector:@selector(TT_scrollViewDidScroll:)]) {
        [self.TTscrolldelegate TT_scrollViewDidScroll:scrollView];
    }
}

/////scrollView正在放大或缩小
//- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
//
//}
// 开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.TTscrolldelegate && [self.TTscrolldelegate respondsToSelector:@selector(scrollviewisslippagetyep:ScrollView:)]) {
        [self.TTscrolldelegate scrollviewisslippagetyep:0 ScrollView:scrollView];
    }
}
//// 将要结束拖拽
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {

}
//已经结束拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.TTscrolldelegate && [self.TTscrolldelegate respondsToSelector:@selector(scrollviewisslippagetyep:ScrollView:)]) {
        [self.TTscrolldelegate scrollviewisslippagetyep:1 ScrollView:scrollView];
    }
}
//将开始减速
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {

}
//减速完成，视图停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
     if (self.TTscrolldelegate && [self.TTscrolldelegate respondsToSelector:@selector(scrollviewisslippagetyep:ScrollView:)]) {
          [self.TTscrolldelegate scrollviewisslippagetyep:0 ScrollView:scrollView];
      }
}
//滚动动画已经停止执行
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {

}

//视图将要开始放大或缩小
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view {

}
//视图完成放大或缩小
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {

}
//轻点状态栏，滚动视图会一直滚动到顶部，那是默认行为YES，你可以通过该方法返回NO来关闭它
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    return YES;
}

//视图已经滚动到顶部调用
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {

}





- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.TTscrolldelegate respondsToSelector:@selector(nestScrollView:gestureRecognizerShouldBegin:)]) {
        return [self.TTscrolldelegate nestScrollView:self gestureRecognizerShouldBegin:gestureRecognizer];
    }
    return YES;
}

// 返回YES表示可以继续传递触摸事件，这样两个嵌套的scrollView才能同时滚动
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([self.TTscrolldelegate respondsToSelector:@selector(nestScrollView:gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:)]) {
        return [self.TTscrolldelegate nestScrollView:self gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
    }
    return self.isgestureEvent;
}



#pragma mark 触发方法

#pragma mark 公开方法

- (void)tengteng_changeDefault {
    
}

- (void)tengteng_addsubviewS {
    
}

- (void)tengteng_setupFrameS {
    
}

#pragma mark 私有方法

- (void)tengteng_configDefault {
    
    self.isgestureEvent = YES;
    self.delegate = self;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    [self tengteng_addsubviewS];
}


- (void)tengteng_config {
    [self tengteng_configDefault];
    [self tengteng_changeDefault];
}





@end
