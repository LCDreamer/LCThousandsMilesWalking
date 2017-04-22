//
//  LCHeadButton.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/8/6.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCHeadButton.h"

@implementation LCHeadButton


-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    self.layer.cornerRadius=rect.size.height/2;
//    self.layer.borderWidth=2;
//    self.layer.borderColor=[[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1] CGColor];
    self.titleLabel.textColor=[UIColor colorWithRed:1/255.0 green:197.0/255.0 blue:255.0/255.0 alpha:1];
    self.titleLabel.font=[UIFont systemFontOfSize:18];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
