//
//  LCRegisteredViewController.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCRegisteredViewController.h"
#import "LCUserInfo.h"
#import "LCUserManager.h"
@interface LCRegisteredViewController ()

@end

@implementation LCRegisteredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)clickPhoneRegisteredButton:(id)sender {
    _phoneLabel.text=@"电话号";
}

- (IBAction)cliEmailRegisteredButton:(id)sender {
    _phoneLabel.text=@"邮箱";
}
- (IBAction)sendVerification:(id)sender {
}

- (IBAction)registered:(id)sender {
        _passWord=_passWordTextField.text;
    if ([_phoneLabel.text isEqualToString:@"邮箱"]) {
        _email=_phoneOrEmailTextField.text;
        _phone=@"";

    }else{
        _phone=_phoneOrEmailTextField.text;
        _email=@"";
        
    }

    if ((_phone.length !=0 || _email.length != 0)&& _passWord.length !=0) {
        
        [WTRequestCenter postWithoutCacheURL:[NSURL URLWithString:@"http://120.25.222.190:8081/qlxb/app/user.do?register"] parameters:@{@"loginacc":_phone,@"email":_email,@"loginpwd":_passWord,@"nickname":@"user1",@"headurl":@"1",@"openid":@"1"} completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            
            NSDictionary *obj = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSString*state=[NSString stringWithFormat:@"%@",[obj objectForKey:@"state"]];
            NSString*msg=[obj objectForKey:@"msg"];
            
            
            if ([state isEqualToString:@"1"]) {
                [self showResultThenHide:msg];
                
            }else{
                [self showResultThenHide:msg];
            }
            
        }];
    }else{
        if ([_phoneLabel.text isEqualToString:@"邮箱"]) {
            [self showResultThenHide:@"邮箱、密码、都不能为空"];
        }else{
            [self showResultThenHide:@"电话号码、新密、都不能为空"];

        }
        
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

@end
