//
//  LCRailManager.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/8/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCRailManager.h"
static LCRailManager *railManager=nil;

@implementation LCRailManager
+(LCRailManager*)shareManager{
    if (!railManager) {
        railManager=[[LCRailManager alloc] init];
        railManager.railInfo =nil;
    }
    return railManager;
}
@end
