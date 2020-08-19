//
//  TT_RequsetFailV.h
//  XXX
//
//  Created by 樊腾 on 2019/11/14.
//  Copyright © 2019 绑耀. All rights reserved.
//

#import "TT_BaseV.h"
#if __has_include(<YYKit/YYKit.h>)
#import <TT_CommentCat/TT_CommentCat.h>
#else
#import "TT_CommentCat.h"
#endif


@interface TT_RequsetFailV : TT_BaseV
/// 图片
@property (nonatomic , strong) UIImageView *headerimg;
/// 内容
@property (nonatomic , strong) UILabel *titlelabel;
/// 按钮
@property (nonatomic , strong) UIButton *refbtn;


- (void)configheaderimgstr:(NSString *)imgstr
                  titleStr:(NSString *)titleStr
                    refstr:(NSString *)refstr;


- (void)configheaderimgstr:(NSString *)imgstr
                 imageSize:(CGSize)imagesize
                  titleStr:(NSString *)titleStr
                    refstr:(NSString *)refstr;
@end

