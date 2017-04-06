//
//  HLNetWorking.m
//  HeLiangFrame
//
//  Created by heliang on 2017/3/31.
//  Copyright © 2017年 heliang. All rights reserved.
//

#import "HLNetWorking.h"

@implementation HLNetWorking

#pragma 监测网络的可链接性
+ (void) netWorkReachability:(NetWorkBlock)isConnection
{
    //1.创建网络状态监测管理者
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    //2.监听改变
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                isConnection(status);
                break;
            case AFNetworkReachabilityStatusNotReachable:
                isConnection(status);
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                isConnection(status);
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                isConnection(status);
                break;
            default:
                isConnection(status);
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
}

+ (instancetype)request {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _operationManager = [AFHTTPSessionManager manager];
        _operationManager.requestSerializer.timeoutInterval = 10;
        _operationQueue = _operationManager.operationQueue;
    }
    return self;
}

- (void)NetRequestWithParameters:(NSDictionary *)params
        httpMethod:(HttpMethod)method
         requestURL:(NSString *)server
     completeBlock:(ReturnValueBlock)completeblock
        errorBlock:(ErrorCodeBlock)errorblock
{
    
    if (
        method == GET) {
        [_operationManager GET:server parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *returnDict = (NSDictionary *)responseObject;
            if (completeblock) {
                completeblock(returnDict);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (errorblock) {
                errorblock(error);
            }
        }];
    }
    if (method == POST) {
        [_operationManager POST:server parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *returnDict = (NSDictionary *)responseObject;
            if (completeblock) {
                completeblock(returnDict);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (errorblock) {
                errorblock(error);
            }
        }];
    }
    
    if (method == PUT) {
        [_operationManager PUT:server parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *returnDict = (NSDictionary *)responseObject;
            if (completeblock) {
                completeblock(returnDict);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (errorblock) {
                errorblock(error);
            }
        }];
    }
    
    if (method == DELETE) {
        [_operationManager DELETE:server parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *returnDict = (NSDictionary *)responseObject;
            if (completeblock) {
                completeblock(returnDict);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (errorblock) {
                errorblock(error);
            }
        }];
    }

}

- (void)cancelAllOperations{
    [self.operationQueue cancelAllOperations];
}

@end
