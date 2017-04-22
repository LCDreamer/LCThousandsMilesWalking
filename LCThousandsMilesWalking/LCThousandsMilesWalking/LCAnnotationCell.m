//
//  LCAnnotationCell.m
//  LCMaps
//
//  Created by 刘超 on 15/6/26.
//  Copyright (c) 2015年 刘超. All rights reserved.
//

#import "LCAnnotationCell.h"
#import "LCMapDefine.h"

@implementation LCAnnotationCell
-(LCAnnotationCell*)initWithFrame:(CGRect)rect{
	self = [super initWithFrame:rect];
	if (self) {
		self.bAlarm = NO;
		self.alpha = 0.89f;
		self.layer.masksToBounds=NO;
		self.layer.borderWidth=0.3;
		self.layer.borderColor=[[UIColor darkGrayColor] CGColor];
		self.layer.cornerRadius = 10;
		
		self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 35)];
		_titleLabel.backgroundColor = [UIColor blackColor];
		_titleLabel.textColor = [UIColor whiteColor];
		_titleLabel.text = @"Car 1";
		_titleLabel.textAlignment = NSTextAlignmentCenter;
		
		UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_titleLabel.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
		CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
		maskLayer.frame = _titleLabel.bounds;
		maskLayer.path = maskPath.CGPath;
		_titleLabel.layer.mask = maskLayer;
		
		
		
		
		self.backgroundColor = [UIColor colorWithRed:25/255.0 green:35/255.0 blue:57/255.0 alpha:1];
		
	}
	
	return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
