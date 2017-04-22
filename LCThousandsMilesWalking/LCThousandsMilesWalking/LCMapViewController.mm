//
//  LCMapViewController.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCMapViewController.h"
#import "LCDeviceInfo.h"
#import "LCQuietTimeViewController.h"
#import "LCUserManager.h"
@interface LCMapViewController ()

@end

@implementation LCMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initBaiDuMapView];
	[self selectElectronicFence:_deviceInfo];
    [self initUIBarButtonItem];
    [self selectRailForDevice:_deviceInfo];
    _isShow=YES;
    _isSetCenter=NO;
	[super viewWillDisappear:YES];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"hideVehicleBtn" object:nil
													  userInfo:@{@"hidden":@"0"}];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"hideVehicleBtn" object:nil
													  userInfo:@{@"hidden":@"0"}];
}

-(void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:YES];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"hideVehicleBtn" object:nil
													  userInfo:@{@"hidden":@"1"}];
}

-(void)initBaiDuMapView{
    self.title=@"地图";
	_bdMapView = [[LCBdMapView alloc]initWithFrame:self.view.bounds addMapType:BAIDU_MAP];
    __weak LCMapViewController*temp=self;
    _bdMapView.getCenterGPSBlock=^(CGFloat longitude,CGFloat latitude){
        if (_functionType==RMCQFLOATINGTOOLBAR_FNUCTION_RESET) {
            temp.isSetCenter=YES;
            [temp.setButton setTitle:@"设置半径" forState:UIControlStateNormal];
            [[LCRailManager shareManager] railInfo].centerlon=[NSString stringWithFormat:@"%f",longitude];
            [[LCRailManager shareManager] railInfo].centerlat=[NSString stringWithFormat:@"%f",latitude];
        }else if(_functionType==RMCQFLOATINGTOOLBAR_FNUCTION_ADD){
            _railInfo=[[LCRailInfo alloc] init];
            temp.isSetCenter=YES;
			 [temp.setButton setTitle:@"设置半径" forState:UIControlStateNormal];
            _railInfo.centerlat=[NSString stringWithFormat:@"%f",latitude];
            _railInfo.centerlon=[NSString stringWithFormat:@"%f",longitude];
            [[LCRailManager shareManager] setRailInfo:_railInfo];
        }

    };
	[self.view addSubview:_bdMapView];
	
}
-(void)initUIBarButtonItem{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"btn_top_menu.png"]
                      forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickMenu:)
     forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 50, 50);
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = menuButton;
}
-(void)selectElectronicFence:(LCDeviceInfo*)deviceInfo{
	
	NSDateFormatter *dateFormatters = [[NSDateFormatter alloc] init];
	[dateFormatters setDateFormat:@"yyyy-MM-dd"];
	NSDate *date = [dateFormatters dateFromString:[NSString stringWithFormat:@"%@-%@-%@",@"2015",@"08",@"12"]];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
	NSString *strDate = [dateFormatter stringFromDate:date];
	
	[WTRequestCenter postWithoutCacheURL:[NSURL URLWithString:@"http://120.25.222.190:8081/qlxb/app/track.do?list"] parameters:@{@"facilityid":deviceInfo.deviceID,@"date":strDate} completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
		
		NSDictionary *obj = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
		
		NSMutableArray*trackArray=[[NSMutableArray alloc] init];
		NSString*state=[NSString stringWithFormat:@"%@",[obj objectForKey:@"state"]];
		NSString*msg=[obj objectForKey:@"msg"];
		NSDictionary*dataDic=[obj objectForKey:@"data"];
		NSArray*listArry=[dataDic objectForKey:@"list"];
		for (int i=0; i<[listArry count]; i++) {
			NSDictionary*valueDic=[listArry objectAtIndex:i];
			LCTrackInfo*trackInfo=[[LCTrackInfo alloc] init];
			trackInfo.trackLng=[valueDic objectForKey:@"lng"];
			trackInfo.trackLat=[valueDic objectForKey:@"lat"];
			trackInfo.trackId=[valueDic objectForKey:@"id"];
			trackInfo.trackFacilityid=[valueDic objectForKey:@"facilityid"];
			trackInfo.trackCreateTime=[valueDic objectForKey:@"createtime"];
			[trackArray addObject:trackInfo];
		}
		if ([state isEqualToString:@"1"]) {
			[self showResultThenHide:msg];
			[self.bdMapView drawsTrackForTrackInfo:trackArray];
		}else{
			[self showResultThenHide:msg];
			
		}
	}];
}

