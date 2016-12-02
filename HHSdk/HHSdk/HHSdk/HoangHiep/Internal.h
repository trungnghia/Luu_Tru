//
//  Internal.h
//  HHSdk
//
//  Created by mac on 11/16/16.
//  Copyright © 2016 Hoàng Hiệp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfor.h"
#import "HoangHiep.h"

@interface HoangHiep (Internal)



- (void)removeRibbonView;
+ (void)removeRibbonView;
+ (void)ShowLogin;
- (void)ShowLogin;

+ (void)SetAccess_token:(NSString *)access_token;
- (void)SetAccess_token:(NSString *)access_token;



+ (HoangHiep *)sharedInstance;


+ (void)GetInfor;
- (void)GetInfor;
+ (void)LoginBy:(int)KindApp;
- (void)LoginBy:(int)KindApp;

@end
