//
//  LCPersonaDataViewController.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCPersonaDataViewController.h"
#import "LCBasicTableViewCell.h"

@interface LCPersonaDataViewController ()

@end

@implementation LCPersonaDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=NO;
    self.title=@"个人信息";
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTableBbarViewController" object:nil
                                                      userInfo:@{@"hidden":@"0"}];
	[self selectUserInfo];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTableBbarViewController" object:nil
                                                      userInfo:@{@"hidden":@"0"}];
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.hidden=YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTableBbarViewController" object:nil
                                                      userInfo:@{@"hidden":@"1"}];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }else if(section == 1) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        static NSString *cellIdentifier =@"Cell_Basic";
        LCBasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
        if(cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LCBasicTableViewCell" owner:self options:nil];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell = [nib objectAtIndex:0];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
        }
        if (indexPath.row==0) {
            cell.titleLable.text=@"真实姓名";
            if ([[LCUserManager shareManager]userInfo].userName.length==0) {
                cell.contentLabel.text=@"请填写你的姓名";
                cell.contentLabel.alpha=0.5;
            }else{
                cell.contentLabel.text=[[LCUserManager shareManager]userInfo].userName;
                cell.contentLabel.alpha=0.5;
            }
        }
        else if (indexPath.row==1){
            cell.titleLable.text=@"性      别";
            if ([NSString stringWithFormat:@"%ld",[[LCUserManager shareManager]userInfo].sex].length==0) {
                cell.contentLabel.text=@"请选择你的性别";
                cell.contentLabel.alpha=0.5;
            }else{
                if ([[LCUserManager shareManager]userInfo].sex==1) {
                    cell.contentLabel.text=[NSString stringWithFormat:@"男"];
                    cell.contentLabel.alpha=1;
                }else if ([[LCUserManager shareManager]userInfo].sex==0){
                    cell.contentLabel.text=[NSString stringWithFormat:@"女"];
                    cell.contentLabel.alpha=1;
                    
                }
            }        }else if (indexPath.row==2){
            cell.titleLable.text=@"生 日";
            cell.contentLabel.text=@"请选择你的生日";
        }else if (indexPath.row==3){
            cell.titleLable.text=@"星      座";
            if ([[LCUserManager shareManager]userInfo]==0) {
                cell.contentLabel.text=@"请选择你的星座";
                cell.contentLabel.alpha=0.5;
            }else{
                cell.contentLabel.text=[[LCUserManager shareManager]userInfo].constellation;
                cell.contentLabel.alpha=1;
            }
        }
        return cell;
    }else if(indexPath.section == 1) {
        static NSString *cellIdentifier =@"Cell_Basic";
        LCBasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
        if(cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LCBasicTableViewCell" owner:self options:nil];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell = [nib objectAtIndex:0];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
        }
        if (indexPath.row==0) {
            cell.titleLable.text=@"是否是服务提供者";
            if ([NSString stringWithFormat:@"%ld",[[LCUserManager shareManager]userInfo].serviceflag].length==0) {
                cell.contentLabel.text=@"是";
                cell.contentLabel.alpha=0.5;
            }else{
                if ([[LCUserManager shareManager]userInfo].serviceflag==0) {
                    cell.contentLabel.text=@"非服务提供者";
                    cell.contentLabel.alpha=1;
                }else if ([[LCUserManager shareManager]userInfo].serviceflag==1){
                    cell.contentLabel.text=@"服务提供者";
                    cell.contentLabel.alpha=1;
                }
            }
            cell.contentLabel.textAlignment=UITextAlignmentRight;
        }
        return cell;

    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;//这里取字典里面的值时是0,请问我要怎么改
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            LCAlertView*alertView=[[LCAlertView alloc]initForLCAlertViewType:LC_ALERTVIEW_NAME];
            __weak LCPersonaDataViewController *temp=self;
            alertView.clickOkBlock=^(NSString* textValue,LC_ALERTVIEW_TYPE type){
                [[LCUserManager shareManager]userInfo].userName=textValue;
                [temp.tableView reloadData];
            };
            [alertView show];
        }else if (indexPath.row==1){
            NSArray *array=@[@[@"男",@"女"]];
            _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO addPickType:LC_PICKE_SEX];
            _pickview.delegate=self;
            [_pickview show];
        }else if (indexPath.row==3){
            NSArray *array=@[@[@"白羊座",@"金牛座",@"双子座",@"巨蟹座",@"狮子座",@"处女座",@"天枰座",@"天蝎座",@"射手座",@"摩羯座",@"水瓶座",@" 双鱼座"]];
            _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO addPickType:LC_PICKE_CONSTELLATION];
            _pickview.delegate=self;
            [_pickview show];
        }else if (indexPath.row==2){
            NSDate *date=[NSDate dateWithTimeIntervalSinceNow:9000000];
            _pickview=[[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO addPickType:LC_PICKE_BIRTHDAY];
            _pickview.delegate=self;
            [_pickview show];
        }

    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            NSArray *array=@[@[@"非服务提供者",@"服务提供者"]];
            _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO addPickType:LC_PICKE_SERVICEFLAG];
            _pickview.delegate=self;
            [_pickview show];
        }
    }
}


