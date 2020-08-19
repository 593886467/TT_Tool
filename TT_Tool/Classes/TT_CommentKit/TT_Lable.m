//
//  TT_Lable.m
//  XXX
//
//  Created by MacBook Pro on 2019/8/9.
//  Copyright @ 2019 绑耀 All rights reserved.
//

#import "TT_Lable.h"

@implementation TT_Lable
-(BOOL)canBecomeFirstResponder {
    
    
    
    return YES;
    
}



// 可以响应的方法

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    
    
    return (action == @selector(copy:));
    
}

//针对于响应方法的实现

-(void)copy:(id)sender {
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    if (self.copyLabType == CopylabWithOrder && self.text.length>0) {
        NSString *orderStr = [ self.text substringFromIndex:3];
        pboard.string = orderStr;
    }
    else
    {
        pboard.string = self.text;

    }
}



//UILabel默认是不接收事件的，我们需要自己添加touch事件

-(void)attachTapHandler {
    
    self.userInteractionEnabled = YES;
    
    UILongPressGestureRecognizer *touch = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:touch];
}



//绑定事件

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self attachTapHandler];
        
    }
    
    return self;
    
}
-(void)awakeFromNib {
    
    
    
    [super awakeFromNib];
    
    [self attachTapHandler];
    
}



-(void)handleTap:(UIGestureRecognizer*) recognizer {
    [self becomeFirstResponder];
    UIMenuItem *copyLink = [[UIMenuItem alloc] initWithTitle:@"复制"
                                                      action:@selector(copy:)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:copyLink, nil]];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated: YES];
    
}

@end
