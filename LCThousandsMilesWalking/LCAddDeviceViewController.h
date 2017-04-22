//
//  LCAddDeviceViewController.h
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/8/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHPickView.h"
#import "AFNetworking.h"
#import "WTRequestCenter.h"
#import "MBProgressHUD.h"
#import "LCHeadPortraitView.h"

@interface LCAddDeviceViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *deviceText;
@property (strong, nonatomic) IBOutlet LCHeadPortraitView *headPort;
- (IBAction)addDevices:(id)sender;
- (IBAction)backRegsiter:(id)sender;

@end
