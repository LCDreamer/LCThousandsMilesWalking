//
//  LCDeviceViewController.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCDeviceViewController.h"
#import "LCDeviceTableViewCell.h"
#import "LCMapViewController.h"

@interface LCDeviceViewController ()

@end

@implementation LCDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem* baritem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(adddevice:)];
    
    self.navigationItem.rightBarButtonItem = baritem;
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_myTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)adddevice:(id)sender
{
	UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	LCAddDeviceViewController*deviceViewController= [storyboard instantiateViewControllerWithIdentifier:@"AddDeviceViewController"];
	[self.navigationController pushViewController:deviceViewController animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[LCDeviceManager shareManager] deviceArray] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell_Device";
    LCDeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LCDeviceTableViewCell" owner:self options:nil];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell = [nib objectAtIndex:0];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
    }
    LCDeviceInfo*deviceInfo=[[[LCDeviceManager shareManager] deviceArray] objectAtIndex:indexPath.row];
    cell.deviceID.text=deviceInfo.deviceID;
	cell.headIcon.image=[UIImage imageNamed:deviceInfo.deviceHredurl];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;//这里取字典里面的值时是0,请问我要怎么改
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LCMapViewController * mapViewController = [storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
	LCDeviceInfo*deviceInfo=[[[LCDeviceManager shareManager] deviceArray] objectAtIndex:indexPath.row];
	mapViewController.deviceInfo=deviceInfo;
    mapViewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:mapViewController animated:YES];
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
