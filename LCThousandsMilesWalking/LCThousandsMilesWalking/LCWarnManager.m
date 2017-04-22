//
//  LCWarnManager.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/9/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCWarnManager.h"
static LCWarnManager *warnManager=nil;

@implementation LCWarnManager
+(LCWarnManager*)shareManager{
    if (!warnManager) {
        warnManager=[[LCWarnManager alloc] init];
        warnManager.warnInfo =nil;
        warnManager.warnDic=[[NSMutableDictionary alloc] init];
    }
    return warnManager;
}
@end
