//
//  LCEventDetailsViewController.h
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/9/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCWarnInfo.h"
#import "LCWarnManager.h"
#import "ZHPickView.h"
#import "MBProgressHUD.h"
#import "WTRequestCenter.h"
#import "LCUserManager.h"
#import "LCWarnInfo.h"

@interface LCEventDetailsViewController : UIViewController<ZHPickViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *warnContent;
@property (weak, nonatomic) IBOutlet UISwitch *warnFlagSwitch;
@property (weak, nonatomic) IBOutlet UILabel *warnDate;
@property (weak, nonatomic) IBOutlet UITextView *warnRemark;
@property (weak, nonatomic) IBOutlet UILabel *warnTypeLable;
@property (nonatomic,strong)ZHPickView *pickview;
@property (nonatomic,strong)LCWarnInfo *warnInfo;
- (IBAction)slectDate:(id)sender;

@end
