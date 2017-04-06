//
//  HLViewController.m
//  HeLiangFrame
//
//  Created by heliang on 2017/3/31.
//  Copyright © 2017年 heliang. All rights reserved.
//

#import "HLViewController.h"

@interface HLViewController ()

@end

@implementation HLViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    HLViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        
        @strongify(viewController)
        [viewController hl_addSubviews];
        [viewController hl_bindViewModel];
    }];
    
    [[viewController rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        
        @strongify(viewController)
        [viewController hl_layoutNavigation];
        [viewController hl_getNewData];
    }];
    
    return viewController;
}

- (instancetype)initWithViewModel:(id<HLViewModelProtocol>)viewModel {
    
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  添加控件
 */
- (void)hl_addSubviews {}

/**
 *  绑定
 */
- (void)hl_bindViewModel {}

/**
 *  设置navation
 */
- (void)hl_layoutNavigation {}

/**
 *  初次获取数据
 */
- (void)hl_getNewData {}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
