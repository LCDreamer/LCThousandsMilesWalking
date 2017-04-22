//
//  RMCQAnotation.m
//  MagicEyeMdvr
//
//  Created by 飞 许 on 12-1-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RMCQAnotation.h"

@implementation RMCQAnotation


@synthesize coordinate,subtitle,title,speet;

- (id) initWithCoords:(CLLocationCoordinate2D) coords{
    
	self = [super init];
    
	if (self != nil) {
        
		coordinate = coords; 
        
	}
    
	return self;
    
}

@end
