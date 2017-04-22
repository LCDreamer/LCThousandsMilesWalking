//
//  RMCQFloatingToolBar.m
//  FloatingToolbar
//
//  Created by LiuChao on 13-10-12.
//  Copyright (c) 2013年 LiuChao. All rights reserved.
//

#import "RMCQFloatingToolBar.h"
#define ACNavBarDrawer_Duration     0

@implementation RMCQFloatingToolBar
@synthesize floatingToolBarWidth;
@synthesize floatingToolBarHeight;
@synthesize parentViewWith;
@synthesize parentViewHeighe;
@synthesize ptzbutton;
@synthesize recordbutton;
@synthesize stopbutton;
@synthesize soundbutton;

-(id)initWithView:(UIView*)theView andFrame:(CGRect)theFrame andItemInfoArray:(NSArray*)theArray andParentViewWith:(float)parentWith andParentViewHeight:(float)parentHeighe addType:(RMCQFLOATINGTOOLBAR_TYPE)type{
    self=[super init];
    if (self) {
        [self setFrame:theFrame];
        self.floatingToolBarWidth=theFrame.size.width;
        self.floatingToolBarHeight=theFrame.size.height;
        self.parentViewWith=parentWith;
        self.parentViewHeighe=parentHeighe;
        NSLog(@"%f",self.parentViewWith);
        NSLog(@"%f",self.parentViewHeighe);
        [self setBackgroundColor:[UIColor blackColor]];
        [self setAlpha:0.5f];
        
        self.layer.shadowColor=[UIColor blackColor].CGColor;
        self.layer.shadowOffset=CGSizeMake(0.0f, 1.0f);
        self.layer.shadowRadius=0.5f;
        self.layer.shadowOpacity=0.8f;
        self.layer.masksToBounds=NO;
        self.layer.borderWidth=2;
        self.layer.borderColor=[[UIColor whiteColor] CGColor];//[[UIColor colorWithRed:1 green:0.10 blue:0.10 alpha:0.7] CGColor];
        
        UIBezierPath*path=[UIBezierPath bezierPathWithRect:self.bounds];
        self.layer.shadowPath=path.CGPath;
        [theView addSubview:self];
		if (type==RMCQFLOATINGTOOLBAR_ADD) {
            [self createAddButton];
		}else if(type==RMCQFLOATINGTOOLBAR_DELETE){
			[self createButtonsByNumber:[theArray count] andItemInfoArray:theArray];
		}
		
    }
    return self;
}
- (void)show{
    [UIView animateWithDuration:ACNavBarDrawer_Duration animations:^{
        [self setCenter:CGPointMake( (self.parentViewWith / 2.f),  (self.parentViewHeighe-(self.floatingToolBarHeight / 2)))];
        
    }];
}
- (void)dismiss{
    
    [UIView animateWithDuration:ACNavBarDrawer_Duration animations:^{
        [self setCenter:CGPointMake((self.parentViewWith / 2.f),  (self.parentViewHeighe+(self.floatingToolBarHeight / 2)))];
        
    }];
}
- (void)createButtonsByNumber:(NSInteger)number andItemInfoArray:(NSArray *)array{
    float barItem_w=self.floatingToolBarWidth/number;
    float button_h=self.floatingToolBarHeight-20;
    float button_w=barItem_w-40;
    
    for (int i=0; i<number; i++) {
        float button_ceter_y=barItem_w*i+(barItem_w-button_w)/2;
        UIButton*button=[[UIButton alloc]initWithFrame:CGRectMake(button_ceter_y, 10, button_w, button_h)];
        button.tag=i;
		if (i==0) {
			[button setBackgroundColor:[UIColor colorWithRed:1.0/255.0 green:197.0/255.0 blue:255.0/255.0 alpha:1.000]];
			[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
			[button setTitle:@"重新设定" forState:UIControlStateNormal];
		}else if(i==1){
			 [button setBackgroundColor:[UIColor whiteColor]];
			[button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
			[button setTitle:@"删除" forState:UIControlStateNormal];
		}
        NSString *img =[array objectAtIndex:i];
        [button setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
		
        [button addTarget:self action:@selector(itemBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)createAddButton{
	UIButton*button=[[UIButton alloc]initWithFrame:CGRectMake(20, 10, self.floatingToolBarWidth-40,self.floatingToolBarHeight-20)];
	[button addTarget:self action:@selector(itemBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
	[button setBackgroundColor:[UIColor colorWithRed:1.0/255.0 green:197.0/255.0 blue:255.0/255.0 alpha:1.000]];
    button.tag=2;
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[button setTitle:@"设定" forState:UIControlStateNormal];
	[self addSubview:button];
}

- (void)itemBtnPressed:(UIButton *)itemBtn{
    if (nil != _delegate)
    {
        if (itemBtn.tag==0) {
            [_delegate theBtnPressed:RMCQFLOATINGTOOLBAR_FNUCTION_RESET addButton:itemBtn];
        }else if (itemBtn.tag==1){
            [_delegate theBtnPressed:RMCQFLOATINGTOOLBAR_FNUCTION_DELETE addButton:itemBtn];
        }else if (itemBtn.tag==2){
            [_delegate theBtnPressed:RMCQFLOATINGTOOLBAR_FNUCTION_ADD addButton:itemBtn];

        }
        
    }
}

@end
