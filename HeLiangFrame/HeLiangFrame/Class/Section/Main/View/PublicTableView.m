//
//  PublicTableView.m
//  HeLiangFrame
//
//  Created by heliang on 2017/4/1.
//  Copyright © 2017年 heliang. All rights reserved.
//

#import "PublicTableView.h"
#import "PublicWeiboViewModel.h"
#import "PublicCell.h"


static NSString * cellIdentifier = @"PublicCell";

@interface PublicTableView () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) PublicWeiboViewModel *viewModel;
@property (strong, nonatomic) UITableView *mainTableView;

@end

@implementation PublicTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - system

- (instancetype)initWithViewModel:(id<HLViewModelProtocol>)viewModel {
    self.viewModel = (PublicWeiboViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)updateConstraints {

    @weakify(self);
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self);
    }];
     [super updateConstraints];
}

#pragma mark - private
- (void)hl_setupViews {
    [self addSubview:self.mainTableView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)hl_bindViewModel {
    
    [self.viewModel.refreshDataCommand execute:nil];
    
    @weakify(self);
    [self.viewModel.refreshEndSubject subscribeNext:^(id x) {
        @strongify(self);
        [self.mainTableView reloadData];
        
        switch ([x integerValue]) {
          
            case HLHeaderRefreshData: {
                
                [self.mainTableView.mj_header endRefreshing];
                [self.mainTableView.mj_footer resetNoMoreData];
                [self.mainTableView.mj_footer endRefreshing];
                _mainTableView.mj_footer.hidden = NO;
            }
                break;
            case HLFooterLoadMoreData: {
                
                [self.mainTableView.mj_header endRefreshing];
                [self.mainTableView.mj_footer endRefreshing];
                
                if (self.mainTableView.mj_footer == nil) {
                    self.mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                        @strongify(self);
                        [self.viewModel.nextPageCommand execute:nil];
                    }];
                }
            }
                break;
            case HLHeaderRefreshNoMoreData: {
    
                [self.mainTableView.mj_header endRefreshing];
                self.mainTableView.mj_footer = nil;
            }
                break;
                
            case HLFooterLoadNoMoreData: {
                
                [self.mainTableView.mj_header endRefreshing];
                [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
                
            }
                break;
            case HLRefreshError: {
                
                [self.mainTableView.mj_footer endRefreshing];
                [self.mainTableView.mj_header endRefreshing];
            }
                break;
            default:
                break;
        }
    }];
    
}


#pragma mark - lazyLoad
- (PublicWeiboViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[PublicWeiboViewModel alloc] init];
    }
    return _viewModel;
}

- (UITableView *)mainTableView {
    
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] init];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_mainTableView registerClass:[PublicCell class] forCellReuseIdentifier:cellIdentifier];
        @weakify(self);
        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            [self.viewModel.refreshDataCommand execute:nil];
        }];
        
        _mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self.viewModel.nextPageCommand execute:nil];
        }];
        
        _mainTableView.mj_footer.hidden = YES;
        
    }
    return _mainTableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PublicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(PublicCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.model = self.viewModel.dataArray[indexPath.row];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:@"PublicCell" cacheByIndexPath:indexPath configuration:^(PublicCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel.cellClickSubject sendNext:self.viewModel.dataArray[indexPath.row]];
}

@end
