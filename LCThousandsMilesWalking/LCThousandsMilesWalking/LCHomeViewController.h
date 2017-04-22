//
//  LCHomeViewController.h
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCButton.h"
#import "LCDeviceManager.h"
#import "ZHPickView.h"
#import "AFNetworking.h"
#import "WTRequestCenter.h"
#import "LCUserManager.h"
#import "MBProgressHUD.h"
#import "LCAddDeviceViewController.h"
#import "LCMapViewController.h"

@interface LCHomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet LCButton *addDeviceButton;
- (IBAction)clickAddDevices:(id)sender;
@property(nonatomic,strong)UITableView*tableView;
@property (weak, nonatomic) IBOutlet UIView *addView;
@property(nonatomic,assign)BOOL result;
@property(nonatomic,assign)BOOL isSuccess;


@end
