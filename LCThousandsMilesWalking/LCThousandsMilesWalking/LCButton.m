//
//  LCButton.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/8/4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCButton.h"

@implementation LCButton
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(40, 5, 40, 40)];
    [imageView setImage:[UIImage imageNamed:@"home_add_button_bg"]];
    [self addSubview:imageView];
    self.layer.cornerRadius=25;
    self.layer.borderWidth=2;
    self.layer.borderColor=[[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1] CGColor];
    self.titleLabel.textColor=[UIColor colorWithRed:1/255.0 green:197.0/255.0 blue:255.0/255.0 alpha:1];
    self.titleLabel.font=[UIFont systemFontOfSize:18];
    
}
@end
