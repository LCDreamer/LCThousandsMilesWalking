//
//  LCWarnInfo.h
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/9/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCWarnInfo : NSObject

@property(nonatomic,strong)NSString *warnID;
@property(nonatomic,strong)NSString *warnTitle;
@property(nonatomic,strong)NSString *warncontent;
@property(nonatomic,strong)NSDate *warndate;
@property(nonatomic,assign)NSInteger warnType;
@property(nonatomic,assign)NSInteger warnflag;
@property(nonatomic,strong)NSString *warnremark;


@end
