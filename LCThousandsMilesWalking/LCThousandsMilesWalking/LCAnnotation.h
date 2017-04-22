//
//  LCAnnotation.h
//  LCMaps
//
//  Created by 刘超 on 15/6/26.
//  Copyright (c) 2015年 刘超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <QMapKit/QMapKit.h>
@interface LCAnnotation : NSObject
@property(nonatomic,assign)CLLocationDegrees latitude;
@property(nonatomic,assign)CLLocationDegrees longitude;
@property(nonatomic,retain)NSString *title;
@property(nonatomic,assign)NSInteger tag;

- (id)initWithLatitude:(CLLocationDegrees)latitude
		  andLongitude:(CLLocationDegrees)longitude;
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end
