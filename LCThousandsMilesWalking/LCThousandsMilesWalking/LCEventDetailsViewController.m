//
//  LCEventDetailsViewController.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/9/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCEventDetailsViewController.h"

@interface LCEventDetailsViewController ()

@end

@implementation LCEventDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	UIBarButtonItem* baritem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"完成",@"完成") style:UIBarButtonItemStylePlain target:self action:@selector(saveEventDetails:)];
	self.navigationItem.rightBarButtonItem = baritem;
	self.title=@"详细信息";
    
    [_warnFlagSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
	
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    NSArray*dataArray=[locationString componentsSeparatedByString:@"-"];
    NSString*year=[dataArray objectAtIndex:0];
    NSString*moth=[dataArray objectAtIndex:1];
    NSString*day=[dataArray objectAtIndex:2];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@-%@-%@",year,moth,day]];
    [_warnDate setText:[NSString stringWithFormat:@"%@年%@月%@日",year,moth,day]];
    [[LCWarnManager shareManager]warnInfo].warndate=date;
    
    if (_warnInfo!=nil) {
        [self setEventRemindInfo];
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveEventDetails:(id)sender{
    [self addWarnInfo];
}

-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        [[LCWarnManager shareManager]warnInfo].warnflag=1;
    }else {
        [[LCWarnManager shareManager]warnInfo].warnflag=0;
    }
}

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString addPickType:(LC_PICKE_TYPE)pickType{
    if (pickType==  LC_PICKE_BIRTHDAY) {
        NSArray*timeArray=[resultString componentsSeparatedByString:@" "];
        NSString*time=[timeArray objectAtIndex:0];
        NSArray*dataArray=[time componentsSeparatedByString:@"-"];
        NSString*year=[dataArray objectAtIndex:0];
        NSString*moth=[dataArray objectAtIndex:1];
        NSString*day=[dataArray objectAtIndex:2];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@-%@-%@",year,moth,day]];
        [_warnDate setText:[NSString stringWithFormat:@"%@年%@月%@日",year,moth,day]];
        [[LCWarnManager shareManager]warnInfo].warndate=date;
    }
}

-(void)addWarnInfo{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:[[LCWarnManager shareManager]warnInfo].warndate];
    [[LCWarnManager shareManager]warnInfo].warncontent=_warnContent.text;
    [[LCWarnManager shareManager]warnInfo].warnremark=_warnRemark.text;
    if (_warnContent.text.length!=0) {
        [self showHUDLoading:@"保存数据中"];
        [WTRequestCenter postWithoutCacheURL:[NSURL URLWithString:@"http://120.25.222.190:8081/qlxb/app/warn.do?save"] parameters:@{@"User.id":[[LCUserManager shareManager] userInfo].userID,@"Warntitle":[[LCWarnManager shareManager]warnInfo].warnTitle,@"warncontent":[[LCWarnManager shareManager]warnInfo].warncontent,@"Warndate":strDate,@"warnType":[NSNumber numberWithInteger:[[LCWarnManager shareManager]warnInfo].warnType],@"Warnflag":[NSNumber numberWithInteger:[[LCWarnManager shareManager]warnInfo].warnflag],@"Warnremark":[[LCWarnManager shareManager]warnInfo].warnremark} completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            
            NSDictionary *obj = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            
            
            NSString*state=[NSString stringWithFormat:@"%@",[obj objectForKey:@"state"]];
            NSString*msg=[obj objectForKey:@"msg"];
            if ([state isEqualToString:@"1"]) {
                [self showResultThenHide:msg];
            }
        }];
    }
}

-(void)setEventRemindInfo{
    if (_warnInfo) {
        _warnContent.text=_warnInfo.warncontent;
        if (_warnInfo.warnflag==0) {
            _warnFlagSwitch.selected=NO;
        }else if (_warnInfo.warnflag==1){
            _warnFlagSwitch.selected=YES;
        }
        if (_warnInfo.warnType==1){
            _warnTypeLable.text=@"作息提醒";
        }else if (_warnInfo.warnType==2){
            _warnTypeLable.text=@"事件提醒";
        }
        _warnRemark.text=_warnInfo.warnremark;
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

- (IBAction)slectDate:(id)sender {
    
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:9000000];
    _pickview=[[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO addPickType:LC_PICKE_BIRTHDAY];
    _pickview.delegate=self;
    [_pickview show];
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