-(void)clickMenu:(id)sender{
    UIButton*button=(UIButton*)sender;
    NSArray *menuItems =
    @[
      [KxMenuItem menuItem:@"静音时段"
                     image:[UIImage imageNamed:@"mute"]
                    target:self
                    action:@selector(pushMuteItem:)],
      
      [KxMenuItem menuItem:@"电子围栏"
                     image:[UIImage imageNamed:@"fence"]
                    target:self
                    action:@selector(pushFenceItem:)],
      
      [KxMenuItem menuItem:@"取消绑定"
                     image:[UIImage imageNamed:@"binding"]
                    target:self
                    action:@selector(pushBindingItem:)],
      ];
    
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentCenter;
    
    [KxMenu showMenuInView:self.view
                  fromRect:button.frame
                 menuItems:menuItems];
}

-(void)pushMuteItem:(id)sender{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LCQuietTimeViewController * mapViewController = [storyboard instantiateViewControllerWithIdentifier:@"QuietTimeViewController"];
    mapViewController.deviceInfo=_deviceInfo;
    [self.navigationController pushViewController:mapViewController animated:YES];
    
}

-(void)pushFenceItem:(id)sender{
    if (_isShow) {
        _isShow=NO;
        if ([LCRailManager shareManager].railInfo==nil) {
            NSArray*allArray=[NSArray arrayWithObjects:@"ptz_normal-intel.png",@"Record.png", nil];
            float parentViewWith=self.view.frame.size.width;
            float parentViewHeighe=self.view.frame.size.height;
            CGRect theFrame=CGRectMake(0,self.view.frame.size.height-50,self.view.frame.size.width, 50);
            if (_floatingToolBar==nil) {
                _floatingToolBar=[[RMCQFloatingToolBar alloc] initWithView:_bdMapView andFrame:theFrame andItemInfoArray:allArray andParentViewWith:parentViewWith andParentViewHeight:parentViewHeighe addType:RMCQFLOATINGTOOLBAR_ADD];
                _floatingToolBar.delegate=self;
            }
            [_floatingToolBar show];
        }else{
            NSArray*allArray=[NSArray arrayWithObjects:@"ptz_normal-intel.png",@"Record.png", nil];
            float parentViewWith=self.view.frame.size.width;
            float parentViewHeighe=self.view.frame.size.height;
            CGRect theFrame=CGRectMake(0,self.view.frame.size.height-50,self.view.frame.size.width, 50);
            if (_floatingToolBar==nil) {
                _floatingToolBar=[[RMCQFloatingToolBar alloc] initWithView:_bdMapView andFrame:theFrame andItemInfoArray:allArray andParentViewWith:parentViewWith andParentViewHeight:parentViewHeighe addType:RMCQFLOATINGTOOLBAR_DELETE];
                _floatingToolBar.delegate=self;
            }
            [_floatingToolBar show];
        }
    }else{
        _isShow=YES;
        [_floatingToolBar dismiss];
    }

}

-(void)pushBindingItem:(id)sender{
	[self deleteDeviceForDeviceInfo:_deviceInfo];
	[[[LCDeviceManager shareManager] deviceArray] removeObject:_deviceInfo];
	[self.navigationController popViewControllerAnimated:YES];
}


