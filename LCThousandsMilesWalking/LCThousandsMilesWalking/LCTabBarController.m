//
//  LCTabBarController.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCTabBarController.h"
#import "LCHomeViewController.h"
#import "AppDelegate.h"
#import "LCSideViewController.h"
#import "LCLoginViewController.h"


@interface LCTabBarController ()

@end

@implementation LCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITabBar *tabBar = self.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];

    
    UIImage* homeImageNormal = [UIImage imageNamed:@"home_normal.png"];
    UIImage* homeImageSelected = [UIImage imageNamed:@"home_select.png"];
    UIImage* deviceImageNormal = [UIImage imageNamed:@"Device_normal.png"];
    UIImage* deviceImageSelected = [UIImage imageNamed:@"Device_select.png"];
    UIImage* eventremindImageNormal = [UIImage imageNamed:@"eventremind_normal.png"];
    UIImage* eventremindImageSelected = [UIImage imageNamed:@"eventremind_select.png"];
    if ([[[UIDevice currentDevice] systemVersion]doubleValue] > 7.0) {
        tabBarItem1.selectedImage = [homeImageSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        tabBarItem1.image = [homeImageNormal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tabBarItem2.selectedImage = [deviceImageSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tabBarItem2.image = [deviceImageNormal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tabBarItem3.selectedImage = [eventremindImageSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tabBarItem3.image = [eventremindImageNormal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        [tabBarItem1 setFinishedSelectedImage:homeImageSelected withFinishedUnselectedImage:homeImageNormal];
        [tabBarItem2 setFinishedSelectedImage:deviceImageSelected withFinishedUnselectedImage:deviceImageNormal];
        [tabBarItem3 setFinishedSelectedImage:eventremindImageSelected withFinishedUnselectedImage:eventremindImageNormal];
    }
    

    self.vehicleBtn = [[UIButton alloc] init];
    _vehicleBtn.tag=100;
    self.delegate=self;
    [_vehicleBtn setFrame:CGRectMake(10, 30, 30, 30)];
    [_vehicleBtn setBackgroundImage:[UIImage imageNamed:@"sidebar.png"] forState:UIControlStateNormal];
    [_vehicleBtn addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_vehicleBtn];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(hideVehicleBtn:) name:@"hideVehicleBtn" object:nil];
    
    
    // Do any additional setup after loading the view.
}

- (void)hideVehicleBtn:(NSNotification*) notification{
    NSDictionary *nameDictionary = [notification userInfo];
    if ( [[nameDictionary objectForKey:@"hidden"] isEqualToString:@"0"]) {
        [self setHidesVehicleBtn:YES];
    }else{
        [self setHidesVehicleBtn:NO];
    }
    
}


-(void)setHidesVehicleBtn:(BOOL)isHide{
    if (isHide) {
        _vehicleBtn.hidden=YES;
    }else{
        _vehicleBtn.hidden=NO;
    }
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (tabBarController.selectedIndex==1 || tabBarController.selectedIndex==2) {
        [self setHidesVehicleBtn:YES];
    }else if (tabBarController.selectedIndex==0){
        [self setHidesVehicleBtn:NO];
    }
}


- (void)leftAction:(UIButton *)btn
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sidebarOpenOrClose" object:nil
                                                      userInfo:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
