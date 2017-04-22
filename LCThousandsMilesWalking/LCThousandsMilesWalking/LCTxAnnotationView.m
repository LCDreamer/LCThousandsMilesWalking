//
//  LCTxAnnotationView.m
//  LCMaps
//
//  Created by 刘超 on 15/6/26.
//  Copyright (c) 2015年 刘超. All rights reserved.
//

#import "LCTxAnnotationView.h"
#define  Arror_height 15
@interface LCTxAnnotationView() {
}
-(void)drawBackground:(CGContextRef)context;
- (void)drawArrowBoundPath:(CGContextRef)context;
@end
@implementation LCTxAnnotationView
-(id)initWithAnnotation:(id<QAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
	self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
	if (self) {
		self.backgroundColor = [UIColor clearColor];
		self.canShowCallout = NO;
		self.centerOffset = CGPointMake(0, -100);
		self.frame = CGRectMake(25, 0, 240, 180);
		
		UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - Arror_height)] ;
		contentView.backgroundColor   = [UIColor clearColor];
		[self addSubview:contentView];
		self.contentView = contentView;
		
	}
	return self;
}
-(void)drawInContext:(CGContextRef)context
{
	
	CGContextSetLineWidth(context, 2.0);
	CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
	
	[self getDrawPath:context];
	CGContextFillPath(context);
	
	//    CGContextSetLineWidth(context, 1.0);
	//     CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
	//    [self getDrawPath:context];
	//    CGContextStrokePath(context);
	
}
- (void)getDrawPath:(CGContextRef)context
{
	CGRect rrect = self.bounds;
	CGFloat radius = 6.0;
	
	CGFloat minx = CGRectGetMinX(rrect),
	midx = CGRectGetMidX(rrect),
	maxx = CGRectGetMaxX(rrect);
	CGFloat miny = CGRectGetMinY(rrect),
	// midy = CGRectGetMidY(rrect),
	maxy = CGRectGetMaxY(rrect)-Arror_height;
	CGContextMoveToPoint(context, midx+Arror_height, maxy);
	CGContextAddLineToPoint(context,midx, maxy+Arror_height);
	CGContextAddLineToPoint(context,midx-Arror_height, maxy);
	
	CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
	CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
	CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
	CGContextClosePath(context);
}

- (void)drawRect:(CGRect)rect
{
	[self drawInContext:UIGraphicsGetCurrentContext()];
	
	self.layer.shadowColor = [[UIColor blackColor] CGColor];
	self.layer.shadowOpacity = 1.0;
	//  self.layer.shadowOffset = CGSizeMake(-5.0f, 5.0f);
	self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end