-(void)addRailForRailInfo:(LCRailInfo*)railInfo{
    [WTRequestCenter postWithoutCacheURL:[NSURL URLWithString:@"http://120.25.222.190:8081/qlxb/app/rail.do?save"] parameters:@{@"facilityid":_deviceInfo.deviceID,@"centerlon":railInfo.centerlon,@"centerlat":railInfo.centerlat,@"r":[NSNumber numberWithDouble:railInfo.radius]} completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSDictionary *obj = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSInteger state=[[obj objectForKey:@"state"]integerValue];
        NSString*msg=[obj objectForKey:@"msg"];
        if (state==1 ) {
            [self showResultThenHide:msg];
        }else{
            [self showResultThenHide:msg];
        }
    }];
}
//-(void)addRailForRailInfos:(LCRailInfo*)railInfo{
//    [WTRequestCenter postWithoutCacheURL:[NSURL URLWithString:@"http://120.25.222.190:8081/qlxb/app/rail.do?save"] parameters:@{@"centerlon":railInfo.centerlon,@"centerlat":railInfo.centerlat,@"r":[NSNumber numberWithDouble:railInfo.radius]} completionHandler:^(NSURLResponse *res1234ponse, NSData *data, NSError *error) {
//        
//        NSDictionary *obj = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
//        NSInteger state=[[obj objectForKey:@"state"]integerValue];
//        NSString*msg=[obj objectForKey:@"msg"];
//        if (state==1 ) {
//            [self showResultThenHide:msg];
//        }else{
//            [self showResultThenHide:msg];
//        }
//    }];
//}


-(void)deleteRailForRailInfo:(LCRailInfo*)raliInfo{
    [WTRequestCenter postWithoutCacheURL:[NSURL URLWithString:@"http://120.25.222.190:8081/qlxb/app/rail.do?del"] parameters:@{@"id":raliInfo.railId} completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSDictionary *obj = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSInteger state=[[obj objectForKey:@"state"]integerValue];
        NSString*msg=[obj objectForKey:@"msg"];
        if (state==1 ) {
            [self showResultThenHide:msg];
        }else{
            [self showResultThenHide:msg];
        }
    }];
}
-(void)selectRailForDevice:(LCDeviceInfo*)deviceInfo{
    NSLog(@"%@",deviceInfo.deviceID);
    [WTRequestCenter postWithoutCacheURL:[NSURL URLWithString:@"http://120.25.222.190:8081/qlxb/app/rail.do?detail"] parameters:@{@"facilityid":deviceInfo.deviceID} completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSDictionary *obj = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSInteger state=[[obj objectForKey:@"state"]integerValue];
        NSString*msg=[obj objectForKey:@"msg"];
        if (state==1 ) {
            [self showResultThenHide:msg];
            NSDictionary*railDic=[[obj objectForKey:@"data"] objectForKey:@"detail"];
            if (railDic!=[NSNull null]) {
                _railInfo=[[LCRailInfo alloc] init];
                _railInfo.facilityid=[[[obj objectForKey:@"data"] objectForKey:@"detail"] objectForKey:@"facilityid"];
                _railInfo.railId=[[[obj objectForKey:@"data"] objectForKey:@"detail"] objectForKey:@"id"];
                _railInfo.radius=[[[[obj objectForKey:@"data"] objectForKey:@"detail"] objectForKey:@"r"] doubleValue];
                _railInfo.centerlat=[[[obj objectForKey:@"data"] objectForKey:@"detail"]objectForKey:@"centerlat"];
                _railInfo.centerlon=[[[obj objectForKey:@"data"] objectForKey:@"detail"]objectForKey:@"centerlon"];
                [[LCRailManager shareManager] setRailInfo:_railInfo];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_bdMapView addRailCenterAnnotationToBdMapViewForRailInfo:_railInfo];
                    [_bdMapView drawsRailForRailInfo:_railInfo];
                });
            }
        }else{
            [self showResultThenHide:msg];
        }
    }];
    
    
}


-(void)deleteDeviceForDeviceInfo:(LCDeviceInfo*)deviceInfo{
	[self showHUDLoading:@"正在删除"];
	[WTRequestCenter postWithoutCacheURL:[NSURL URLWithString:@"http://120.25.222.190:8081/qlxb/app/facility.do?del"] parameters:@{@"id":deviceInfo.deviceID} completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
		NSDictionary *obj = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
		NSString*state=[NSString stringWithFormat:@"%@",[obj objectForKey:@"state"]];
		NSString*msg=[obj objectForKey:@"msg"];
		if ([state isEqualToString:@"1"]) {
			[self showResultThenHide:msg];
			
		}else{
			[self showResultThenHide:msg];
		}
	}];
}



