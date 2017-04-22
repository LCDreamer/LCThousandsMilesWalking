//
//  LCDeviceViewController.h
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCDeviceManager.h"
#import "LCUserManager.h"
#import "LCAddDeviceViewController.h"
@interface LCDeviceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end
