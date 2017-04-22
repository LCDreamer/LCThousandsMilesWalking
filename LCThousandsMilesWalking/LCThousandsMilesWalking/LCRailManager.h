//
//  LCRailManager.h
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/8/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCRailInfo.h"
@interface LCRailManager : NSObject
@property(nonatomic,strong)LCRailInfo * railInfo;
+(LCRailManager*)shareManager;
@end
