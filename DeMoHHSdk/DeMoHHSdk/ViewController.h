//
//  ViewController.h
//  teeeee
//
//  Created by mac on 11/4/16.
//  Copyright © 2016 Hoàng Hiệp. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ViewController : UIViewController
    {
        NSString * LinkServer;
    }
- (IBAction)Gologout:(id)sender;
    @property (weak, nonatomic) IBOutlet UIView *uvLogout;
    
    @property (weak, nonatomic) IBOutlet UILabel *lblUser;
    @property (weak, nonatomic) IBOutlet UILabel *lblEmail;
    @property (weak, nonatomic) IBOutlet UILabel *lblCoint;
    @property (weak, nonatomic) IBOutlet UIImageView *imgAvarta;
    
    @end

