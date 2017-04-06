//
//  PublicModel.h
//  HeLiangFrame
//
//  Created by heliang on 2017/4/1.
//  Copyright © 2017年 heliang. All rights reserved.
//

#import "HLModel.h"
#import "UserInfo.h"

@interface PublicModel : HLModel

@property (strong, nonatomic) NSString *weiboId;
@property (strong, nonatomic) NSString *text;
@property (nonatomic,strong) UserInfo *user;

@end
