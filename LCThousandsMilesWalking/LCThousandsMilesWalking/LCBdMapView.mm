//
//  LCBdMapView.m
//  LCMaps
//
//  Created by 刘超 on 15/6/23.
//  Copyright (c) 2015年 刘超. All rights reserved.
//

#import "LCBdMapView.h"
#import "LCAnnotationCell.h"
#import "LCBdAnnotationView.h"
#import "LCRailInfo.h"



@implementation LCBdMapView
-(id)initWithFrame:(CGRect)frame addMapType:(MAP_TYPE) mapType{
	if (self=[super initWithFrame:frame]) {
		[self initBdMapView];
	}
	return self;
	
}
- (void)initBdMapView
{
    
	_mymapview = [[BMKMapView alloc] initWithFrame:self.bounds];
	_mymapview.delegate = self;
	[self addSubview:_mymapview];
//	[self addAnnotationToBdMapView];
}
-(void)setCenterPonitForLongPressMap{
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(addAnnotationToMapView:)];
    [longPressGesture setMinimumPressDuration:0.5];
    [_mymapview addGestureRecognizer:longPressGesture];
}

#pragma mark - BMKMapViewDelegate
-(void)addAnnotationToBdMapView{
	//添加自定义Annotation
	CLLocationCoordinate2D center = {39.91669,116.39716};
	LCAnnotation *pointAnnotation = [[LCAnnotation alloc] init];
	pointAnnotation.coordinate = center;
	[_mymapview addAnnotation:pointAnnotation];
	
	BMKCoordinateSpan span = {0.04,0.03};
	BMKCoordinateRegion region = {center,span};
	[_mymapview setRegion:region animated:NO];
	
}


-(void)drawsTrackForTrackInfo:(NSArray*)array{
	
    //构建顶点数组
    CLLocationCoordinate2D coords[100] = {0};
    
    for (int i=0; i<[array count]; i++) {
        LCTrackInfo*trackInfo=[array objectAtIndex:i];
        coords[i].latitude =[trackInfo.trackLat floatValue];
        coords[i].longitude = [trackInfo.trackLng floatValue];
    }
    //构建BMKPolyline,使用分段纹理
    BMKPolyline* polyLine = [BMKPolyline polylineWithCoordinates:coords count:[array count]];
    //添加分段纹理绘制折线覆盖物
    [_mymapview addOverlay:polyLine];
    
}

-(void)addRailCenterAnnotationToBdMapViewForRailInfo:(LCRailInfo*)railInfo{
    //添加自定义Annotation
    CLLocationCoordinate2D center = {[railInfo.centerlat floatValue],[railInfo.centerlon floatValue]};
    LCAnnotation *pointAnnotation = [[LCAnnotation alloc] init];
    pointAnnotation.coordinate = center;
    [_mymapview addAnnotation:pointAnnotation];
    
    BMKCoordinateSpan span = {0.04,0.03};
    BMKCoordinateRegion region = {center,span};
    [_mymapview setRegion:region animated:NO];
    [_mymapview removeOverlays:[_mymapview overlays]];
    
}

-(void)drawsRailForRailInfo:(LCRailInfo*)railInfo{
    CLLocationCoordinate2D coor;
    coor.latitude = [railInfo.centerlat floatValue];
    coor.longitude = [railInfo.centerlon floatValue];
    BMKCircle* circle = [BMKCircle circleWithCenterCoordinate:coor radius:100];
    
    [_mymapview addOverlay:circle];
}

