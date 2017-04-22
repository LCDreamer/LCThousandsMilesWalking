//
//  LCUserViewController.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCUserViewController.h"
#import "LCPersonalTableViewCell.h"
#import "LCEventTableViewCell.h"
#import "LCUserTableViewCell.h"
#import "LCNavigationController.h"
#import "LCPersonalnformationViewController.h"
#import "LCChangePasswordViewController.h"
#import "LCFeedbackViewController.h"
#import "LCContactUsViewController.h"
#import "LCAboutViewController.h"
#import "LCSettingViewController.h"
#import "LCUserManager.h"


@interface LCUserViewController ()

@end

@implementation LCUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    [self.view setBackgroundColor:[UIColor greenColor]];
    
    UIImageView* backGroundImage=[[UIImageView alloc] init];
    backGroundImage.translatesAutoresizingMaskIntoConstraints=NO;
    [backGroundImage setImage:[UIImage imageNamed:@"userbackground.png"]];
    [self.view addSubview:backGroundImage];
    
    NSMutableArray * tempConstraints = [NSMutableArray array];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[backGroundImage]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(backGroundImage)]];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[backGroundImage]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(backGroundImage)]];
    [self.view addConstraints:tempConstraints];
    
    _tableView=[[UITableView alloc] init];
    _tableView.translatesAutoresizingMaskIntoConstraints=NO;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_tableView];
    
    NSMutableArray * tableViewtempConstraints = [NSMutableArray array];
    [tableViewtempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]-110-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    [tableViewtempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    [self.view addConstraints:tableViewtempConstraints];
    NSData*headIconData=[LCUserManager readheadIconDataFromFile:[LCUserManager dataFilepath]];
    if ([headIconData length]!=0) {
        [LCUserManager shareManager].userInfo.headIcon=headIconData;
    }
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        static NSString *cellIdentifier = @"Cell_Personal";
        LCPersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
        if(cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LCPersonalTableViewCell" owner:self options:nil];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell = [nib objectAtIndex:0];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            [cell setBackgroundColor:[UIColor clearColor]];
            cell.headurlImageView.layer.cornerRadius=30;
            cell.headurlImageView.layer.masksToBounds = YES;
            if ([[LCUserManager shareManager] userInfo].nickName.length!=0) {
                cell.nicknameLabel.text=[[LCUserManager shareManager] userInfo].nickName;
            }
            if ([[LCUserManager shareManager] userInfo].headurl.length!=0) {
                
            }
            if ([[LCUserManager shareManager] userInfo].phone.length!=0) {
                cell.emailLabel.text=[[LCUserManager shareManager]userInfo].phone;
            }
            if ([[LCUserManager shareManager] userInfo].headIcon!=nil) {
                cell.headurlImageView.image=[UIImage imageWithData:[[LCUserManager shareManager] userInfo].headIcon];
            }

            
        }
        return cell;
    }else{
        static NSString *cellIdentifier = @"Cell_User";
        LCUserTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
        if(cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LCUserTableViewCell" owner:self options:nil];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell = [nib objectAtIndex:0];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell setBackgroundColor:[UIColor clearColor]];
            
            if (indexPath.row==1) {
                [cell.imageIcon setImage:[UIImage imageNamed:@"user_password.png"]];
                cell.titleName.text=@"修改密码";
            }else if (indexPath.row==2){
                [cell.imageIcon setImage:[UIImage imageNamed:@"user_opinion.png"]];
                cell.titleName.text=@"意见反馈";
                
            }else if (indexPath.row==3){
                [cell.imageIcon setImage:[UIImage imageNamed:@"user_our.png"]];
                cell.titleName.text=@"联系我们";
                
            }else if (indexPath.row==4){
                [cell.imageIcon setImage:[UIImage imageNamed:@"user_about.png"]];
                cell.titleName.text=@"关于版本";
                
            }else if (indexPath.row==5){
                [cell.imageIcon setImage:[UIImage imageNamed:@"user_setting.png"]];
                cell.titleName.text=@"设置";
                
            }
        }
        return cell;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 150;//这里取字典里面的值时是0,请问我要怎么改
        
    }else{
        return 60;//这里取字典里面的值时是0,请问我要怎么改
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LCPersonalnformationViewController * PersonalnformationViewController = [storyboard instantiateViewControllerWithIdentifier:@"PersonalnformationViewController"];
        [self.navigationController pushViewController:PersonalnformationViewController animated:YES];
    }else if (indexPath.row==1){
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LCChangePasswordViewController * changePasswordViewController = [storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
        [self.navigationController pushViewController:changePasswordViewController animated:YES];
    }else if (indexPath.row==2){
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LCFeedbackViewController * feedbackViewController = [storyboard instantiateViewControllerWithIdentifier:@"FeedbackViewController"];
        [self.navigationController pushViewController:feedbackViewController animated:YES];
    }else if (indexPath.row==3){
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LCContactUsViewController * contactUsViewController = [storyboard instantiateViewControllerWithIdentifier:@"ContactUsViewController"];
        [self.navigationController pushViewController:contactUsViewController animated:YES];
        
    }else if (indexPath.row==4){
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LCAboutViewController * aboutViewController = [storyboard instantiateViewControllerWithIdentifier:@"AboutViewController"];
        [self.navigationController pushViewController:aboutViewController animated:YES];
    }else if (indexPath.row==5){
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LCSettingViewController * settingViewController = [storyboard instantiateViewControllerWithIdentifier:@"SettingViewController"];
        [self.navigationController pushViewController:settingViewController animated:YES];
    }
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
