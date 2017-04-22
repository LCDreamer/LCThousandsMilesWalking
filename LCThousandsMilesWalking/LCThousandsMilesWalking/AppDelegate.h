//
//  AppDelegate.h
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCSideViewController.h"
#import <BaiduMapAPI/BMapKit.h>
#import <QMapKit/QMapKit.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) LCSideViewController *sideViewController;
@property (strong,nonatomic)BMKMapManager* mapManager;
@end

