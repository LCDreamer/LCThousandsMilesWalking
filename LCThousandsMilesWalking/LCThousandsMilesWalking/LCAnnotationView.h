//
//  LCAnnotationView.h
//  LCMaps
//
//  Created by 刘超 on 15/6/26.
//  Copyright (c) 2015年 刘超. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <QMapKit/QMapKit.h>
#import <QuartzCore/QuartzCore.h>
@interface LCAnnotationView : MKAnnotationView
@property (nonatomic,retain)UIView *contentView;
@end
