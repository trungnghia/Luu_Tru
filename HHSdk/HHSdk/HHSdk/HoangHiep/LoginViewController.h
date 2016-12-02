//
//  LoginViewController.h
//  FrwGame
//
//  Created by mac on 11/3/16.
//  Copyright © 2016 RayWenderlich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HoangHiep.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import "SVProgressHUD.h"
@interface LoginViewController : UIViewController <GIDSignInDelegate, GIDSignInUIDelegate>
{
    BOOL checkDK;
    __weak IBOutlet UIButton *btnCheckDK;
    }

@property (weak, nonatomic) IBOutlet UITextField *tfUserLogin;
@property (weak, nonatomic) IBOutlet UITextField *tfPassLogin;

@property (weak, nonatomic) IBOutlet UITextField *tfUserReg;
@property (weak, nonatomic) IBOutlet UITextField *tfPass1Reg;
@property (weak, nonatomic) IBOutlet UITextField *tfEmailReg;


@property (weak, nonatomic) IBOutlet UIView *uvLogin;
@property (weak, nonatomic) IBOutlet UIView *uvRigedit;
@property (weak, nonatomic) IBOutlet UIScrollView *scvConten;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;
- (IBAction)AtLogin:(id)sender;
- (IBAction)AtFaceLogin:(id)sender;
- (IBAction)AtGoogleLogin:(id)sender;
- (IBAction)AtGoReg:(id)sender;
- (IBAction)AtCheckDK:(id)sender;
- (IBAction)AtGotoDK:(id)sender;
- (IBAction)AtRegedit:(id)sender;
- (IBAction)AtBackLogin:(id)sender;

@end
