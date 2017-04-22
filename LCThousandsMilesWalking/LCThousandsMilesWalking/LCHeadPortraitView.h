//
//  LCHeadPortraitView.h
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/8/6.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCHeadButton.h"
typedef void(^ClickHeadPortraitBlock)(NSInteger headIndex);

@interface LCHeadPortraitView : UIView
@property(nonatomic,strong)NSMutableDictionary* buttonDic;
@property(nonatomic,copy)ClickHeadPortraitBlock  clickHeadPortraitBlock;
@end
