//
//  LCWarnManager.h
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/9/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCWarnInfo.h"
@interface LCWarnManager : NSObject
@property(nonatomic,strong) LCWarnInfo* warnInfo;
@property(nonatomic,strong) NSMutableDictionary* warnDic;
+(LCWarnManager*)shareManager;

@end
