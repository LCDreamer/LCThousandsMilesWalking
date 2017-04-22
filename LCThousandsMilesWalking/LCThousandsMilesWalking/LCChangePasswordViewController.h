//
//  LCChangePasswordViewController.h
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "WTRequestCenter.h"

@interface LCChangePasswordViewController : UIViewController
@property(nonatomic,strong)UITextField *oldePassWordTextField;
@property(nonatomic,strong)UITextField *newsPassWordTextField;
@property(nonatomic,strong)UITextField *okPassWordTextField;

@property(nonatomic,strong)NSString *oldPassWord;
@property(nonatomic,strong)NSString *newsPassWord;
@property(nonatomic,strong)NSString *okPassWord;



@end
