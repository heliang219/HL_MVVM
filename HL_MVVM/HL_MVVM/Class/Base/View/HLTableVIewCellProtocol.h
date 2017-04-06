//
//  HLTableVIewCellProtocol.h
//  HeLiangFrame
//
//  Created by heliang on 2017/4/1.
//  Copyright © 2017年 heliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HLTableVIewCellProtocol <NSObject>

@optional

- (void)hl_setupViews;
- (void)hl_bindViewModel;

@end
