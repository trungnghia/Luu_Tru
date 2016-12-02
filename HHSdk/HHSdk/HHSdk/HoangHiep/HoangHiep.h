//
//  HoangHiep.h
//  RWUIControls
//
//  Created by Sam Davies on 29/01/2014.
//  Copyright (c) 2014 RayWenderlich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfor.h"
@protocol HoangHiepDelegate <NSObject>

-(void)dispatchUserInfor:(UserInfor*)responseObject;

@end
@interface HoangHiep : NSObject<UIApplicationDelegate>
+ (void)initWithAppID:(NSString *)appID application:(UIApplication*)application launchOptions:(NSDictionary*)launchOptions clientID:(NSString*)clientID;
- (id)initWithAppID:(NSString *)appID application:(UIApplication*)application launchOptions:(NSDictionary*)launchOptions clientID:(NSString*)clientID;

+ (void)Logout;
- (void)Logout;
+ (void)setMyDelegate:(id)hoangHiepDelegate;
- (void)setMyDelegate:(id)hoangHiepDelegate;
+ (BOOL)openURL:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
- (BOOL)openURL:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

@end
