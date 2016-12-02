//
//  UserInfor.m
//  HHSdk
//
//  Created by mac on 11/15/16.
//  Copyright © 2016 Hoàng Hiệp. All rights reserved.
//

#import "UserInfor.h"

@implementation UserInfor
@synthesize username=_username;
@synthesize email=_email;
@synthesize picture=_picture;
@synthesize coin=_coin;
+ (UserInfor *)sharedInstance {
    static dispatch_once_t onceToken;
    static UserInfor *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[UserInfor alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self)
    {
        _username=@"";
        _email=@"";
        _picture=@"";
        _coin=0;
    }
    return self;
}
- (void)ClearMe {
    _username=@"";
    _email=@"";
    _picture=@"";
    _coin=0;
}
@end
