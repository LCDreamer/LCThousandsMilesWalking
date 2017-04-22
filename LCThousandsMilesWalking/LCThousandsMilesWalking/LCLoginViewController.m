//
//  LCLoginViewController.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCLoginViewController.h"
#import "AppDelegate.h"
#import "LCNavigationController.h"
#import "MBProgressHUD.h"
#import "LCUserInfo.h"
#import "LCUserManager.h"

@interface LCLoginViewController ()

@end

@implementation LCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(sidebarOpenOrClose:) name:@"sidebarOpenOrClose" object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(hideTableBbar:) name:@"hideTableBbarViewController" object:nil];
    
    
    _userNameTextField.text=@"18375874798";
    _passwordTextField.text=@"123456";

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

-(void)initSideViewController{
    
    LCNavigationController*navigationController=[[LCNavigationController alloc] init];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LCUserViewController * userViewController = [storyboard instantiateViewControllerWithIdentifier:@"UserViewController"];
    [navigationController addChildViewController:userViewController];
    LCTabBarController * tabBarController =[storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
    _sideViewController=[[LCSideViewController alloc]initWithNibName:nil bundle:nil];
    _sideViewController.rootViewController=tabBarController;
    _sideViewController.leftViewController=navigationController;
    _sideViewController.leftViewShowWidth=self.view.frame.size.width-100;
    _sideViewController.needSwipeShowMenu=true;//默认开启的可滑动展示
    //动画效果可以被自己自定义，具体请看api
   
    [self.navigationController presentViewController:_sideViewController animated:nil completion:nil];
}
- (void)sidebarOpenOrClose:(NSNotification*) notification{
    
    [_sideViewController showLeftViewController:true];
    
}
- (void)hideTableBbar:(NSNotification*) notification{
     NSDictionary *nameDictionary = [notification userInfo];
    if ( [[nameDictionary objectForKey:@"hidden"] isEqualToString:@"0"]) {
        [_sideViewController setCenterViewHide:YES];
    }else{
        [_sideViewController setCenterViewHide:NO];
    }
    
}
- (IBAction)clickLogin:(id)sender {
    
    [self initSideViewController];
    return;
    
    _userName=_userNameTextField.text;
    _password=_passwordTextField.text;
    
    NSURL *URL = [NSURL URLWithString:@"http://114.119.8.229:10083/key?username=admin&password=admin"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL.absoluteString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    if (_userName.length!=0 && _password.length!=0) {
        [WTRequestCenter postWithoutCacheURL:[NSURL URLWithString:@"http://120.25.222.190:8081/qlxb/app/user.do?login"] parameters:@{@"username":_userName,@"loginpwd":_password} completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {

            NSDictionary *obj = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            

            NSString*state=[NSString stringWithFormat:@"%@",[obj objectForKey:@"state"]];
            NSString*msg=[obj objectForKey:@"msg"];
            
            NSDictionary*userIdDic=[obj objectForKey:@"data"];
            
            LCUserInfo*userInfo=[[LCUserInfo alloc] init];
            userInfo.userID=[NSString stringWithFormat:@"%@",[userIdDic objectForKey:@"userId"]];
            [[LCUserManager shareManager] setUserInfo:userInfo];
            
            if ([state isEqualToString:@"1"]) {
                [self getUserDetails];
            }else{
                [self showResultThenHide:msg];

            }
        }];
    }else{
        if (_userName.length!=0 && _password.length!=0) {
            [self showResultThenHide:@"帐号，不能为空！"];

        }else if (_password.length == 0 && _userName.length!=0){
            [self showResultThenHide:@"密码，不能为空！"];

        }else{
            [self showResultThenHide:@"帐号或密码，不能为空！"];

        }
    }
    
}

-(void)getUserDetails{
        [WTRequestCenter postWithoutCacheURL:[NSURL URLWithString:@"http://120.25.222.190:8081/qlxb/app/user.do?detail"] parameters:@{@"id":[LCUserManager shareManager].userInfo.userID} completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSDictionary *obj = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        
        NSString*state=[NSString stringWithFormat:@"%@",[obj objectForKey:@"state"]];
        NSString*msg=[obj objectForKey:@"msg"];
        NSDictionary*datailDic=[[obj objectForKey:@"data" ] objectForKey:@"detail"];
        
        [[LCUserManager shareManager] userInfo].createtime=[datailDic objectForKey:@"createtime"];
        [[LCUserManager shareManager] userInfo].phone=[NSString stringWithFormat:@"%@",[datailDic objectForKey:@"loginacc"]];
        [[LCUserManager shareManager] userInfo].email=[NSString stringWithFormat:@"%@",[datailDic objectForKey:@"email"]];
        [[LCUserManager shareManager] userInfo].nickName=[NSString stringWithFormat:@"%@",[datailDic objectForKey:@"nickname"]];
 [self initSideViewController];[[LCUserManager shareManager] userInfo].headurl=[NSString stringWithFormat:@"%@",[datailDic objectForKey:@"headurl"]];
        [[LCUserManager shareManager] userInfo].openid=[NSString stringWithFormat:@"%@",[datailDic objectForKey:@"openid"]];
        [[LCUserManager shareManager] userInfo].loginteime=[datailDic objectForKey:@"logintime"];
        [[LCUserManager shareManager] userInfo].modifytime=[datailDic objectForKey:@"modifytime"];
        
        if ([state isEqualToString:@"1"]) {
            [self initSideViewController];
        }else{
            [self showResultThenHide:msg];
            
        }
    }];
    
}

- (IBAction)clickRetrievePassword:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    _retrievePasswordViewController= [storyboard instantiateViewControllerWithIdentifier:@"RetrievePasswordViewController"];
    [_retrievePasswordViewController setTitle:@"找回密码"];
    [self.navigationController pushViewController:_retrievePasswordViewController animated:YES];
}

- (IBAction)backgroundTap:(id)sender {
    [_userNameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}
- (IBAction) textFieldDoneEditing:(id)sender
{
    [_userNameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
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
