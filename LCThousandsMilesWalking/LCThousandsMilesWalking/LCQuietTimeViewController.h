//
//  LCQuietTimeViewController.h
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/8/15.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "WTRequestCenter.h"
#import "LCDeviceInfo.h"
#import "LCDeviceManager.h"
#import "MBProgressHUD.h"


@interface LCQuietTimeViewController : UIViewController
@property(nonatomic,strong)LCDeviceInfo*deviceInfo;
@property(nonatomic,strong)NSString*startTime;
@property(nonatomic,strong)NSString*endTime;
@property (weak, nonatomic) IBOutlet UITextField *startTimeLabel1;
@property (weak, nonatomic) IBOutlet UITextField *endTimeLabel1;
@property (weak, nonatomic) IBOutlet UITextField *startTimeLabel2;
@property (weak, nonatomic) IBOutlet UITextField *endTimeLabel2;
@property (weak, nonatomic) IBOutlet UITextField *startTimeLabel3;
@property (weak, nonatomic) IBOutlet UITextField *endTimeLabel3;


@end
