//
//  HoangHiep.m
//  RWUIControls
//
//  Created by Sam Davies on 29/01/2014.
//  Copyright (c) 2014 RayWenderlich. All rights reserved.
//

#import "HoangHiep.h"
#import "LoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import "CallService.h"
#import "Internal.h"
@interface HoangHiep ()
@property (nonatomic, strong) NSString *appID;
@property (nonatomic, assign) int KindOfLogin;
@property (nonatomic, strong) UIApplication *application;
@property (nonatomic, strong) NSDictionary *launchOptions;
@property (nonatomic, strong) NSString *clientIDGoogle;
@property (nonatomic, strong) NSString *access_token;
@property (nonatomic,retain) id<HoangHiepDelegate> delegate;

@property (nonatomic, assign) BOOL isLoginAdded;

@end

static HoangHiep *gInstance = nil;

@implementation HoangHiep

+ (void)initWithAppID:(NSString *)appID application:(UIApplication*)application launchOptions:(NSDictionary*)launchOptions clientID:(NSString*)clientID {
    if (gInstance == nil) {
        gInstance = [[HoangHiep alloc] initWithAppID:appID application:application launchOptions:launchOptions clientID:clientID];
    }
}
- (id)initWithAppID:(NSString *)appID application:(UIApplication*)application launchOptions:(NSDictionary*)launchOptions clientID:(NSString*)clientID {
    self = [super init];
    if(self != nil) {
        _KindOfLogin = 1;
        _appID = appID;
        _application = application;
        _launchOptions = launchOptions;
        _clientIDGoogle = clientID;
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        
        if([standardUserDefaults objectForKey:@"access_token"]!=nil){
            _access_token = [standardUserDefaults objectForKey:@"access_token"];
        }
        else{
            _access_token = @"";
        }
        
        self.isLoginAdded = NO;
        
        [self ShowLogin];
    }
    
    return self;
}
+ (HoangHiep *)sharedInstance {
    return gInstance;
}
+ (void)LoginBy:(int)KindApp{
    [[HoangHiep sharedInstance] LoginBy:KindApp];
}
- (void)LoginBy:(int)KindApp{
    _KindOfLogin=KindApp;
}
+ (void)setMyDelegate:(id)hoangHiepDelegate{
    [[HoangHiep sharedInstance] setMyDelegate:hoangHiepDelegate];
}
- (void)setMyDelegate:(id)hoangHiepDelegate{
    self.delegate=hoangHiepDelegate;
}

- (void)SetAccess_token:(NSString *)access_token
{
    self.access_token = access_token;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setObject:access_token forKey:@"access_token"];
    [standardUserDefaults synchronize];
}
+ (void)SetAccess_token:(NSString *)access_token
{
    [[HoangHiep sharedInstance] SetAccess_token:access_token];
}
+ (void)Logout{
    [[HoangHiep sharedInstance] Logout];
}
- (void)Logout{
    self.access_token = @"";
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults removeObjectForKey:@"access_token"];
    [standardUserDefaults synchronize];
    [[UserInfor sharedInstance] ClearMe];
    [self.delegate dispatchUserInfor:[UserInfor sharedInstance]];
    [self ShowLogin];
}
- (void)GetInfor
{
    [SVProgressHUD show];
    [[CallService sharedInstance] postInfo:self.access_token ifComplete:^(id responseObject) {
        [SVProgressHUD dismiss];
        UserInfor* responseUserInfor = [UserInfor sharedInstance];
        if ([[[responseObject objectForKey:@"Respone"] objectForKey:@"code"] intValue]==200) {
            responseUserInfor.username = [[[responseObject objectForKey:@"Respone"] objectForKey:@"data"]objectForKey:@"username"];
            responseUserInfor.email = [[[responseObject objectForKey:@"Respone"] objectForKey:@"data"]objectForKey:@"email"];
            responseUserInfor.picture = [[[responseObject objectForKey:@"Respone"] objectForKey:@"data"]objectForKey:@"picture"];
            responseUserInfor.coin = [[[[responseObject objectForKey:@"Respone"] objectForKey:@"data"]objectForKey:@"coin"] intValue];
        }
        [self.delegate dispatchUserInfor:responseUserInfor];
    } ifFalse:^(id responseObject) {
        
    }];
}
+ (void)GetInfor
{
    [[HoangHiep sharedInstance] GetInfor];
}
- (void)ShowLogin
{
    if (self) {
        [self performSelector:@selector(addRibbonView) withObject:nil afterDelay:0.1f];
    }
}
+ (void)ShowLogin
{
    [[HoangHiep sharedInstance] ShowLogin];
    
}
+ (BOOL)openURL:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
   return [[HoangHiep sharedInstance] openURL:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    
}
- (BOOL)openURL:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if (self) {
        if (_KindOfLogin ==2) {
            return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation];
        }
        else if(_KindOfLogin == 3) {
             return [[GIDSignIn sharedInstance] handleURL:url sourceApplication:sourceApplication annotation:annotation];
        }
        else{
            return YES;
        }
    }
    else{
        return NO;
    }
}
- (void)addRibbonView
{
    if ([self.access_token isEqualToString:@""]) {
        UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
        UIViewController *rootViewController = [window rootViewController];
        NSAssert(rootViewController != nil, @"Error: UIWindow's rootViewController is nil");
        rootViewController=[self lastPresentedViewController:rootViewController];
        
        NSBundle *frameworkBundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"HHSdk" withExtension:@"bundle"]];
        LoginViewController *viewcontr = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:frameworkBundle];
        
        [rootViewController presentViewController:viewcontr animated:YES completion:nil];
        self.isLoginAdded = YES;
        
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        CGRect frame1 = CGRectMake(0, 0, 375, 375);
        frame1.origin.y = 0;
        frame1.origin.x = 0;
        frame1.size.width = screenBounds.size.width;
        frame1.size.height = screenBounds.size.height;
        viewcontr.view.frame = frame1;
        
        
        [[FBSDKApplicationDelegate sharedInstance] application:_application
                                 didFinishLaunchingWithOptions:_launchOptions];
        [GIDSignIn sharedInstance].clientID = _clientIDGoogle;
        
    }
    else{
        [self GetInfor];
    }
}
- (void)removeRibbonView
{
    if (self.isLoginAdded) {
        self.isLoginAdded  = NO;
        UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
        UIViewController *rootViewController = [window rootViewController];
        NSAssert(rootViewController != nil, @"Error: UIWindow's rootViewController is nil");
        rootViewController=[self lastPresentedViewController:rootViewController];
        [rootViewController dismissViewControllerAnimated:NO completion:nil];
    }
}
+ (void)removeRibbonView
{
     [[HoangHiep sharedInstance] removeRibbonView];
}
- (UIViewController*)lastPresentedViewController:(UIViewController*)root
{
    UIViewController *parentController = root;
    UIViewController *modalController = [self sohaPresentedViewController:parentController];
    
    while (modalController != nil) {
        parentController = modalController;
        modalController = [self sohaPresentedViewController:parentController];
    }
    
    return parentController;
}

- (UIViewController*)sohaPresentingViewController:(UIViewController*)root
{
    if ([self respondsToSelector:@selector(presentingViewController)]) {
        return [root presentingViewController];
    }
    else
    {
        return [root parentViewController];
    }
}

- (UIViewController*)sohaPresentedViewController:(UIViewController*)root
{
    return [root presentedViewController];
}
@end
