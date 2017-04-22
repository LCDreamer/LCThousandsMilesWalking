//
//  LCLoginViewController.h
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCSideViewController.h"
#import "LCUserViewController.h"
#import "LCTabBarController.h"
#import "LCRetrievePasswordViewController.h"
#import "AFNetworking.h"
#import "WTRequestCenter.h"


@interface LCLoginViewController : UIViewController

@property(nonatomic,strong)LCSideViewController* sideViewController;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property(nonatomic,strong)NSString*userName;
@property(nonatomic,strong)NSString*password;
@property(nonatomic,strong)LCRetrievePasswordViewController*retrievePasswordViewController;
- (IBAction)clickLogin:(id)sender;
- (IBAction)clickRetrievePassword:(id)sender;
- (IBAction)backgroundTap:(id)sender;
- (IBAction) textFieldDoneEditing:(id)sender;

@end
