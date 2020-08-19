//
//  TT_Lable.h
//  XXX
//
//  Created by MacBook Pro on 2019/8/9.
//  Copyright @ 2019 绑耀 All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger{
    CopylabWitNomal = 0,
    CopylabWithOrder,
}CopyLabType;

NS_ASSUME_NONNULL_BEGIN

@interface TT_Lable : UILabel
@property(nonatomic,assign)CopyLabType copyLabType;

@end

NS_ASSUME_NONNULL_END
