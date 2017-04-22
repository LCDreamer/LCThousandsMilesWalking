//
//  LCTxMapView.m
//  LCMaps
//
//  Created by 刘超 on 15/6/23.
//  Copyright (c) 2015年 刘超. All rights reserved.
//

#import "LCTxMapView.h"
#import "LCAnnotationCell.h"
#import "LCTxAnnotationView.h"
@implementation LCTxMapView
-(id)initWithFrame:(CGRect)frame addMapType:(MAP_TYPE) mapType{
	if (self=[super initWithFrame:frame]) {
		[self initTxMapView];
	}
	return self;
}

#pragma mark - QMapViewDelegate

- (void)initTxMapView
{
	self.txMapView= [[QMapView alloc] initWithFrame:self.bounds];
	self.txMapView.delegate = self;
	[self addSubview:self.txMapView];
	[self addAnnotationToTxMapView];
}

-(void)addAnnotationToTxMapView{
	QPointAnnotation *red = [[QPointAnnotation alloc] init];
	red.coordinate = CLLocationCoordinate2DMake(39.9042, 116.234);
	red.title    = @"Red";
	red.subtitle = [NSString stringWithFormat:@"{%f, %f}", red.coordinate.latitude, red.coordinate.longitude];
	self.popAnnotation=[[LCAnnotation alloc]initWithLatitude:red.coordinate.latitude andLongitude:red.coordinate.longitude];
	[_txMapView addAnnotation:self.popAnnotation];
}

- (QAnnotationView *)mapView:(QMapView *)mapView viewForAnnotation:(id<QAnnotation>)annotation
{
	if (annotation == self.calloutAnnotation) {
		LCTxAnnotationView *annotationView = (LCTxAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CalloutView"];
		LCAnnotationCell  *cell;
		if (annotationView) {
			cell = (LCAnnotationCell*)[annotationView.contentView viewWithTag:999];
		}else{
			annotationView = [[LCTxAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CalloutView"];
			cell= [[LCAnnotationCell alloc] initWithFrame:CGRectMake(0, 0, annotationView.frame.size.width, annotationView.frame.size.height - 15)];
			cell.tag = 999;
		}
		 [annotationView.contentView addSubview:cell];
		return annotationView;
	}else if (annotation == self.popAnnotation){
		QAnnotationView *annotationView =[_txMapView dequeueReusableAnnotationViewWithIdentifier:@"CustomAnnotation"];
		if (!annotationView) {
			annotationView = [[QAnnotationView alloc] initWithAnnotation:annotation
														   reuseIdentifier:@"CustomAnnotation"] ;
			annotationView.canShowCallout =NO;
			annotationView.image = [UIImage imageNamed:@"map_online.png"];
		}else{
			annotationView.image = [UIImage imageNamed:@"map_online.png"];
		}
		return annotationView;
	}
	return nil;
}


-(void)mapView:(QMapView *)mapView didSelectAnnotationView:(QAnnotationView *)view{
	if (view.annotation == self.popAnnotation) {
		if (self.calloutAnnotation == nil) {
			self.calloutAnnotation = [[LCCalloutAnnotation alloc] initWithLatitude:view.annotation.coordinate.latitude
																	  andLongitude:view.annotation.coordinate.longitude];
		} else {
			self.calloutAnnotation.latitude = view.annotation.coordinate.latitude;
			self.calloutAnnotation.longitude = view.annotation.coordinate.longitude;
		}
		[_txMapView addAnnotation:self.calloutAnnotation];
	}
}

-(void)mapView:(QMapView *)mapView didDeselectAnnotationView:(QAnnotationView *)view{
	if (self.calloutAnnotation && view.annotation == self.popAnnotation) {
		[_txMapView removeAnnotation: self.calloutAnnotation];
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
