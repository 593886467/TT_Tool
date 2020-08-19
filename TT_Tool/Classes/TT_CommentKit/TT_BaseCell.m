//
//  TT_BaseCell.m
//  tengteng
//
//  Created by tengtengdang on 2018/8/23.
//  Copyright © 2018年 腾腾. All rights reserved.
//

#import "TT_BaseCell.h"
#import <objc/runtime.h>

@interface TT_BaseCell ()


@end

@implementation TT_BaseCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


#pragma mark 生命周期

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviewS];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableview CellClass:(Class)cellClass {
    NSString *className = [NSString stringWithUTF8String:class_getName(cellClass)];
    TT_BaseCell* cell = (TT_BaseCell*)[tableview dequeueReusableCellWithIdentifier:className];
    if (cell == nil) {
       cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
    }
    return cell;
}

- (instancetype)cellwithTableview:(UITableView *)tableview cellclass:(Class)cellclass {
    NSString *classname = [NSString stringWithUTF8String:class_getName(cellclass)];
    TT_BaseCell *cell = [tableview dequeueReusableCellWithIdentifier:classname];
    if (!cell) {
       cell = [[cellclass alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:classname];
    }
    return cell;
}
#pragma mark 触发方法

#pragma mark 公开方法

- (void)configData:(id)Data {
    
}

- (void)setupSubviewS {

}

- (void)setupSubViewsFrame {
    
}

- (void)configtapclose:(NSInteger)num {
    if (self.currencyClose) {
        self.currencyClose(num);
    }
}


#pragma mark 私有方法

@end
