//
//  LCRegisteredViewController.h
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "WTRequestCenter.h"
#import "MBProgressHUD.h"

@interface LCRegisteredViewController : UIViewController
- (IBAction)clickPhoneRegisteredButton:(id)sender;
- (IBAction)cliEmailRegisteredButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneOrEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UITextField *activationCodeTextField;
@property (nonatomic,strong)NSString *phone;
@property (nonatomic,strong)NSString *email;
@property (nonatomic,strong)NSString *passWord;
@property (nonatomic,strong)NSString *activation;
- (IBAction)sendVerification:(id)sender;
- (IBAction)registered:(id)sender;

@end
