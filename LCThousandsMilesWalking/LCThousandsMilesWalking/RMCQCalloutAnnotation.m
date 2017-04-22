//
//  RMCQCalloutAnnotation.m
//  RMCQAnnotationViewDemo
//
//  Created by LiuChao on 13-12-9.
//  Copyright (c) 2013年 RMCQ. All rights reserved.
//

#import "RMCQCalloutAnnotation.h"

@implementation RMCQCalloutAnnotation
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize tag;
- (id)initWithLatitude:(CLLocationDegrees)latitude
		  andLongitude:(CLLocationDegrees)longitude {
	if (self = [super init]) {
		self.latitude = latitude;
		self.longitude = longitude;
	}
	return self;
}

- (CLLocationCoordinate2D)coordinate {
	CLLocationCoordinate2D coordinate;
	coordinate.latitude = self.latitude;
	coordinate.longitude = self.longitude;
	return coordinate;
}
@end
