//
//  LCUserManager.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCUserManager.h"
#define KFilenme    @"aehive"
#define KDataKey    @"Data"


static LCUserManager *userManager=nil;

@implementation LCUserManager
+(LCUserManager*)shareManager{
    if (!userManager) {
        userManager=[[LCUserManager alloc] init];
        userManager.userInfo =nil;
    
    }
    return userManager;
}

+(NSString*)dataFilepath
{
    NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*documentDirectory=[paths objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:KFilenme];
}

+(void) writeheadIconData:(NSData *) headIconData To:(NSString *) fileName//写的函数
{
    NSMutableData*data=[[NSMutableData alloc]init];//声明一个可变数据类型
    NSKeyedArchiver*archiver=[[NSKeyedArchiver alloc]initForWritingWithMutableData:data];//编码
    [archiver encodeObject:headIconData forKey:KDataKey];//存放数据文件的类型和名字
    [archiver finishEncoding];//编码完成
    [data writeToFile:[self dataFilepath] atomically:YES];//写在相应的路径下
}
+(NSData *) readheadIconDataFromFile:(NSString *) fileName//读的函数
{
    if ([[NSFileManager defaultManager]fileExistsAtPath:fileName])//是否存在要读的数据类型，如果存在
    {
        NSData*data=[[NSMutableData alloc]initWithContentsOfFile:fileName];//打开名为fileName数据类型的数据
        NSKeyedUnarchiver*unarchiver=[[NSKeyedUnarchiver alloc]initForReadingWithData:data];//解码
        NSData * headIconData = [unarchiver decodeObjectForKey:KDataKey];//把解码出来的数据存放在可变数组里面
        [unarchiver finishDecoding];//解码完成
        if (!headIconData) {
            headIconData=[[NSData alloc]init];
        }
        return headIconData;//返回该数组
    }
    
    return [[NSData alloc]init];;//如果不存在名为fileName数据类型直接返回空
}

@end
