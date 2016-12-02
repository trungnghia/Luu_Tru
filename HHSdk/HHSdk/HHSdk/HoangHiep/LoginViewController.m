//
//  LoginViewController.m
//  FrwGame
//
//  Created by mac on 11/3/16.
//  Copyright © 2016 RayWenderlich. All rights reserved.
//

#import "LoginViewController.h"
#import "CallService.h"
#import "Internal.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.scvConten.contentSize = CGSizeMake(2*self.scvConten.bounds.size.width, self.view.bounds.size.height);
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectOrientation) name:@"UIDeviceOrientationLandscapeLeft" object:nil];
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.scvConten addGestureRecognizer:singleFingerTap];
    checkDK = NO;
    if (!checkDK) {
        [btnCheckDK setBackgroundImage:[UIImage imageNamed:@"hhsdk.bundle/imgDKUnCheck"] forState:UIControlStateNormal];
    }
    else {
        [btnCheckDK setBackgroundImage:[UIImage imageNamed:@"hhsdk.bundle/imgDKDoCheck"] forState:UIControlStateNormal];
    }
    
    
    [GIDSignIn sharedInstance].uiDelegate = self;
    [GIDSignIn sharedInstance].delegate = self;
    

}
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    [self.view endEditing:YES];
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    self.scvConten.contentSize = CGSizeMake(2*self.scvConten.bounds.size.width, self.view.bounds.size.height);
    if (self.scvConten.bounds.origin.x == 0) {
        self.scvConten.contentOffset = CGPointMake(0,0);
    }
    else{
        self.scvConten.contentOffset = CGPointMake(self.scvConten.bounds.size.width,0);
    }
    
    /*if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice] orientation ]== UIDeviceOrientationLandscapeRight)
    {
        NSLog(@"Lanscapse");
    }
    if([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown )
    {
        NSLog(@"UIDeviceOrientationPortrait");
    }*/
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}









- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)AtLogin:(id)sender {
     [self.view endEditing:YES];
    [HoangHiep LoginBy:1];
    [SVProgressHUD show];
    [[CallService sharedInstance] postLogin:self.tfUserLogin.text password:self.tfPassLogin.text access_token:@"" ifComplete:^(id responseObject) {
        if ([[[responseObject objectForKey:@"Respone"] objectForKey:@"code"]intValue]==200) {
            NSString *access_token = [[[responseObject objectForKey:@"Respone"] objectForKey:@"data"] objectForKey:@"access_token"];
            [HoangHiep SetAccess_token:access_token];
            [HoangHiep removeRibbonView];
            [HoangHiep GetInfor];
        }
        
        [SVProgressHUD dismiss];
    } ifFalse:^(id responseObject) {
        
    }];
}

- (IBAction)AtGoogleLogin:(id)sender {
    [self.view endEditing:YES];
    [HoangHiep LoginBy:3];
    [SVProgressHUD show];
    [[GIDSignIn sharedInstance] signIn];
}
- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations on signed in user here.
    //NSString *userId = user.userID;                  // For client-side use only!
    NSString *idToken = user.authentication.idToken; // Safe to send to the server
    //NSString *fullName = user.profile.name;
    //NSString *givenName = user.profile.givenName;
    //NSString *familyName = user.profile.familyName;
    //NSString *email = user.profile.email;
    //NSLog(@"Customer details      =================================: %@ %@  Access_token %@", fullName, email,idToken);
    
    
    //NSLog(@"check null");
    //if(![idToken isEqual:[NSNull null]])
    if (idToken != nil)
    {
        [HoangHiep LoginBy:1];
        [[CallService sharedInstance] postLogin:self.tfUserLogin.text password:self.tfPassLogin.text access_token:idToken ifComplete:^(id responseObject) {
            if ([[[responseObject objectForKey:@"Respone"] objectForKey:@"code"]intValue]==200) {
                NSString *access_token = [[[responseObject objectForKey:@"Respone"] objectForKey:@"data"] objectForKey:@"access_token"];
                [HoangHiep SetAccess_token:access_token];
                [HoangHiep removeRibbonView];
                [HoangHiep GetInfor];
            }
            
            [SVProgressHUD dismiss];
        } ifFalse:^(id responseObject) {
            
        }];
        
    }
    else{
        [SVProgressHUD dismiss];
        //NSLog(@"no bi null");
    }

    
//    [HoangHiep SetAccess_token:idToken];
//    [HoangHiep GetInfor];
    // ...
}

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
    // ...
}






- (IBAction)AtFaceLogin:(id)sender {
     [self.view endEditing:YES];
    //NSLog(@"Face book");
    [HoangHiep LoginBy:2];
    if (![FBSDKAccessToken currentAccessToken])
    {
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logInWithReadPermissions:@[@"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
         {
             if (error)
             {
                 // Error
                 NSLog(@"get info error:%@ ",error);
             }
             else if (result.isCancelled)
             {
                 // Cancelled
                 NSLog(@"get info Cancelled");
             }
             else
             {
                 if ([result.grantedPermissions containsObject:@"email"])
                 {
                     [self fetchUserInfo];
                 }
             }
         }];
    }
    else{
        [self fetchUserInfo];
    }

}
-(void)fetchUserInfo
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        NSString *fbAccessToken = [FBSDKAccessToken currentAccessToken].tokenString;
       // NSLog(@"fbAccessToken:%@ ",fbAccessToken);
        
        [HoangHiep LoginBy:1];
        [SVProgressHUD show];
        [[CallService sharedInstance] postLogin:self.tfUserLogin.text password:self.tfPassLogin.text  access_token:fbAccessToken ifComplete:^(id responseObject) {
            if ([[[responseObject objectForKey:@"Respone"] objectForKey:@"code"]intValue]==200) {
                NSString *access_token = [[[responseObject objectForKey:@"Respone"] objectForKey:@"data"] objectForKey:@"access_token"];
                [HoangHiep SetAccess_token:access_token];
                [HoangHiep removeRibbonView];
                [HoangHiep GetInfor];
            }
            
            [SVProgressHUD dismiss];
        } ifFalse:^(id responseObject) {
            
        }];
    }
}

- (IBAction)AtGoReg:(id)sender {
     [self.view endEditing:YES];
    self.scvConten.contentOffset = CGPointMake(self.scvConten.bounds.size.width,0);
}

- (IBAction)AtCheckDK:(id)sender {
     [self.view endEditing:YES];
    checkDK = !checkDK;
    if (!checkDK) {
        [btnCheckDK setBackgroundImage:[UIImage imageNamed:@"hhsdk.bundle/imgDKUnCheck"] forState:UIControlStateNormal];
    }
    else {
        [btnCheckDK setBackgroundImage:[UIImage imageNamed:@"hhsdk.bundle/imgDKDoCheck"] forState:UIControlStateNormal];
    }
}

- (IBAction)AtGotoDK:(id)sender {
     [self.view endEditing:YES];
    //NSLog(@"Go to trang dieu khoan");
}

- (IBAction)AtRegedit:(id)sender {
     [self.view endEditing:YES];
    //NSLog(@"Reg acc");
    [SVProgressHUD show];
    [[CallService sharedInstance] postRegister:self.tfUserReg.text password:self.tfPass1Reg.text email:self.tfEmailReg.text ifComplete:^(id responseObject) {
        [SVProgressHUD dismiss];
    } ifFalse:^(id responseObject) {
        
    }];
}

- (IBAction)AtBackLogin:(id)sender {
     [self.view endEditing:YES];
    self.scvConten.contentOffset = CGPointMake(0,0);
}
@end
