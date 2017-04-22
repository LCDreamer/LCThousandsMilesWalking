//
//  LCUserInfo.h
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#define KHeadIcon     @"HeadIcon"

@interface LCUserInfo : NSObject<NSCoding>
@property(nonatomic,strong)NSString* userID;//用户ID
@property(nonatomic,strong)NSString* loginpwd;//密码
@property(nonatomic,strong)NSString* userName;//姓名
@property(nonatomic,strong)NSDate* birthday;//生日
@property(nonatomic,assign)int sex;//性别
@property(nonatomic,assign)int maritalstatus;//婚姻状态
@property(nonatomic,strong)NSString* constellation;//星座
@property(nonatomic,strong)NSString* educationlevel;//教育程度
@property(nonatomic,strong)NSString* vocation;//所在行业
@property(nonatomic,strong)NSString* homeadd;//家庭住址
@property(nonatomic,strong)NSString* hobbies;//兴趣爱好
@property(nonatomic,assign)int serviceflag;//服务提供者标示
@property(nonatomic,strong)NSDate* createtime;//创建时间
@property(nonatomic,strong)NSDate* modifytime;//修改时间
@property(nonatomic,strong)NSDate* loginteime;//登录时间

@property(nonatomic,strong)NSString* phone;//电话
@property(nonatomic,strong)NSString* email;//邮件
@property(nonatomic,strong)NSString* nickName;//昵称
@property(nonatomic,strong)NSString* headurl;//头像
@property(nonatomic,strong)NSString* openid;//
@property(nonatomic,strong)NSData* headIcon;

@end
