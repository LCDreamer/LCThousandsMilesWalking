//
//  LCTxMapView.h
//  LCMaps
//
//  Created by 刘超 on 15/6/23.
//  Copyright (c) 2015年 刘超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QMapKit/QMapKit.h>
#import "LCMapDefine.h"
#import "LCAnnotation.h"
#import "LCCalloutAnnotation.h"

@interface LCTxMapView : UIView<QMapViewDelegate>
@property(nonatomic,strong)QMapView *txMapView;
@property(nonatomic,retain)LCAnnotation *popAnnotation;
@property(nonatomic,retain)LCCalloutAnnotation *calloutAnnotation;

-(id)initWithFrame:(CGRect)frame addMapType:(MAP_TYPE) mapType;
@end
