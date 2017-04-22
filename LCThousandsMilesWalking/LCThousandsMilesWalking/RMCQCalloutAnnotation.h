//
//  RMCQCalloutAnnotation.h
//  RMCQAnnotationViewDemo
//
//  Created by LiuChao on 13-12-9.
//  Copyright (c) 2013年 RMCQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface RMCQCalloutAnnotation : NSObject<MKAnnotation>{
	CLLocationDegrees _latitude;
	CLLocationDegrees _longitude;
}

@property (nonatomic,assign) CLLocationDegrees latitude;
@property (nonatomic,assign) CLLocationDegrees longitude;
@property (assign)NSInteger tag;
- (id)initWithLatitude:(CLLocationDegrees)latitude
		  andLongitude:(CLLocationDegrees)longitude;

@end
