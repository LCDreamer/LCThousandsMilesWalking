//
//  LCDeviceInfo.h
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/8/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCDeviceInfo : NSObject
@property(nonatomic,strong)NSString* deviceHredurl;
@property(nonatomic,strong)NSString* deviceID;
@property(nonatomic,strong)NSString* deviceFacilitynum;
@property(nonatomic,strong)NSDate* deviceCreateTime;
@property(nonatomic,strong)NSDate* deviceModifytime;
@property(nonatomic,strong)NSString* deviceUser;



@end
