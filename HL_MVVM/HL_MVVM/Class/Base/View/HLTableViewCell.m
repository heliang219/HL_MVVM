//
//  HLTableViewCell.m
//  HeLiangFrame
//
//  Created by heliang on 2017/3/31.
//  Copyright © 2017年 heliang. All rights reserved.
//

#import "HLTableViewCell.h"

@implementation HLTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self hl_setupViews];
        [self hl_bindViewModel];
        
    }
    return self;
}


- (void)hl_setupViews{
}

- (void)hl_bindViewModel{}
@end
