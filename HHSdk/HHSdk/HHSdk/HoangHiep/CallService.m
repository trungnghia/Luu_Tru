//
//  CallService.m
//  Vui1
//
//  Created by thich on 4/18/15.
//  Copyright (c) 2015 Hai Trieu. All rights reserved.
//

#import "CallService.h"


@implementation CallService
@synthesize LinkServer=_LinkServer;
@synthesize Afmanager=_Afmanager;
+ (CallService *)sharedInstance {
    static dispatch_once_t onceToken;
    static CallService *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[CallService alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        _LinkServer=[NSURL URLWithString:@"http://192.168.172.100/Code/api/"];
        _Afmanager=[[AFHTTPSessionManager alloc] initWithBaseURL:_LinkServer];
    }
    return self;
}

-(void)Postweb_service:(NSString*)link1 PostLen:(NSMutableDictionary*)ThamSo ChuaTenHamVaCacThamSo:(NSMutableDictionary*)TenHam ifComplete:(void(^)(id responseObject))ifComplete ifFalse:(void(^)(id responseObject))ifFalse
{
    [_Afmanager POST:link1
      parameters:ThamSo
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSMutableDictionary* Trave = [[NSMutableDictionary alloc]init];
                     [Trave setObject:TenHam forKey:@"NameHam"];
                     [Trave setObject:responseObject forKey:@"Respone"];
                     //NSLog(@"+++++ POST thanh cong %@",Trave);
                     if (ifComplete) {
                         ifComplete(Trave);
                     }

         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"Error: %@ ----- %@",[TenHam objectForKey:@"Name"],error);
                     if (ifFalse) {
                         ifFalse(@"Post not successfully");
                     }
         }];
}



-(void) postLogin:(NSString*)username password:(NSString*)password access_token:(NSString*)access_token ifComplete:(void(^)(id responseObject))ifComplete ifFalse:(void(^)(id responseObject))ifFalse
{
    NSMutableDictionary* TenHam = [[NSMutableDictionary alloc]init];
    NSString* link= @"auth/login";
    [TenHam setObject:@"postLogin" forKey:@"Name"];
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    [params setObject:username forKey:@"username"];
    [params setObject:password forKey:@"password"];
    [params setObject:access_token forKey:@"access_token"];
    
    [self Postweb_service:link PostLen:params ChuaTenHamVaCacThamSo:TenHam ifComplete:^(id responseObject) {
        if (ifComplete) {
            ifComplete(responseObject);
        }
    } ifFalse:^(id responseObject) {
        if (ifFalse) {
            ifFalse(@"postLogin not successfully");
        }
    }];
}
-(void) postInfo:(NSString*)access_token ifComplete:(void(^)(id responseObject))ifComplete ifFalse:(void(^)(id responseObject))ifFalse
{
    NSMutableDictionary* TenHam = [[NSMutableDictionary alloc]init];
    NSString* link=[NSString stringWithFormat:@"users/info"];
    [TenHam setObject:@"postInfo" forKey:@"Name"];
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    [params setObject:access_token forKey:@"access_token"];
    
    [self Postweb_service:link PostLen:params ChuaTenHamVaCacThamSo:TenHam ifComplete:^(id responseObject) {
        if (ifComplete) {
            ifComplete(responseObject);
        }
    } ifFalse:^(id responseObject) {
        if (ifFalse) {
            ifFalse(@"postInfo not successfully");
        }
    }];
}
-(void) postRegister:(NSString*)username password:(NSString*)password email:(NSString*)email ifComplete:(void(^)(id responseObject))ifComplete ifFalse:(void(^)(id responseObject))ifFalse
{
    NSMutableDictionary* TenHam = [[NSMutableDictionary alloc]init];
    NSString* link=[NSString stringWithFormat:@"auth/register"];
    [TenHam setObject:@"postRegister" forKey:@"Name"];
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    [params setObject:username forKey:@"username"];
    [params setObject:password forKey:@"password"];
    [params setObject:email forKey:@"email"];
    
    
    [self Postweb_service:link PostLen:params ChuaTenHamVaCacThamSo:TenHam ifComplete:^(id responseObject) {
        if (ifComplete) {
            ifComplete(responseObject);
        }
    } ifFalse:^(id responseObject) {
        if (ifFalse) {
            ifFalse(@"postRegister not successfully");
        }
    }];
}
@end
