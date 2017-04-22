//
//  LCPersonaDataViewController.h
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LCAlertView.h"
#import "ZHPickView.h"

#import "AFNetworking.h"
#import "WTRequestCenter.h"
#import "LCUserManager.h"
#import "MBProgressHUD.h"


@interface LCPersonaDataViewController : UIViewController<ZHPickViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)ZHPickView *pickview;
- (IBAction)clikOkButton:(id)sender;

@end
