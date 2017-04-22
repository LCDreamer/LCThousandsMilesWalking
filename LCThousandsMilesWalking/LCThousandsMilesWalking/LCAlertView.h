//
//  LCAlertView.h
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/8/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCAlertViewDefine.h"
typedef void(^ClickOKBlock)(NSString* textValue,LC_ALERTVIEW_TYPE type);

@interface LCAlertView : UIAlertView
@property(nonatomic,assign)LC_ALERTVIEW_TYPE type;
@property(nonatomic,copy)ClickOKBlock clickOkBlock;
-(id)initForLCAlertViewType:(LC_ALERTVIEW_TYPE)type;
@end
