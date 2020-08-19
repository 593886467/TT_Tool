//
//  TT_CycleCollectionViewFlowLayout.m
//  TT_CollectionV
//
//  Created by tengtengdang on 2019/3/28.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "TT_CycleCollectionViewFlowLayout.h"

@interface TT_CycleCollectionViewFlowLayout ()

@property (nonatomic, assign) UIEdgeInsets sectionInsets;
@property (nonatomic, assign) CGFloat miniLineSpace;
@property (nonatomic, assign) CGFloat miniInterItemSpace;
@property (nonatomic, assign) CGSize eachItemSize;
@property (nonatomic, assign) BOOL scrollAnimation;/**<是否有分页动画*/
@property (nonatomic, assign) CGPoint lastOffset;/**<记录上次滑动停止时contentOffset值*/

@end

@implementation TT_CycleCollectionViewFlowLayout

@end
