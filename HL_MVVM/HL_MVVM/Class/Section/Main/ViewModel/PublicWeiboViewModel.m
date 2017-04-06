//
//  PublicWeiboViewModel.m
//  HeLiangFrame
//
//  Created by heliang on 2017/4/1.
//  Copyright © 2017年 heliang. All rights reserved.
//

#import "PublicWeiboViewModel.h"
#import "PublicModel.h"

@interface PublicWeiboViewModel ()

@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation PublicWeiboViewModel

-(void)hl_initialize{
    
    @weakify(self);
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSDictionary *dict) {
        @strongify(self);
        [PublicModel mj_setupObjectClassInArray:^NSDictionary *{
                                                    return @{
                                                       @"user" :                      @"UserInfo",
                                                            };
                                                }];
        
        self.dataArray = [PublicModel mj_objectArrayWithKeyValuesArray:dict[STATUSES]];
          [self.refreshEndSubject sendNext:@(HLHeaderRefreshData)];
          [SVProgressHUD dismiss];
    }];
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        if ([x isEqualToNumber:@(YES)]) {
            [SVProgressHUD showWithStatus:@"正在加载..."];
        }
    }];
    
    
    [self.nextPageCommand.executionSignals.switchToLatest subscribeNext:^(NSDictionary *dict) {
        
        @strongify(self);
        NSMutableArray *reArray = [[NSMutableArray alloc] initWithArray:self.dataArray];
        
        [PublicModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"user" :                      @"UserInfo",
                     };
        }];
        
        [reArray addObjectsFromArray:[PublicModel mj_objectArrayWithKeyValuesArray:dict[STATUSES]]];
        
        self.dataArray = reArray;
        
        //模拟数据加载完成，到第五页的时候就加载完成了
        if (self.currentPage == 5) {
            [self.refreshEndSubject sendNext:@(HLFooterLoadNoMoreData)];
        }else{
            [self.refreshEndSubject sendNext:@(HLFooterLoadMoreData)];
        }
        [SVProgressHUD dismiss];
    }];
}

- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                self.currentPage = 1;
                NSDictionary *parameter = @{TOKEN: ACCESSTOKEN,
                                            COUNT: PAGESIZE,
                                            PAGE: @(self.currentPage)
                                            };
                [self.request NetRequestWithParameters:parameter httpMethod:GET requestURL:REQUESTPUBLICURL completeBlock:^(id returnValue) {
                    [subscriber sendNext:returnValue];
                    [subscriber sendCompleted];
                } errorBlock:^(id errorCode) {
                    [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _refreshDataCommand;
}

- (RACCommand *)nextPageCommand {
    
    if (!_nextPageCommand) {
        
        @weakify(self);
        _nextPageCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                self.currentPage ++;
                //模拟数据翻页 所以会有重复 （主要是不知道为啥设置page这个参数无返回数据，暂时先这样模拟下喽，后续再研究下怎么个情况）
                NSDictionary *parameter = @{TOKEN: ACCESSTOKEN,
                                            COUNT: PAGESIZE,
                                            PAGE: @1
                                            //PAGE: @(self.currentPage)
                                            };
                
                [self.request NetRequestWithParameters:parameter httpMethod:GET requestURL:REQUESTPUBLICURL completeBlock:^(id returnValue) {
                    [subscriber sendNext:returnValue];
                    [subscriber sendCompleted];
                } errorBlock:^(id errorCode) {
                    @strongify(self);
                    self.currentPage --;
                    [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    
    return _nextPageCommand;
}

- (NSArray *)dataArray {

    if (!_dataArray) {
        
        _dataArray = [[NSArray alloc] init];
    }
    return _dataArray;
}

- (RACSubject *)cellClickSubject {
    
    if (!_cellClickSubject) {
        
        _cellClickSubject = [RACSubject subject];
    }
    return _cellClickSubject;
}

- (RACSubject *)refreshEndSubject {
    
    if (!_refreshEndSubject) {
        
        _refreshEndSubject = [RACSubject subject];
    }
    return _refreshEndSubject;
}
@end
