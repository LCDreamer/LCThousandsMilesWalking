//
//  LCAddEventRemindViewController.h
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/8/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioButton.h"
#import "LCEventDetailsViewController.h"
#import "MBProgressHUD.h"
#import "LCWarnInfo.h"
#import "LCWarnManager.h"

@interface LCAddEventRemindViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *buttonView;
@property (weak, nonatomic) IBOutlet UITextField *warnTitle;


@end
