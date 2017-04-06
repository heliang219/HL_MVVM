//
//  ViewController.m
//  HeLiangFrame
//
//  Created by heliang on 2017/3/30.
//  Copyright © 2017年 heliang. All rights reserved.
//

#import "ViewController.h"
#import "PublicTableView.h"
#import "PublicWeiboViewModel.h"

@interface ViewController ()
@property (nonatomic, strong) PublicTableView *mainView;

@property (nonatomic, strong) PublicWeiboViewModel *viewModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor  = [ UIColor redColor];
    
}

#pragma mark - system

- (void)updateViewConstraints {
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private

- (void)hl_addSubviews {
    [self.view addSubview:self.mainView];    
}

- (void)hl_bindViewModel {
    
    //@weakify(self);
    [[self.viewModel.cellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        //@strongify(self);
        
//        YDViewController *circleMainVC = [[YDViewController alloc] init];
//        [self.navigationController pushViewController:circleMainVC animated:YES];
    }];
}

- (void)hl_layoutNavigation {
    
    self.title = @"微博列表";
}

#pragma mark - layzLoad
- (PublicTableView *)mainView {
    if (!_mainView) {
        _mainView = [[PublicTableView alloc] initWithViewModel:self.viewModel];
        
    }
    return _mainView;
}

- (PublicWeiboViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[PublicWeiboViewModel alloc] init];
    }
    return _viewModel;
}

@end
