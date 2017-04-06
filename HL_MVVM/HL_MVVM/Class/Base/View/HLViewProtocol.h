//
//  HLViewProtocol.h
//  HeLiangFrame
//
//  Created by heliang on 2017/4/1.
//  Copyright © 2017年 heliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HLViewModelProtocol;

@protocol HLViewProtocol <NSObject>

@optional

- (instancetype)initWithViewModel:(id <HLViewModelProtocol>)viewModel;

- (void)hl_bindViewModel;
- (void)hl_setupViews;
- (void)hl_addReturnKeyBoard;

@end
