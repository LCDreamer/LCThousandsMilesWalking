//
//  LCDeviceManager.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/8/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCDeviceManager.h"
static LCDeviceManager *userManager=nil;

@implementation LCDeviceManager
+(LCDeviceManager*)shareManager{
    if (!userManager) {
        userManager=[[LCDeviceManager alloc] init];
        userManager.deviceInfo =nil;
        userManager.deviceArray=[[NSMutableArray alloc] init];
    }
    
    return userManager;
}
@end
