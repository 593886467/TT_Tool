//
//  PZ_TitleV.h
//  tengteng
//
//  Created by 腾腾 on 2018/1/24.
//  Copyright © 2018年 腾腾. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface TT_TitleV : UIView

@property (nonatomic , strong) NSString *title;

@property (nonatomic , strong) NSString *ImageName;

@property (nonatomic , strong) UIButton *ImageLayer;
/**图 事件 */
@property (nonatomic ,copy)void (^SearchClick)(void);
@end
