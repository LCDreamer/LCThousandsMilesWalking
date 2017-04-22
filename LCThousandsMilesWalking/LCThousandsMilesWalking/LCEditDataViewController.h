//
//  LCEditDataViewController.h
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

@interface LCEditDataViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,ZHPickViewDelegate>
@property(nonatomic,strong)NSMutableArray* constellationArray;
@property(nonatomic,strong)NSMutableArray* educationlevelArray;
@property(nonatomic,strong)ZHPickView *pickview;
@property(nonatomic,assign)BOOL isSave;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
