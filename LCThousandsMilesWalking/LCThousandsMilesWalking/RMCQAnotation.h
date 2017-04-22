//
//  RMCQAnotation.h
//  MagicEyeMdvr
//
//  Created by 飞 许 on 12-1-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface RMCQAnotation : NSObject<MKAnnotation>{
	CLLocationCoordinate2D coordinate;
	NSString *subtitle;
	NSString *title;
    NSString*speet;
}

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic,retain) NSString *subtitle;
@property (nonatomic,retain) NSString *title;
@property(nonatomic,retain) NSString*speet;

-(id) initWithCoords:(CLLocationCoordinate2D) coords;

@end
