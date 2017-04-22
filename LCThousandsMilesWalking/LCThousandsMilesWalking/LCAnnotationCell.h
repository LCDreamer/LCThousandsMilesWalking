//
//  LCAnnotationCell.h
//  LCMaps
//
//  Created by 刘超 on 15/6/26.
//  Copyright (c) 2015年 刘超. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LCAnnotationCell : UIView
@property(nonatomic,strong)UILabel*  titleLabel;
@property(nonatomic,strong)UILabel*  speedLabel;
@property(nonatomic,strong)UILabel*  speedValue;
@property(nonatomic,strong)UILabel*  driverLabel;
@property(nonatomic,strong)UILabel*  driverValue;
@property(nonatomic,strong)UILabel*  alarmLabel;
@property(nonatomic,strong)UILabel*  alarmValue;
@property(nonatomic,assign)BOOL      bAlarm;

-(LCAnnotationCell*)initWithFrame:(CGRect)rect;
@end
