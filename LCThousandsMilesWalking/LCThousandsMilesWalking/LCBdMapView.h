//
//  LCBdMapView.h
//  LCMaps
//
//  Created by 刘超 on 15/6/23.
//  Copyright (c) 2015年 刘超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMapKit.h>
#import "LCMapDefine.h"
#import "LCAnnotation.h"
#import "LCCalloutAnnotation.h"
#import "LCTrackInfo.h"
#import "LCRailInfo.h"

typedef void(^GetCenterGPSBlock)(CGFloat longitude,CGFloat latitude);
@interface LCBdMapView : UIView<BMKMapViewDelegate,BMKPoiSearchDelegate>
@property(nonatomic,strong)BMKMapView * mymapview;
@property(nonatomic,strong)LCCalloutAnnotation *calloutMapAnnotation;
@property(nonatomic,copy)GetCenterGPSBlock getCenterGPSBlock;
-(id)initWithFrame:(CGRect)frame addMapType:(MAP_TYPE) mapType;
-(void)drawsTrackForTrackInfo:(NSArray*)array;

-(void)addRailCenterAnnotationToBdMapViewForRailInfo:(LCRailInfo*)railInfo;

-(void)drawsRailForRailInfo:(LCRailInfo*)railInfo;

-(void)setCenterPonitForLongPressMap;


@end
