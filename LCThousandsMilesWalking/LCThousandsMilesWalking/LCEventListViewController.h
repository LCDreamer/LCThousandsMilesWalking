//
//  LCEventListViewController.h
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/9/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "WTRequestCenter.h"
#import "LCUserManager.h"
#import "LCEventTableViewCell.h"
#import "LCWarnInfo.h"
#import "LCEventDetailsViewController.h"

@interface LCEventListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property(nonatomic,assign)NSInteger warnType;
@property(nonatomic,strong)NSMutableArray *warnInfoArray;
@end
