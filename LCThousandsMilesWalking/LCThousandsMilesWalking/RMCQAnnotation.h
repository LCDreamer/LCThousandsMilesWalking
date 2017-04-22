//
//  RMCQAnnotation.h
//  RMCQAnnotationViewDemo
//
//  Created by LiuChao on 13-11-30.
//  Copyright (c) 2013年 RMCQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface RMCQAnnotation : NSObject{
    CLLocationDegrees _latitude;
	CLLocationDegrees _longitude;
	NSString *_title;
}
@property (nonatomic, copy) NSString *title;
@property (assign)NSInteger tag;
- (id)initWithLatitude:(CLLocationDegrees)latitude
		  andLongitude:(CLLocationDegrees)longitude;
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end
