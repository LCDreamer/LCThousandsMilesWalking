//
//  LCDeviceManager.h
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/8/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCDeviceInfo.h"
@interface LCDeviceManager : NSObject
@property(nonatomic,strong)NSMutableArray*deviceArray;
@property(nonatomic,strong)LCDeviceInfo*deviceInfo;
+(LCDeviceManager*)shareManager;
@end
