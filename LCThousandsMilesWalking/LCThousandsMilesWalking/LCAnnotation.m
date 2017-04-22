//
//  LCAnnotation.m
//  LCMaps
//
//  Created by 刘超 on 15/6/26.
//  Copyright (c) 2015年 刘超. All rights reserved.
//

#import "LCAnnotation.h"

@implementation LCAnnotation
- (id)initWithLatitude:(CLLocationDegrees)latitude
			andLongitude:(CLLocationDegrees)longitude{
	if (self = [super init]) {
		self.latitude=latitude;
		self.longitude=longitude;
	}
	return self;
}
- (CLLocationCoordinate2D)coordinate{
	CLLocationCoordinate2D coordinate;
	coordinate.latitude = self.latitude;
	coordinate.longitude = self.longitude;
	return coordinate;
}
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate{
	self.latitude = newCoordinate.latitude;
	self.longitude = newCoordinate.longitude;
}
@end
