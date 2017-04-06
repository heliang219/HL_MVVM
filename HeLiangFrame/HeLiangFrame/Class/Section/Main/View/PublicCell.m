//
//  PublicCell.m
//  HeLiangFrame
//
//  Created by heliang on 2017/4/1.
//  Copyright © 2017年 heliang. All rights reserved.
//

#import "PublicCell.h"
#import "UIImageView+AFNetworking.h"

@interface PublicCell ()
@property (strong, nonatomic)  UILabel *userName;
@property (strong, nonatomic)  UIImageView *headImageView;
@property (strong, nonatomic)  UILabel *weiboText;

@end

@implementation PublicCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)hl_setupViews{
    
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.userName];
    [self.contentView addSubview:self.weiboText];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints{
    
    CGFloat paddingEdge = 10;
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(paddingEdge);
        make.top.mas_equalTo(paddingEdge);
        make.size.mas_equalTo(CGSizeMake(80, 80)).priorityHigh();
    }];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(paddingEdge);
        make.top.equalTo(self.headImageView);
        make.right.mas_equalTo(-paddingEdge);
        make.height.mas_equalTo(15);
    }];

    [self.weiboText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_bottom).offset(paddingEdge);
        make.left.equalTo(self.headImageView);
        make.right.mas_equalTo(-paddingEdge);
        make.bottom.mas_equalTo(-paddingEdge);
    }];
    
    [super updateConstraints];
}

- (void)setModel:(PublicModel *)model {
    if (!model) {
        return;
    }
    _model = model;
    self.userName.text = model.user.name;
    self.weiboText.text = model.text;
    [self.headImageView setImageWithURL:model.user.profile_image_url];
}

#pragma mark - lazyLoad
- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
    }
    return _headImageView;
}

- (UILabel *)userName {
    if (!_userName) {
        _userName = [[UILabel alloc] init];
        _weiboText.numberOfLines = 1;
    }
    return _userName;
}

- (UILabel *)weiboText {
    if (!_weiboText) {
        _weiboText = [[UILabel alloc] init];
        _weiboText.numberOfLines = 0;
    }
    return _weiboText;
}

@end
