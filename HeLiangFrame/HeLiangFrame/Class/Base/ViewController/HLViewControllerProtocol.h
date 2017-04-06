//
//  HLViewControllerProtocol.h
//  HeLiangFrame
//
//  Created by heliang on 2017/4/1.
//  Copyright © 2017年 heliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HLViewModelProtocol;

@protocol HLViewControllerProtocol <NSObject>

@optional
- (instancetype)initWithViewModel:(id <HLViewModelProtocol>)viewModel;

- (void)hl_bindViewModel;
- (void)hl_addSubviews;

- (void)hl_getNewData;
- (void)hl_layoutNavigation;

//- (void)recoverKeyboard;

@end
