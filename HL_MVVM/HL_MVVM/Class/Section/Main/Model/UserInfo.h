//
//  UserInfo.h
//  HeLiangFrame
//
//  Created by heliang on 2017/4/1.
//  Copyright © 2017年 heliang. All rights reserved.
//

#import "HLModel.h"

@interface UserInfo : HLModel

@property (nonatomic,copy) NSString *userId;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSURL *profile_image_url;
@property (nonatomic,copy) NSString *location;

@end
