//
//  LCImageView.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/9/6.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCImageView.h"

@implementation LCImageView

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(40, 5, 40, 40)];
//    [imageView setImage:[UIImage imageNamed:@"home_add_button_bg"]];
    [self addSubview:imageView];
    self.layer.cornerRadius=30;
    self.layer.borderWidth=2;
    self.layer.borderColor=[[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1] CGColor];
    self.clipsToBounds = YES;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
