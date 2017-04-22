//
//  LCAddDeviceViewController.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/8/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCAddDeviceViewController.h"
#import "LCUserManager.h"
#import "LCDeviceManager.h"
@interface LCAddDeviceViewController ()

@end

@implementation LCAddDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideVehicleBtn" object:nil
                                                      userInfo:@{@"hidden":@"0"}];
	
	LCDeviceInfo*userInfo=[[LCDeviceInfo alloc] init];
	[[LCDeviceManager shareManager] setDeviceInfo:userInfo];
	[[LCDeviceManager shareManager] deviceInfo].deviceFacilitynum=@"1234567788";
	
	_deviceText.delegate=self;
	[[LCDeviceManager shareManager] deviceInfo].deviceHredurl=@"head0";
	NSLog(@"%@",[[LCDeviceManager shareManager] deviceInfo].deviceHredurl);
	
	_headPort.clickHeadPortraitBlock=^(NSInteger headIndex){
		[[LCDeviceManager shareManager] deviceInfo].deviceHredurl=[NSString stringWithFormat:@"head%ld",headIndex];
		NSLog(@"%@",[NSString stringWithFormat:@"head%ld",headIndex]);
		NSLog(@"%@",[[LCDeviceManager shareManager] deviceInfo].deviceHredurl);
	};
	
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideVehicleBtn" object:nil
                                                      userInfo:@{@"hidden":@"0"}];
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideVehicleBtn" object:nil
                                                      userInfo:@{@"hidden":@"1"}];
}


-(void)addDevice{
    
	
    NSLog(@"[LCUserManager shareManager].userInfo.userID %@",[LCUserManager shareManager].userInfo.userID);
    NSLog(@"[LCUserManager shareManager].userInfo.userID %@",[[LCDeviceManager shareManager] deviceInfo].deviceFacilitynum);
    NSLog(@"[LCUserManager shareManager].userInfo.userID %@",[[LCDeviceManager shareManager] deviceInfo].deviceHredurl);
    
    [WTRequestCenter postWithoutCacheURL:[NSURL URLWithString:@"http://120.25.222.190:8081/qlxb/app/facility.do?save"] parameters:@{@"facilitynum":[[LCDeviceManager shareManager] deviceInfo].deviceFacilitynum,@"hredurl":[[LCDeviceManager shareManager] deviceInfo].deviceHredurl,@"user.id":[LCUserManager shareManager].userInfo.userID} completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
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

- (IBAction)addDevices:(id)sender {
    [self addDevice];
}

- (IBAction)backRegsiter:(id)sender {
	[_deviceText resignFirstResponder];
}
@end
