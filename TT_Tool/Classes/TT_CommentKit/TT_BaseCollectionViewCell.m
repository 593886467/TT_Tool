//
//  TT_BaseCollectionViewCell.m
//  TT_CollectionV
//
//  Created by tengtengdang on 2019/3/28.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "TT_BaseCollectionViewCell.h"

@implementation TT_BaseCollectionViewCell

#pragma mark 生命周期
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self tt_setupSubViewS];
    }
    return self;
}

#pragma mark 回调协议

#pragma mark 触发方法

#pragma mark 公开方法

- (void)tt_setupSubViewS {
    
}

- (void)tt_setupSubFrameS {
    
}

- (void)configforData:(id)Data {
    
}
/// 设置统一回调
- (void)configCloseType:(NSInteger)type Data:(id)Data {
    if (self.CollectionCellBlock) {
        self.CollectionCellBlock(type, Data);
    }
}



#pragma mark 私有方法



#pragma mark 存取方法


- (void)setData:(id)Data {
    _Data = Data;
    [self configforData:Data];
}
@end
