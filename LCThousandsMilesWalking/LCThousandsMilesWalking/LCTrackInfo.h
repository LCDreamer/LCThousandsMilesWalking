//
//  LCTrackInfo.h
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/8/12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCTrackInfo : NSObject
@property(nonatomic,strong)NSString *trackLng;
@property(nonatomic,strong)NSString *trackLat;
@property(nonatomic,strong)NSDate *trackCreateTime;
@property(nonatomic,strong)NSString *trackId;
@property(nonatomic,strong)NSString *trackFacilityid;

@end
