//
//  TT_BaseC.h
//  tengteng
//
//  Created by tengtengdang on 2019/3/19.
//  Copyright © 2019 腾腾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+TT_ConfigNet.h"
#import "TT_BaseVM.h"
#import "TT_BaceProtocol.h"
#import "TT_GeneralProfile.h"
NS_ASSUME_NONNULL_BEGIN

@interface TT_BaseC : UIViewController<TT_BaceProtocol>
@property (nonatomic , strong) TT_BaseVM *VM;
@property (nonatomic , strong) UIButton *tt_custonBack;
@property (nonatomic , assign) BOOL is_hideback;
@end

NS_ASSUME_NONNULL_END
