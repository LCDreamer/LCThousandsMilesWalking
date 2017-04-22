//
//  LCUserManager.h
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCUserInfo.h"
@interface LCUserManager : NSObject
@property(nonatomic,strong) LCUserInfo* userInfo;
+(LCUserManager*)shareManager;
+(NSString*)dataFilepath;
+(void) writeheadIconData:(NSData *) headIconData To:(NSString *) fileName;
+(NSData *) readheadIconDataFromFile:(NSString *) fileName;
@end
