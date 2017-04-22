//
//  LCHeadPortraitView.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/8/6.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCHeadPortraitView.h"

@implementation LCHeadPortraitView


-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    _buttonDic=[[NSMutableDictionary alloc]init];
    float headButtonCentY=rect.size.height/4;
    float headButtonCentX=rect.size.width/8;
    float headWidth=rect.size.width/4;
    float headHeight=rect.size.height/2;
    for (int i=0; i<2; i++) {
        for (int j=0; j<4; j++) {
            LCHeadButton* headButton=[[LCHeadButton alloc] initWithFrame:CGRectMake(headWidth*j+headButtonCentX, headHeight*i+headButtonCentY, 70, 70)];
            CGPoint HeadCentPoint;
            HeadCentPoint.x=headWidth*j+headButtonCentX;
            HeadCentPoint.y= headHeight*i+headButtonCentY;
            [headButton setCenter:HeadCentPoint];
            [headButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"head%d",i*4+j]] forState:UIControlStateNormal];
            headButton.tag=i*4+j;
			if (i*4+j==0) {
				headButton.layer.borderWidth=3;
				headButton.layer.borderColor=[[UIColor greenColor] CGColor];
			}
			NSLog(@"%d",i*4+j);
            [headButton addTarget:self action:@selector(clickHeadButton:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:headButton];
            [_buttonDic setObject:headButton forKey:[NSNumber numberWithInteger:headButton.tag]];
            
        }
    }
}

-(void)clickHeadButton:(id)sender{
    LCHeadButton*button=(LCHeadButton*)sender;
    for (int i=0; i<[[_buttonDic allKeys] count]; i++) {
        LCHeadButton*headButton=[_buttonDic objectForKey:[[_buttonDic allKeys] objectAtIndex:i]];
        if (headButton.tag==button.tag) {
            headButton.layer.borderWidth=3;
            headButton.layer.borderColor=[[UIColor greenColor] CGColor];
        }else{
            headButton.layer.borderWidth=2;
            headButton.layer.borderColor=[[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1] CGColor];
            
        }
    }
	_clickHeadPortraitBlock(button.tag);
}

@end
