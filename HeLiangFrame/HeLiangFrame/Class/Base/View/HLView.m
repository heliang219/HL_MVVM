//
//  HLView.m
//  HeLiangFrame
//
//  Created by heliang on 2017/3/31.
//  Copyright © 2017年 heliang. All rights reserved.
//

#import "HLView.h"
#import "AppDelegate.h"


@implementation HLView 

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self hl_setupViews];
        [self hl_bindViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<HLViewModelProtocol>)viewModel {
    
    self = [super init];
    if (self) {
        [self hl_setupViews];
        [self hl_bindViewModel];
    }
    return self;
}

- (void)hl_bindViewModel {
}

- (void)hl_setupViews {
}

- (void)hl_addReturnKeyBoard {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [tap.rac_gestureSignal subscribeNext:^(id x) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.window endEditing:YES];
    }];
    [self addGestureRecognizer:tap];
}

@end
