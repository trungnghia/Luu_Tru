//
//  UserInfor.h
//  HHSdk
//
//  Created by mac on 11/15/16.
//  Copyright © 2016 Hoàng Hiệp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfor : NSObject
{
    
    NSString *_username;
    NSString *_email;
    NSString *_picture;
    int _coin;
    
}
+ (UserInfor *)sharedInstance;
- (void)ClearMe;
@property(strong, nonatomic, readwrite) NSString *username;
@property(strong, nonatomic, readwrite) NSString *email;
@property(strong, nonatomic, readwrite) NSString *picture;
@property(assign, nonatomic, readwrite) int coin;
@end
