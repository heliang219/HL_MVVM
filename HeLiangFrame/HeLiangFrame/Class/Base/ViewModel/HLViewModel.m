//
//  HLViewModel.m
//  HeLiangFrame
//
//  Created by heliang on 2017/3/31.
//  Copyright © 2017年 heliang. All rights reserved.
//

#import "HLViewModel.h"

@implementation HLViewModel

@synthesize request  = _request;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    HLViewModel *viewModel = [super allocWithZone:zone];
    
    if (viewModel) {
        
        [viewModel hl_initialize];
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model {
    
    self = [super init];
    if (self) {
    }
    return self;
}

- (HLNetWorking *)request {
    
    if (!_request) {
        
        _request = [HLNetWorking request];
    }
    return _request;
}

- (void)hl_initialize {
}

@end
