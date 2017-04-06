//
//  HLConfig.h
//  HeLiangFrame
//
//  Created by heliang on 2017/3/31.
//  Copyright © 2017年 heliang. All rights reserved.
//

#ifndef HLConfig_h
#define HLConfig_h

typedef enum HttpMethod:NSUInteger{
    GET,
    MULTI,
    POST,
    PUT,
    DELETE
}HttpMethod;

//定义返回请求数据的block类型
typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);
typedef void (^NetWorkBlock)(BOOL netConnetState);

#endif /* HLConfig_h */
