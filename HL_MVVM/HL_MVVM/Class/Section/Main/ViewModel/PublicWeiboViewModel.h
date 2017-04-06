//
//  PublicWeiboViewModel.h
//  HeLiangFrame
//
//  Created by heliang on 2017/4/1.
//  Copyright © 2017年 heliang. All rights reserved.
//

#import "HLViewModel.h"

@interface PublicWeiboViewModel : HLViewModel

@property (nonatomic, strong) RACCommand *refreshDataCommand;
@property (nonatomic, strong) RACCommand *nextPageCommand;

@property (nonatomic, strong) RACSubject *cellClickSubject;
@property (nonatomic, strong) RACSubject *refreshEndSubject;

@property (nonatomic, strong) NSArray *dataArray;
@end
