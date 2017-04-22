//
//  LCRetrievePasswordViewController.h
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "WTRequestCenter.h"

@interface LCRetrievePasswordViewController : UIViewController

@property(nonatomic,strong)UILabel*sendPhoneLabel;
@property(nonatomic,strong)UILabel*sendPhoneNumnberLabel;
@property(nonatomic,strong)UITextField*verificationCodeTextField;
@property(nonatomic,strong)UIButton*verificationCodeButton;
@property(nonatomic,strong)UIButton*completeButton;

@property(nonatomic,strong)UITextField *oldePassWordTextField;
@property(nonatomic,strong)UITextField *newsPassWordTextField;

@property(nonatomic,strong)UITextField *okPassWordTextField;

@property(nonatomic,strong)NSString* phoneNumnber;
@property(nonatomic,strong)NSString* verificationCode;

@property(nonatomic,strong)NSString *oldPassWord;
@property(nonatomic,strong)NSString *newsPassWord;
@property(nonatomic,strong)NSString *okPassWord;


@property (weak, nonatomic) IBOutlet UITextField *phoneNumnberTextField;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (weak, nonatomic) IBOutlet UIView *phoneView;
- (IBAction)clickNextPassword:(id)sender;



@end
