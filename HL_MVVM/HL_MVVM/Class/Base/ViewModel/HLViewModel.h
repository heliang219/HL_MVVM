//
//  HLViewModel.h
//  HeLiangFrame
//
//  Created by heliang on 2017/3/31.
//  Copyright © 2017年 heliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLViewModelProtocol.h"

@interface HLViewModel : NSObject<HLViewModelProtocol>

@property (strong, nonatomic)HLNetWorking *request;

@end
