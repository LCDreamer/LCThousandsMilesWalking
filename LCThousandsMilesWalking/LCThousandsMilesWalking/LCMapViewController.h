//
//  LCMapViewController.h
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <QMapKit/QMapKit.h>
#import <BaiduMapAPI/BMapKit.h>
#import "RMCQAnnotation.h"
#import "RMCQCalloutAnnotation.h"
#import "RMCQAnotation.h"
#import "RMCQAnnotationView.h"
#import "RMCQAnnotationCell.h"
#import "LCMapDefine.h"
#import "LCTxMapView.h"
#import "LCBdMapView.h"
#import "LCGdMapView.h"

#import "ZHPickView.h"
#import "AFNetworking.h"
#import "WTRequestCenter.h"
#import "MBProgressHUD.h"
#import "LCDeviceInfo.h"
#import "LCTrackInfo.h"
#import "KxMenu.h"
#import "RMCQFloatingToolBar.h"
#import "LCRailInfo.h"
#import "LCRailManager.h"
#import "LCAlertView.h"



@interface LCMapViewController : UIViewController<MKMapViewDelegate,RMCQFloatingToolBarDelegate>
@property(nonatomic,strong)LCTxMapView* txMapView;
@property(nonatomic,strong)LCBdMapView* bdMapView;
@property(nonatomic,strong)LCGdMapView* gdMapView;
@property(nonatomic,assign)MAP_TYPE mapType;

@property(nonatomic,retain)RMCQAnotation *currentAnotation;
@property(nonatomic,retain)RMCQCalloutAnnotation *calloutAnnotation;;
@property(nonatomic,retain)RMCQAnnotation *popAnnotation;
@property(nonatomic,assign)CLLocationCoordinate2D gpsPoint;
@property(nonatomic,strong)LCDeviceInfo*deviceInfo;
@property(nonatomic,strong)RMCQFloatingToolBar*floatingToolBar;
@property(nonatomic,assign)BOOL isShow;
@property(nonatomic,assign)BOOL isSetCenter;
@property(nonatomic,strong)LCRailInfo *railInfo;
@property(nonatomic,strong)UIButton *setButton;
@property(nonatomic,assign)RMCQFLOATINGTOOLBAR_FNUCTION_TYPE functionType;
@property(nonatomic,assign)BOOL isSuccessful;
@property(nonatomic,assign)BOOL endIng;

@end
