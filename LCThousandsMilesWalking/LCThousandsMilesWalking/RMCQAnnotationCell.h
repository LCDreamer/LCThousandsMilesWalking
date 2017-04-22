//
//  RMCQAnnotationCell.h
//  RMCQAnnotationViewDemo
//
//  Created by LiuChao on 13-11-30.
//  Copyright (c) 2013年 RMCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMCQAnnotationCell : UIView
@property (nonatomic,retain)NSString* imageUrl;
@property (nonatomic,copy)NSString* title;
@property(nonatomic,retain)UILabel*gpsInfoTitle;
@property(nonatomic,retain)UILabel*speedTitle;
@property(nonatomic,retain)UILabel*longitudeTile;
@property(nonatomic,retain)UILabel*latitudeTile;
@property(nonatomic,retain)UILabel*timeTitle;
-(void)setGpsInfoSubTitle:(NSString *)gpsInfoTitle;
-(void)setSpeedSubTitle:(NSString *)aSpeedTitle;
-(void)setLongitudeSubTile:(NSString *)alongitudeTile;
-(void)setLatitudeSubTile:(NSString *)alatitudeTile;
-(void)setTimeSubTitle:(NSString*)aTimeTitle;
-(RMCQAnnotationCell*)initWithFrame:(CGRect)prt;
@end
