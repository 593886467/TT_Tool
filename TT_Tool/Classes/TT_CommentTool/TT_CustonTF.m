//
//  FTT_CustonTF.m
//  95128-Driver
//
//  Created by 樊腾 on 17/8/30.
//  Copyright © 2017年 FTT. All rights reserved.
//

#import "TT_CustonTF.h"

@implementation TT_CustonTF

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, self.leftView.frame.size.width +  10, 0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, self.leftView.frame.size.width +  10, 0);
}
@end
