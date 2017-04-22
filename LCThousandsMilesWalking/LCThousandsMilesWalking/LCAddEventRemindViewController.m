//
//  LCAddEventRemindViewController.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/8/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCAddEventRemindViewController.h"

@interface LCAddEventRemindViewController ()

@end

@implementation LCAddEventRemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem* baritem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"保存",@"保存") style:UIBarButtonItemStylePlain target:self action:@selector(complete:)];
    self.navigationItem.rightBarButtonItem = baritem;
	self.title=@"新建提醒事件";
	[self initRadioButton];
    LCWarnInfo*warInfo=[[LCWarnInfo alloc] init];
    [[LCWarnManager shareManager]setWarnInfo:warInfo];
	
    // Do any additional setup after loading the view.
}
-(void)initRadioButton{
	RadioButton *rb1 = [[RadioButton alloc] initWithGroupId:@"first group" index:0];
	
	RadioButton *rb2 = [[RadioButton alloc] initWithGroupId:@"first group" index:1];
	[rb1 setChecked:YES];
	[RadioButton addObserverForGroupId:@"first group" observer:self];
	rb1.frame = CGRectMake(10,8,30,30);
	rb2.frame = CGRectMake(self.view.frame.size.width*1/3,8,30,30);
	
	UILabel* lb1=[[UILabel alloc]initWithFrame:CGRectMake(rb1.frame.origin.x+30, 5, 100, 30)];
	[lb1 setText:@"作息提醒"];
	[self.buttonView addSubview:lb1];
	UILabel* lb2=[[UILabel alloc]initWithFrame:CGRectMake(rb2.frame.origin.x+30, 5, 100, 30)];
	[lb2 setText:@"事件提醒"];
	[self.buttonView addSubview:lb2];
    [[LCWarnManager shareManager]warnInfo].warnType=0;
	
	
	[self.buttonView addSubview:rb1];
	[self.buttonView addSubview:rb2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)complete:(id)sender
{
    if (_warnTitle.text.length!=0) {
        [[LCWarnManager shareManager]warnInfo].warnTitle=_warnTitle.text;
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LCEventDetailsViewController*eventDetailsViewController= [storyboard instantiateViewControllerWithIdentifier:@"EventDetailsViewController"];
        [self.navigationController pushViewController:eventDetailsViewController animated:YES];
    }else{
        [self showResultThenHide:@"请输入标题"];
    }

    
}
-(void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString*)groupId{
    if (index==0) {
        [[LCWarnManager shareManager]warnInfo].warnType=index;
    }else if (index==1){
        [[LCWarnManager shareManager]warnInfo].warnType=index;
    }
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