#pragma mark
#pragma mark - BMKMapview delegate
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
	
	static NSString *annotationIdentifier = @"customAnnotation";
	if ([annotation isKindOfClass:[LCAnnotation class]]) {
		
		BMKPinAnnotationView *annotationview = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
		
		annotationview.image = [UIImage imageNamed:@"mapicon"];
		[annotationview setAnimatesDrop:YES];
		annotationview.canShowCallout = NO;
		
		return annotationview;
		
	}
	else if ([annotation isKindOfClass:[LCCalloutAnnotation class]]){
		
		LCBdAnnotationView *annotationView = (LCBdAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CalloutView"];
		LCAnnotationCell  *cell;
		if (annotationView) {
			cell = (LCAnnotationCell*)[annotationView.contentView viewWithTag:999];
		}else{
			annotationView = [[LCBdAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CalloutView"];
			cell= [[LCAnnotationCell alloc] initWithFrame:CGRectMake(0, 0, annotationView.frame.size.width, annotationView.frame.size.height - 15)];
			cell.tag = 999;
		}
		[annotationView.contentView addSubview:cell];
		return annotationView;
		
	}
	
	return nil;
	
}

-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
	
	NSLog(@"didSelectAnnotationView");
	//CustomPointAnnotation 是自定义的marker标注点，通过这个来得到添加marker时设置的pointCalloutInfo属性
	LCAnnotation *annn = (LCAnnotation*)view.annotation;
	
	
	if ([view.annotation isKindOfClass:[LCAnnotation class]]) {
		
		//如果点到了这个marker点，什么也不做
		if (_calloutMapAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
			_calloutMapAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
			return;
		}
		//如果当前显示着calloutview，又触发了select方法，删除这个calloutview annotation
		if (_calloutMapAnnotation) {
			[mapView removeAnnotation:_calloutMapAnnotation];
			_calloutMapAnnotation=nil;
			
		}
		//创建搭载自定义calloutview的annotation
		_calloutMapAnnotation = [[LCCalloutAnnotation alloc] initWithLatitude:view.annotation.coordinate.latitude andLongitude:view.annotation.coordinate.longitude];
		
		//把通过marker(ZNBCPointAnnotation)设置的pointCalloutInfo信息赋值给CalloutMapAnnotation
//		_calloutMapAnnotation.locationInfo = annn.pointCalloutInfo;
		
		[mapView addAnnotation:_calloutMapAnnotation];
		
		
		
		[mapView setCenterCoordinate:view.annotation.coordinate animated:YES];
		
	}
	
	
}


-(void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view{
	
	if (_calloutMapAnnotation&&![view isKindOfClass:[LCBdAnnotationView class]]) {
		if (_calloutMapAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
			_calloutMapAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
			[mapView removeAnnotation:_calloutMapAnnotation];
			_calloutMapAnnotation = nil;
		}
	}
	
}

- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    if ([overlay isKindOfClass:[BMKPolyline class]])
    {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:1];
        polylineView.lineWidth = 5;
        [polylineView loadStrokeTextureImage:[UIImage imageNamed:@"texture_arrow.png"]];
        
        return polylineView;
    }else if ([overlay isKindOfClass:[BMKCircle class]]){
        BMKCircleView* circleView = [[BMKCircleView alloc] initWithOverlay:overlay];
        circleView.fillColor = [[UIColor clearColor] colorWithAlphaComponent:0.5];
        circleView.strokeColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
        circleView.lineWidth = 5.0;
        
        return circleView;
    }
	return nil;
}


- (void)addAnnotationToMapView:(UILongPressGestureRecognizer *)gestureRecognizer {
    NSLog(@"%d   %d",gestureRecognizer.state,UIGestureRecognizerStateEnded);
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        return;
    } else if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [gestureRecognizer locationInView:_mymapview];
        CLLocationCoordinate2D coo = [_mymapview convertPoint:point toCoordinateFromView:_mymapview];
        NSLog(@"经纬度:%lf, %lf", coo.longitude,  coo.latitude);
        NSLog(@"调用一次");
        
        LCAnnotation *pointAnnotation = [[LCAnnotation alloc] init];
        
       
        
        pointAnnotation.coordinate = coo;
        NSArray* array = [NSArray arrayWithArray:_mymapview.annotations];
        [_mymapview removeAnnotations:array];
        
        BMKCoordinateSpan span = {0.04,0.03};
        BMKCoordinateRegion region = {coo,span};
        [_mymapview addAnnotation:pointAnnotation];
        _getCenterGPSBlock(coo.longitude,coo.latitude);
    }
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
