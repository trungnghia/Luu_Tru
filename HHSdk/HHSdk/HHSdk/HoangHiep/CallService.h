//
//  CallService.h
//  Vui1
//
//  Created by thich on 4/18/15.
//  Copyright (c) 2015 Hai Trieu. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "AFNetworking.h"
//#import "SBJson4.h"
//#import "OLGhostAlertView.h"

@interface CallService : NSObject
{
    NSURL *_LinkServer;
    AFHTTPSessionManager *_Afmanager;
}
+ (CallService *)sharedInstance;

@property(strong, nonatomic, readwrite) NSURL *LinkServer;
@property(strong, nonatomic) AFHTTPSessionManager *Afmanager;

-(void) postLogin:(NSString*)username password:(NSString*)password access_token:(NSString*)access_token ifComplete:(void(^)(id responseObject))ifComplete ifFalse:(void(^)(id responseObject))ifFalse;
-(void) postInfo:(NSString*)access_token ifComplete:(void(^)(id responseObject))ifComplete ifFalse:(void(^)(id responseObject))ifFalse;
-(void) postRegister:(NSString*)username password:(NSString*)password email:(NSString*)email ifComplete:(void(^)(id responseObject))ifComplete ifFalse:(void(^)(id responseObject))ifFalse;
@end