- (MBProgressHUD *)showHUDLoading:(NSString *)hintString{
	
	MBProgressHUD *hud=[MBProgressHUD HUDForView:self.view];
	if (hud) {
		[hud show:YES];
	}else{
		hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
	}
	hud.labelText=hintString;
	hud.mode=MBProgressHUDModeIndeterminate;
	
	return hud;
}

//延迟在View的动画
- (void)showResultThenHide:(NSString *)resultString{
	[self showResultThenHIde:resultString afterDelay:0.7 onView:self.view];
	
}
- (void)showResultThenHIde:(NSString *)resultString afterDelay:(NSTimeInterval)delay onView:(UIView *)view{
	MBProgressHUD *hud=[MBProgressHUD HUDForView:view];
	if (!hud) {
		hud=[MBProgressHUD showHUDAddedTo:view animated:YES];
	}
	hud.labelText=resultString;
	hud.mode=MBProgressHUDModeText;
	[hud show:YES];
	[hud hide:YES afterDelay:delay];
}

-(void)theBtnPressed:(RMCQFLOATINGTOOLBAR_FNUCTION_TYPE )type addButton:(UIButton *)button{
    _functionType=type;
    if (type==RMCQFLOATINGTOOLBAR_FNUCTION_ADD) {
        if (_isSetCenter) {
            dispatch_async(dispatch_get_main_queue(), ^{
                LCAlertView*alertView=[[LCAlertView alloc]initForLCAlertViewType:LC_ALERTVIEW_RADIUS];
                __weak LCMapViewController *temp=self;
                alertView.clickOkBlock=^(NSString* textValue,LC_ALERTVIEW_TYPE type){
                    [[LCRailManager shareManager] railInfo].radius=[textValue doubleValue];
                    [temp addRailForRailInfo:[LCRailManager shareManager].railInfo];
                    [_bdMapView addRailCenterAnnotationToBdMapViewForRailInfo:_railInfo];
                    [_bdMapView drawsRailForRailInfo:_railInfo];
                    _isSetCenter=NO;
                    [button setTitle:@"重新设置电子围栏" forState:UIControlStateNormal];
                };
                [alertView show];
            });
        }else{
            [_bdMapView setCenterPonitForLongPressMap];
            _setButton=button;
            [self showResultThenHide:@"请长按地图设置中心点"];
        }
    }else if (type==RMCQFLOATINGTOOLBAR_FNUCTION_RESET){
        if (_isSetCenter) {
            dispatch_async(dispatch_get_main_queue(), ^{
                LCAlertView*alertView=[[LCAlertView alloc]initForLCAlertViewType:LC_ALERTVIEW_RADIUS];
                __weak LCMapViewController *temp=self;
                alertView.clickOkBlock=^(NSString* textValue,LC_ALERTVIEW_TYPE type){
                    [[LCRailManager shareManager] railInfo].radius=[textValue doubleValue];
                    [temp addRailForRailInfo:[LCRailManager shareManager].railInfo];
                    [_bdMapView addRailCenterAnnotationToBdMapViewForRailInfo:_railInfo];
                    [_bdMapView drawsRailForRailInfo:_railInfo];
                    _isSetCenter=NO;
                    [button setTitle:@"重新设置电子围栏" forState:UIControlStateNormal];
                };
                [alertView show];
            });
        }else{
            [_bdMapView setCenterPonitForLongPressMap];
            _setButton=button;
            [self showResultThenHide:@"请长按地图设置中心点"];
        }
    }else if (type==RMCQFLOATINGTOOLBAR_FNUCTION_DELETE){
        [self deleteRailForRailInfo:[LCRailManager shareManager].railInfo];
        [LCRailManager shareManager].railInfo=nil;
        [_floatingToolBar dismiss];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
