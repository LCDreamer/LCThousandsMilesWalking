//
//  LCCalloutAnnotation.h
//  LCMaps
//
//  Created by 刘超 on 15/6/26.
//  Copyright (c) 2015年 刘超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QMapKit/QMapKit.h>
#import <MapKit/MapKit.h>
#import <BaiduMapAPI/BMapKit.h>
@interface LCCalloutAnnotation : NSObject<MKAnnotation,QAnnotation,BMKAnnotation>
@property (nonatomic,assign) CLLocationDegrees latitude;
@property (nonatomic,assign) CLLocationDegrees longitude;
@property (assign)NSInteger tag;
- (id)initWithLatitude:(CLLocationDegrees)latitude
		  andLongitude:(CLLocationDegrees)longitude;
@end
