//
//  TT_ViewAppearOrdisappear.h
//  tengteng
//
//  Created by tengtengdang on 2019/3/19.
//  Copyright © 2019 腾腾. All rights reserved.
//

#import "TT_BaseV.h"

NS_ASSUME_NONNULL_BEGIN

@interface TT_ViewAppearOrdisappear : TT_BaseV
/// 添加自定义控件
- (void)configCustomcontrols:(UIView *)CustomV;
- (void)show;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
