//
//  LCGdMapView.h
//  LCMaps
//
//  Created by 刘超 on 15/6/24.
//  Copyright (c) 2015年 刘超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCMapDefine.h"
#import <MapKit/MapKit.h>
#import "LCAnnotation.h"
#import "LCCalloutAnnotation.h"
#import "LCAnnotationView.h"
#import "LCAnnotationCell.h"
@interface LCGdMapView : UIView<MKMapViewDelegate>
@property(nonatomic,strong)MKMapView *gdMapView;
@property(nonatomic,retain)LCAnnotation *popAnnotation;
@property(nonatomic,retain)LCCalloutAnnotation *calloutAnnotation;

-(id)initWithFrame:(CGRect)frame addMapType:(MAP_TYPE) mapType;
@end
