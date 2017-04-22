//
//  LCUserInfo.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCUserInfo.h"

@implementation LCUserInfo
-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeDataObject:_headIcon];
}
-(id)initWithCoder:(NSCoder *)decoder
{
    if (self=[super init]) {
        _headIcon=[decoder decodeDataObject];
    }
    return self;
}
-(id)copyWithZone:(NSZone *)zone
{
    LCUserInfo*copy=[[[self class]allocWithZone:zone]init];
    return copy;
}

@end
