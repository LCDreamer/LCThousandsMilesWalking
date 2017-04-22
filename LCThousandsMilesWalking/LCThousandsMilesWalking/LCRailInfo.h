//
//  LCRailInfo.h
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/8/21.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCRailInfo : NSObject

@property(nonatomic,strong)NSString*facilityid;
@property(nonatomic,strong)NSString*centerlon;
@property(nonatomic,strong)NSString*centerlat;
@property(nonatomic,assign)double radius;
@property(nonatomic,assign)NSString*railId;

@end
