//
//  TT_NothingV.h
//  捕鱼达人
//
//  Created by tengtengdang on 2019/4/15.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "TT_BaseV.h"


@interface TT_NothingV : TT_BaseV

@property (nonatomic , strong) UIImageView *ImageLayer;

@property (nonatomic , strong) CATextLayer *textLayer;

@property (nonatomic , assign) BOOL is_tap;

/// 设置图片和文字
- (void)configImageName:(NSString *)ImaageName
              titleName:(NSString *)titleName
                 is_Tap:(BOOL)is_Tap;

@end

