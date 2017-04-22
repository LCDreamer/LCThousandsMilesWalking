//
//  RMCQAnnotationView.h
//  RMCQAnnotationViewDemo
//
//  Created by LiuChao on 13-11-30.
//  Copyright (c) 2013年 RMCQ. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>

@interface RMCQAnnotationView : MKAnnotationView{
    UIView *contentView;
}
@property (nonatomic,retain)UIView *contentView;

@end
