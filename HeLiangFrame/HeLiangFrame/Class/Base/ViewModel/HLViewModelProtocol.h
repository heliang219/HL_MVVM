//
//  HLViewModelProtocol.h
//  HeLiangFrame
//
//  Created by heliang on 2017/3/31.
//  Copyright © 2017年 heliang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    HLHeaderRefreshData = 1,
    HLHeaderRefreshNoMoreData,
    HLFooterLoadMoreData,
    HLFooterLoadNoMoreData,
    HLRefreshError,
    HLRefreshUI,
} HLDataStatus;

@protocol HLViewModelProtocol <NSObject>

@optional

- (instancetype)initWithModel:(id)model;

/**
 *  初始化
 */
- (void)hl_initialize;

@end
