//
//  LCGdMapView.m
//  LCMaps
//
//  Created by 刘超 on 15/6/24.
//  Copyright (c) 2015年 刘超. All rights reserved.
//

#import "LCGdMapView.h"


@implementation LCGdMapView

-(id)initWithFrame:(CGRect)frame addMapType:(MAP_TYPE) mapType{
	if (self=[super initWithFrame:frame]) {
		[self initGdMapView];
	}
	return self;
	
}

- (void)initGdMapView
{
	self.gdMapView= [[MKMapView alloc] initWithFrame:self.bounds];
	self.gdMapView.delegate = self;
	[self addSubview:self.gdMapView];
	[self addAnnotationToGdMapView];
}

-(void)addAnnotationToGdMapView{
	MKPointAnnotation* annotation = [[MKPointAnnotation alloc]init];
	CLLocationCoordinate2D coor;
	coor.latitude = 39.915;
	coor.longitude = 116.404;
	annotation.coordinate = coor;
	annotation.title = @"这里是北京";
	self.popAnnotation=[[LCAnnotation alloc]initWithLatitude:coor.latitude andLongitude:coor.longitude];
	[self.gdMapView addAnnotation:self.popAnnotation];
	
}

-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
	if (annotation == self.calloutAnnotation) {
		LCAnnotationView *annotationView = (LCAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CalloutView"];
		LCAnnotationCell  *cell;
		if (annotationView) {
			cell = (LCAnnotationCell*)[annotationView.contentView viewWithTag:999];
		}else{
			annotationView = [[LCAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CalloutView"];
			cell= [[LCAnnotationCell alloc] initWithFrame:CGRectMake(0, 0, annotationView.frame.size.width, annotationView.frame.size.height - 15)];
			cell.tag = 999;
		}
		 [annotationView.contentView addSubview:cell];
		return annotationView;
	}else if (annotation == self.popAnnotation){
		MKAnnotationView *annotationView =[self.gdMapView dequeueReusableAnnotationViewWithIdentifier:@"CustomAnnotation"];
		if (!annotationView) {
			annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
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
		[self.gdMapView addAnnotation:self.calloutAnnotation];
	}
}


- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {

	if (self.calloutAnnotation && view.annotation == self.popAnnotation) {
		[self.gdMapView removeAnnotation: self.calloutAnnotation];
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
