//
//  LCQuietTimeViewController.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/8/15.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCQuietTimeViewController.h"

@interface LCQuietTimeViewController ()

@end

@implementation LCQuietTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"静音时段";
    [self initSelectOnNav];
    [self selectQuietTime];
	
	
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

-(void)initSelectOnNav
{
    UIBarButtonItem* baritem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"保存",@"保存") style:UIBarButtonItemStylePlain target:self action:@selector(addQuietTime:)];
    self.navigationItem.rightBarButtonItem = baritem;
}

-(void)selectQuietTime{

    [WTRequestCenter postWithoutCacheURL:[NSURL URLWithString:@"http://120.25.222.190:8081/qlxb/app/quiettime.do?page"] parameters:@{@"Facilityid":_deviceInfo.deviceID,@"pageNo":[NSNumber numberWithInteger:0],@"PageSize":[NSNumber numberWithInteger:1000]} completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
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

-(void)addQuietTime:(id)sender{
    if ((_startTimeLabel1.text.length!=0 && _endTimeLabel1.text.length!=0)) {
        [WTRequestCenter postWithoutCacheURL:[NSURL URLWithString:@"http://120.25.222.190:8081/qlxb/app/quiettime.do?save"] parameters:@{@"Facilityid":_deviceInfo.deviceID,@"Starttime":_startTimeLabel1.text,@"Endtime":_endTimeLabel1.text} completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            
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
    if (_startTimeLabel2.text.length!=0 && _endTimeLabel2.text.length!=0) {
        [WTRequestCenter postWithoutCacheURL:[NSURL URLWithString:@"http://120.25.222.190:8081/qlxb/app/quiettime.do?save"] parameters:@{@"Facilityid":_deviceInfo.deviceID,@"Starttime":_startTimeLabel2.text,@"Endtime":_endTimeLabel2.text} completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            
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
    if (_startTimeLabel3.text.length!=0 && _endTimeLabel3.text.length!=0) {
        [WTRequestCenter postWithoutCacheURL:[NSURL URLWithString:@"http://120.25.222.190:8081/qlxb/app/quiettime.do?save"] parameters:@{@"Facilityid":_deviceInfo.deviceID,@"Starttime":_startTimeLabel1.text,@"Endtime":_endTimeLabel3.text} completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            
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

}

-(void)deleteQuietTime{
    [WTRequestCenter postWithoutCacheURL:[NSURL URLWithString:@"http://120.25.222.190:8081/qlxb/app/quiettime.do?del"] parameters:@{@"Id":_deviceInfo.deviceID} completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