#pragma mark ZhpickVIewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString addPickType:(LC_PICKE_TYPE)pickType{
    
    if (pickType==  LC_PICKE_SEX){
        if ([resultString isEqualToString:@"男"]) {
            [[LCUserManager shareManager]userInfo].sex=1;
        }else{
            [[LCUserManager shareManager]userInfo].sex=0;
        }
        [_tableView reloadData];
        
        
    }else if (pickType==  LC_PICKE_SERVICEFLAG){
        if ([resultString isEqualToString:@"非服务提供者"]) {
            [[LCUserManager shareManager]userInfo].serviceflag=0;
        }else{
            [[LCUserManager shareManager]userInfo].serviceflag=1;
        }
        [_tableView reloadData];
        
        
    }else if (pickType==  LC_PICKE_BIRTHDAY){
        NSArray*timeArray=[resultString componentsSeparatedByString:@" "];
        NSString*time=[timeArray objectAtIndex:0];
        NSArray*dataArray=[time componentsSeparatedByString:@"-"];
        NSString*year=[dataArray objectAtIndex:0];
        NSString*moth=[dataArray objectAtIndex:1];
        NSString*day=[dataArray objectAtIndex:2];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@-%@-%@",year,moth,day]];
        
        [[LCUserManager shareManager]userInfo].birthday=date;
        [_tableView reloadData];
        
        
    }else if (pickType==  LC_PICKE_CONSTELLATION){
        [[LCUserManager shareManager]userInfo].constellation=resultString;
        [_tableView reloadData];
        
        
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

-(void)selectUserInfo{
	NSLog(@"%@",[LCUserManager shareManager].userInfo.userID);
	[WTRequestCenter postWithoutCacheURL:[NSURL URLWithString:@"http://120.25.222.190:8081/qlxb/app/userinfo.do?detail"] parameters:@{@"id":[LCUserManager shareManager].userInfo.userID} completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
		
		NSDictionary *obj = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
		NSInteger state=[[obj objectForKey:@"state"] integerValue];
		NSString*msg=[obj objectForKey:@"msg"];
		NSDictionary*datailDic=[[obj objectForKey:@"data" ] objectForKey:@"detail"];
		if (state==1 ) {
			[self showResultThenHide:msg];
			[LCUserManager shareManager].userInfo.userName=[datailDic objectForKey:@"username"];
			[LCUserManager shareManager].userInfo.sex=[[datailDic objectForKey:@"sex"] intValue];
			NSDate *birthday = [NSDate dateWithTimeIntervalSinceReferenceDate:[[datailDic objectForKey:@"birthday"] doubleValue]];
			//			NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
			//			//zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
			//			[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
			//			NSString *destDateString = [dateFormatter stringFromDate:birthday];
			[LCUserManager shareManager].userInfo.birthday=birthday;
			[LCUserManager shareManager].userInfo.vocation=[datailDic objectForKey:@"vocation"];
			[LCUserManager shareManager].userInfo.homeadd=[datailDic objectForKey:@"homeadd"];
			[LCUserManager shareManager].userInfo.hobbies=[datailDic objectForKey:@"hobbies"];
			//			[LCUserManager shareManager].userInfo.modifytime=[datailDic objectForKey:@"vocation"];
			[LCUserManager shareManager].userInfo.maritalstatus=[[datailDic objectForKey:@"maritalstatus"] intValue];
			[LCUserManager shareManager].userInfo.constellation=[datailDic objectForKey:@"constellation"];
			[LCUserManager shareManager].userInfo.educationlevel=[datailDic objectForKey:@"educationlevel"];
			[LCUserManager shareManager].userInfo.serviceflag=[[datailDic objectForKey:@"serviceflag"] intValue];
			[_tableView reloadData];
		}else{
			[self showResultThenHide:msg];
		}
		
	}];
}


- (IBAction)clikOkButton:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:[[LCUserManager shareManager]userInfo].birthday];
    
    [self showResultThenHide:@"正在保存"];
    
    [WTRequestCenter postWithoutCacheURL:[NSURL URLWithString:@"http://120.25.222.190:8081/qlxb/app/userinfo.do?save"] parameters:@{@"user.id":[LCUserManager shareManager].userInfo.userID,@"username":[LCUserManager shareManager].userInfo.userName,@"birthday":strDate,@"sex":[NSNumber numberWithInt:[LCUserManager shareManager].userInfo.sex],@"constellation":[LCUserManager shareManager].userInfo.constellation,@"serviceflag":[NSNumber numberWithInt:[LCUserManager shareManager].userInfo.serviceflag]} completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
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

@end
