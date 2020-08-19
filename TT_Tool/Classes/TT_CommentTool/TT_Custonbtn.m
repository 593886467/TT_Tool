//
//  Custonbtn.m
//  95128
//
//  Created by 樊腾 on 17/7/10.
//  Copyright © 2017年 FTT. All rights reserved.
//

#import "TT_Custonbtn.h"

@implementation TT_Custonbtn

//设置图片的位置
- (CGRect)imageRectForContentRect:(CGRect)bounds{

    if (self.type == UIButtonTitleAndImageTypeLift) {
        return CGRectMake(self.frame.size.width / 2 - (self.ImageW + self.TtileW) / 2 + self.PYX , self.frame.size.height / 2 - self.ImageH / 2, self.ImageW, self.ImageH);
    }else if (self.type == UIButtonTitleAndImageTypeRight){
        return CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + 4, self.frame.size.height / 2 - self.ImageH / 2, self.ImageW, self.ImageH);
    }else if (self.type == UIButtonTitleAndImageTypeTop){
        return CGRectMake(self.frame.size.width /2 - self.ImageW /2 , self.frame.size.height / 2 - (self.ImageH + self.TitleH + self.PYX) /2 , self.ImageW, self.ImageH);
    }else if(self.type == UIButtonTitleAndImageTypeBottom){
        return CGRectMake(self.frame.size.width / 2 - self.ImageW / 2 , CGRectGetMaxY(self.titleLabel.frame) +self.PYX , self.ImageW, self.ImageH);
    }else {
        return bounds;
    }

}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {

    if (self.type == UIButtonTitleAndImageTypeLift) {
        return CGRectMake(CGRectGetMaxX(self.imageView.frame) + 4, 0, self.TtileW, self.TitleH);
    }else if (self.type == UIButtonTitleAndImageTypeRight) {
        return CGRectMake(self.frame.size.width / 2 - (self.ImageW +  self.TtileW + 4) /2  + self.PYX, 0, self.TtileW, self.TitleH);
    }else if (self.type == UIButtonTitleAndImageTypeTop) {
        return CGRectMake(0,CGRectGetMaxY(self.imageView.frame) + self.PYX  , self.frame.size.width, self.TitleH);
    }else if(self.type == UIButtonTitleAndImageTypeBottom){
        return CGRectMake(0, self.frame.size.height / 2 - (self.ImageH + self.TitleH + self.PYX)/2, self.frame.size.width, self.TitleH);
    }else {
        return contentRect;
    }
}

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.PYX = 0;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}


- (void)comfigurlImagurl:(NSString *)imageurl {
    
}


- (void)setIs_geust:(BOOL)is_geust {
    if (is_geust) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(changePostion:)];
        [self addGestureRecognizer:pan];
    }
}


- (void)changePostion:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan translationInView:self];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height - 40;
    CGRect originalFrame = self.frame;
    if (originalFrame.origin.x >= 0 && originalFrame.origin.x+originalFrame.size.width <= width) {
        originalFrame.origin.x += point.x;
    }if (originalFrame.origin.y >= 0 && originalFrame.origin.y+originalFrame.size.height <= height) {
        originalFrame.origin.y += point.y;
    }
    self.frame = originalFrame;
    [pan setTranslation:CGPointZero inView:self];
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.userInteractionEnabled = NO;
    }else if (pan.state == UIGestureRecognizerStateChanged){
        
    } else {
        CGRect frame = self.frame;
        //是否越界
        BOOL isOver = NO;
        if (frame.origin.x < 0) {
            frame.origin.x = 0;
            isOver = YES;
        } else if (frame.origin.x+frame.size.width > width) {
            frame.origin.x = width - frame.size.width;
            isOver = YES;
        }
        if (frame.origin.y < 0) {
            frame.origin.y = 0;
            isOver = YES;
        }else if (frame.origin.y+frame.size.height > height) {
            frame.origin.y = height - frame.size.height;
            isOver = YES;
        }
        if (!isOver) {
            if (self.center.x>width/2.0) {
                frame.origin.x = width - frame.size.width;
            }else{
                frame.origin.x = 0;
            }
        }
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = frame;
        }];
        self.userInteractionEnabled = YES;
    }
}

@end
