//
//  HLStartAPP.m
//  HeLiangFrame
//
//  Created by heliang on 2017/3/31.
//  Copyright © 2017年 heliang. All rights reserved.
//

#import "HLStartAPP.h"

@implementation HLStartAPP

+ (void)load {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        [[self class] hl_initPersonData];
        [[self class] hl_setSVProgressHUD];
        [[self class] hl_setKeyBord];
        [[self class] hl_testReachableStaus];
        
        
    });
}

#pragma mark - 初始化个人数据
+ (void)hl_initPersonData {
    
}

+(void)hl_setSVProgressHUD{
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setInfoImage:nil];
}

#pragma mark - 键盘回收相关
+ (void)hl_setKeyBord {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
}

#pragma mark － 检测网络相关
+ (void)hl_testReachableStaus {
    [HLNetWorking netWorkReachability:^(BOOL netConnetState) {
        if (!netConnetState) {
            [SVProgressHUD showErrorWithStatus:@"亲，网络貌似不给力哦！"];
        }
    }];
}

@end
