//
//  TT_BaseCollectionViewCell.h
//  TT_CollectionV
//
//  Created by tengtengdang on 2019/3/28.
//  Copyright © 2019 FTT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TT_BaseCollectionViewCell : UICollectionViewCell

/// 数据
@property (nonatomic , strong) id Data;
/// 回调
@property (nonatomic , copy) void(^CollectionCellBlock)(NSInteger num , id Data);
/// 添加视图
- (void)tt_setupSubViewS;
/// 设置Frame
- (void)tt_setupSubFrameS;
/// 配置数据
- (void)configforData:(id)Data;

- (void)configCloseType:(NSInteger)type Data:(id)Data;


@end

NS_ASSUME_NONNULL_END
