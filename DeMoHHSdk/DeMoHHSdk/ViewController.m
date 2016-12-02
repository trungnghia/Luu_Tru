//
//  ViewController.m
//  teeeee
//
//  Created by mac on 11/4/16.
//  Copyright © 2016 Hoàng Hiệp. All rights reserved.
//

#import "ViewController.h"
#import <HHSdk/HoangHiep.h>
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
@interface ViewController ()<HoangHiepDelegate>{
    
}
    
    
    @end


@implementation ViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    [HoangHiep setMyDelegate:self];
}
    
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dispatchUserInfor:(UserInfor*)responseObject{
    NSLog(@"Login thanh cong: username: %@ email: %@ picture: %@ coin: %i",responseObject.username,responseObject.email,responseObject.picture,responseObject.coin);
    self.lblUser.text = responseObject.username;
    self.lblEmail.text = responseObject.email;
    self.lblCoint.text = [NSString stringWithFormat:@"%i",responseObject.coin];
    [self.imgAvarta setImageWithURL:[NSURL URLWithString:responseObject.picture] placeholderImage:[UIImage imageNamed:@"placeholder-avatar"]];
    
}
    
- (IBAction)Gologout:(id)sender {
    [HoangHiep Logout];
}
    @end
