//
//  RMCQAnnotationCell.m
//  RMCQAnnotationViewDemo
//
//  Created by LiuChao on 13-11-30.
//  Copyright (c) 2013年 RMCQ. All rights reserved.
//

#import "RMCQAnnotationCell.h"

@implementation RMCQAnnotationCell
@synthesize speedTitle;
@synthesize longitudeTile;
@synthesize timeTitle;
@synthesize latitudeTile;
-(RMCQAnnotationCell*)initWithFrame:(CGRect)prt
{
    if (self = [super initWithFrame:prt]) {
        
    }
    return self;
}
-(void)setGpsInfoSubTitle:(NSString *)gpsInfoTitle{
    self.gpsInfoTitle.text=gpsInfoTitle;
}
-(void)setSpeedSubTitle:(NSString *)aspeedTitle{
    self.speedTitle.text=aspeedTitle;
}
-(void)setLongitudeSubTile:(NSString *)alongitudeTile{
    self.longitudeTile.text=alongitudeTile;
}
-(void)setLatitudeSubTile:(NSString *)alatitudeTile{
    self.latitudeTile.text=alatitudeTile;
}

-(void)setTimeSubTitle:(NSString *)aTimeTitle{
    self.timeTitle.text=aTimeTitle;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
