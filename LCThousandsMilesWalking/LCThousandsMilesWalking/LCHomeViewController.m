//
//  LCHomeViewController.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCHomeViewController.h"
#import "LCDeviceTableViewCell.h"

@interface LCHomeViewController ()

@end

@implementation LCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem* baritem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(adddevice:)];
    self.navigationItem.rightBarButtonItem = baritem;
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self selectAllDevices];
    [self loadAddViewForAutoayout];
}
-(void)adddevice:(id)sender{
	
	UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	LCAddDeviceViewController*deviceViewController= [storyboard instantiateViewControllerWithIdentifier:@"AddDeviceViewController"];
	[self.navigationController pushViewController:deviceViewController animated:YES];
	
}
-(void)loadAddViewForAutoayout{
    if ([[[LCDeviceManager shareManager]deviceArray]count]>0) {
        [_addView removeConstraints:_addView.constraints];
        NSMutableArray * tempConstraints = [NSMutableArray array];
        _tableView=[[UITableView alloc]init];
        _tableView.translatesAutoresizingMaskIntoConstraints=NO;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_addView addSubview:_tableView];
        [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[_addDeviceButton]-50-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_addDeviceButton)]];
        [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_tableView]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
        [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_addDeviceButton(==50)]-[_tableView]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_addDeviceButton,_tableView)]];
        [_addView addConstraints:tempConstraints];
    }else{
        _tableView.hidden=YES;
        [_addView addConstraint:[NSLayoutConstraint constraintWithItem:_addDeviceButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_addView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        [_addDeviceButton addConstraint:[NSLayoutConstraint
                                      constraintWithItem:_addDeviceButton
                                      attribute:NSLayoutAttributeHeight
                                      relatedBy:NSLayoutRelationGreaterThanOrEqual
                                      toItem:nil
                                      attribute:NSLayoutAttributeNotAnAttribute
                                      multiplier:1
                                      constant:80]];
    }
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        LCDeviceInfo*deviceInfo=[[[LCDeviceManager shareManager] deviceArray] objectAtIndex:indexPath.row];
        [self deleteDeviceForDeviceInfo:deviceInfo forRowAtIndexPath:indexPath];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	LCMapViewController * mapViewController = [storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
	LCDeviceInfo*deviceInfo=[[[LCDeviceManager shareManager] deviceArray] objectAtIndex:indexPath.row];
	mapViewController.deviceInfo=deviceInfo;
	mapViewController.hidesBottomBarWhenPushed=YES;
	[self.navigationController pushViewController:mapViewController animated:YES];
}



-(NSString *)getAstroWithMonth:(int)m day:(int)d{
    
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result;
    
    if (m<1||m>12||d<1||d>31){
        return @"错误日期格式!";
    }
    
    if(m==2 && d>29)
    {
        return @"错误日期格式!!";
    }else if(m==4 || m==6 || m==9 || m==11) {
        
        if (d>30) {
            return @"错误日期格式!!!";
        }
    }
    
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(m*2-(d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*2,2)]];
    
    
    return result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)selectAllDevices{
    NSLog(@"%@",[LCUserManager shareManager].userInfo.userID);
    [WTRequestCenter postWithoutCacheURL:[NSURL URLWithString:@"http://120.25.222.190:8081/qlxb/app/facility.do?page"] parameters:@{@"userId":[LCUserManager shareManager].userInfo.userID,@"PageSize":[NSNumber numberWithInteger:1000],@"pageNo":[NSNumber numberWithInteger:0]} completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        [LCDeviceManager shareManager].deviceArray=[[NSMutableArray alloc] init];
        NSDictionary *obj = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSInteger state=[[obj objectForKey:@"state"]integerValue];
        NSDictionary*dataDic=[obj objectForKey:@"data"];
        NSArray*listArray=[dataDic objectForKey:@"list"];
        for (int i=0; i<[listArray count]; i++) {
            NSDictionary* valueDic=[listArray objectAtIndex:i];
            LCDeviceInfo*deiceInfo=[[LCDeviceInfo alloc]init];
            deiceInfo.deviceHredurl=[valueDic objectForKey:@"hredurl"];
            deiceInfo.deviceID=[valueDic objectForKey:@"id"];
			NSLog(@"%@",deiceInfo.deviceID);
            deiceInfo.deviceFacilitynum=[valueDic objectForKey:@"modifytime"];
            [[[LCDeviceManager shareManager] deviceArray] addObject:deiceInfo];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
            [self loadAddViewForAutoayout];
        });
        NSString*msg=[obj objectForKey:@"msg"];
        if (state==1 ) {
            [self showResultThenHide:msg];
        }else{
            [self showResultThenHide:msg];
        }
    }];
}

-(void)deleteDeviceForDeviceInfo:(LCDeviceInfo*)deviceInfo forRowAtIndexPath:(NSIndexPath *)indexPath{
    _result = NO;
    [self showHUDLoading:@"正在删除"];
    [WTRequestCenter postWithoutCacheURL:[NSURL URLWithString:@"http://120.25.222.190:8081/qlxb/app/facility.do?del"] parameters:@{@"id":deviceInfo.deviceID} completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSDictionary *obj = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSString*state=[NSString stringWithFormat:@"%@",[obj objectForKey:@"state"]];
        NSString*msg=[obj objectForKey:@"msg"];
        if ([state isEqualToString:@"1"]) {
            [self showResultThenHide:msg];
            [[LCDeviceManager shareManager].deviceArray removeObjectAtIndex:indexPath.row];
            [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];        }else
            {
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

- (IBAction)clickAddDevices:(id)sender {
    [self loadAddViewForAutoayout];
}
@end
