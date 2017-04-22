//
//  LCRetrievePasswordViewController.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCRetrievePasswordViewController.h"
#import "MBProgressHUD.h"
@interface LCRetrievePasswordViewController ()

@end

@implementation LCRetrievePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initPasswordView{
    _phoneView.hidden=YES;
    _nextButton.hidden=YES;
    _sendPhoneLabel=[[UILabel alloc] init];
    [_sendPhoneLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_sendPhoneLabel];
    _sendPhoneNumnberLabel=[[UILabel alloc]init];
    [_sendPhoneNumnberLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_sendPhoneNumnberLabel];
    
    
    [_sendPhoneLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_sendPhoneNumnberLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSMutableArray * tempConstraints = [NSMutableArray array];
    _sendPhoneLabel.text=@"发送验证码到手机:";
    [_sendPhoneNumnberLabel setText:@"+861858248684"];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_sendPhoneLabel]-[_sendPhoneNumnberLabel]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_sendPhoneLabel,_sendPhoneNumnberLabel)]];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_sendPhoneLabel(==30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_sendPhoneLabel)]];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_sendPhoneNumnberLabel(==30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_sendPhoneNumnberLabel)]];
    

    
    _verificationCodeTextField=[[UITextField alloc]init];
    [_verificationCodeTextField setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_verificationCodeTextField];
    [_verificationCodeTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    _verificationCodeButton=[[UIButton alloc]init];
    [_verificationCodeButton setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_verificationCodeButton];
    [_verificationCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_verificationCodeButton addTarget:self action:@selector(clickvalidationButton:) forControlEvents:UIControlEventTouchUpInside];
    [_verificationCodeButton.titleLabel setTextColor:[UIColor colorWithRed:225.0/255.0 green:144.0/255.0 blue:2.0/255.0 alpha:1.000]];
    [_verificationCodeButton setTranslatesAutoresizingMaskIntoConstraints:NO];

    
    
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_sendPhoneLabel]-20-[_verificationCodeTextField(==40)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_sendPhoneLabel,_verificationCodeTextField)]];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_sendPhoneLabel]-20-[_verificationCodeButton(==40)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_sendPhoneLabel,_verificationCodeButton)]];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_verificationCodeTextField]-[_verificationCodeButton(==100)]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_verificationCodeTextField,_verificationCodeButton)]];
    
    _completeButton=[[UIButton alloc] init];
    [_completeButton setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:144.0/255.0 blue:2.0/255.0 alpha:1.000]];
    [_completeButton setTitle:@"完成" forState:UIControlStateNormal];
    [_completeButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_completeButton addTarget:self action:@selector(clickCompleteButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_completeButton];
    
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_verificationCodeTextField]-30-[_completeButton(==40)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_verificationCodeTextField,_completeButton)]];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_completeButton]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_completeButton)]];
    [self.view addConstraints:tempConstraints];
    
    
    
}

-(void)initChangePasswordView{
    _phoneView.hidden=YES;
    _nextButton.hidden=YES;
    _sendPhoneNumnberLabel.hidden=YES;
    _sendPhoneLabel.hidden=YES;
    _verificationCodeButton.hidden=YES;
    _verificationCodeTextField.hidden=YES;
    _completeButton.hidden=YES;
    self.navigationController.title=@"修改密码";
//    [self.view removeConstraints:self.view.constraints];
    
    NSMutableArray * tempConstraints = [NSMutableArray array];
    UIView*oldPassWordView=[[UIView alloc] init];
    [oldPassWordView setBackgroundColor:[UIColor whiteColor]];
    [oldPassWordView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:oldPassWordView];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[oldPassWordView]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(oldPassWordView)]];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[oldPassWordView(==40)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(oldPassWordView)]];
    
    NSMutableArray * subOldTempConstraints = [NSMutableArray array];
    UILabel*oldLable=[[UILabel alloc] init];
    [oldLable setBackgroundColor:[UIColor whiteColor]];
    [oldLable setText:@"原始密码"];
    oldLable.translatesAutoresizingMaskIntoConstraints=NO;
    [oldPassWordView addSubview:oldLable];
    
    _oldePassWordTextField=[[UITextField alloc] init];
    [_oldePassWordTextField setBackgroundColor:[UIColor whiteColor]];
    [_oldePassWordTextField setPlaceholder:@"请输入"];
    _oldePassWordTextField.translatesAutoresizingMaskIntoConstraints=NO;
    [oldPassWordView addSubview:_oldePassWordTextField];
    
    [subOldTempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[oldLable(==90)]-[_oldePassWordTextField]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(oldLable,_oldePassWordTextField)]];
    [subOldTempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[oldLable]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(oldLable)]];
    [subOldTempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_oldePassWordTextField]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_oldePassWordTextField)]];
    
    [oldPassWordView addConstraints:subOldTempConstraints];
    
    
    
    
    
    UIView*newPassWordView=[[UIView alloc] init];
    [newPassWordView setBackgroundColor:[UIColor whiteColor]];
    [newPassWordView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:newPassWordView];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[newPassWordView]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(newPassWordView)]];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[oldPassWordView]-(20)-[newPassWordView(==40)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(newPassWordView,oldPassWordView)]];
    
    NSMutableArray * subNewTempConstraints = [NSMutableArray array];
    UILabel*newLable=[[UILabel alloc] init];
    [newLable setBackgroundColor:[UIColor whiteColor]];
    [newLable setText:@"新密码"];
    newLable.translatesAutoresizingMaskIntoConstraints=NO;
    [newPassWordView addSubview:newLable];
    
    _newsPassWordTextField=[[UITextField alloc] init];
    [_newsPassWordTextField setBackgroundColor:[UIColor whiteColor]];
    [_newsPassWordTextField setPlaceholder:@"6-16位数字"];
    _newsPassWordTextField.translatesAutoresizingMaskIntoConstraints=NO;
    [newPassWordView addSubview:_newsPassWordTextField];
    
    [subNewTempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[newLable(==90)]-[_newsPassWordTextField]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(newLable,_newsPassWordTextField)]];
    [subNewTempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[newLable]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(newLable)]];
    [subNewTempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_newsPassWordTextField]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_newsPassWordTextField)]];
    
    [newPassWordView addConstraints:subNewTempConstraints];
    
    
    UIView*okNewPassWordView=[[UIView alloc] init];
    [okNewPassWordView setBackgroundColor:[UIColor whiteColor]];
    [okNewPassWordView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:okNewPassWordView];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[okNewPassWordView]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(okNewPassWordView)]];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[newPassWordView]-(20)-[okNewPassWordView(==40)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(newPassWordView,okNewPassWordView)]];
    
    NSMutableArray * subOkTempConstraints = [NSMutableArray array];
    UILabel*okLable=[[UILabel alloc] init];
    [okLable setBackgroundColor:[UIColor whiteColor]];
    [okLable setText:@"确认新密码"];
    okLable.translatesAutoresizingMaskIntoConstraints=NO;
    [okNewPassWordView addSubview:okLable];
    
    _okPassWordTextField=[[UITextField alloc] init];
    [_okPassWordTextField setBackgroundColor:[UIColor whiteColor]];
    [_okPassWordTextField setPlaceholder:@"请输入"];
    _okPassWordTextField.translatesAutoresizingMaskIntoConstraints=NO;
    [okNewPassWordView addSubview:_okPassWordTextField];
    
    [subOkTempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[okLable(==90)]-[_okPassWordTextField]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(okLable,_okPassWordTextField)]];
    [subOkTempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[okLable]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(okLable)]];
    [subOkTempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_okPassWordTextField]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_okPassWordTextField)]];
    
    [okNewPassWordView addConstraints:subOkTempConstraints];

    
    
    UIButton*okButton=[[UIButton alloc] init];
    [okButton setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:144.0/255.0 blue:2.0/255.0 alpha:1.000]];
    [okButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [okButton setTitle:@"确认提交" forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(clickOkButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:okButton];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[okButton]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(okButton)]];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[okNewPassWordView]-(20)-[okButton(==40)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(okNewPassWordView,okButton)]];
    
    
    [self.view addConstraints:tempConstraints];
    
}

- (IBAction)clickNextPassword:(id)sender {
    [self initPasswordView];
    return ;
    _phoneNumnber=_phoneNumnberTextField.text;
    if (_phoneNumnber.length !=0) {
        [_sendPhoneNumnberLabel setText:_phoneNumnber];
        [self initPasswordView];
    }else{
        [self showResultThenHide:@"电话号码不能为空"];
    }
   
    
}
-(void)clickvalidationButton:(id)sender{
    if(_phoneNumnber.length !=0){
        [WTRequestCenter postWithoutCacheURL:[NSURL URLWithString:@"http://120.25.222.190:8081/qlxbapp/app/user.do?smsCode"] parameters:@{@"mobile":_phoneNumnber} completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            
            NSDictionary *obj = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            
            NSString*state=[obj objectForKey:@"state"];
            NSString*msg=[obj objectForKey:@"msg"];
            NSString*code=[obj objectForKey:@"code"];
            if ([state isEqualToString:@"1"]) {
                [self showResultThenHide:msg];
            }else{
                [self showResultThenHide:msg];
            }
        }];
    }else{
        [self showResultThenHide:@"电话号码不能为空"];
    }
    
    
}
-(void)clickCompleteButton:(id)sender{
    [self initChangePasswordView];
     return;
    _verificationCode=_verificationCodeTextField.text;
    if (_verificationCode.length!=0) {
        [self initChangePasswordView];
    }else{
        [self showResultThenHide:@"验证码不能为空"];
    }
    
}

-(void)clickOkButton:(id)sender{
    _oldPassWord=_oldePassWordTextField.text;
    _newsPassWord=_newsPassWordTextField.text;
    _okPassWord=_okPassWordTextField.text;
    
    if (_oldPassWord.length!=0 && _newsPassWord.length != 0 && _okPassWord.length!=0) {
        [WTRequestCenter postWithoutCacheURL:[NSURL URLWithString:@"http://120.25.222.190:8081/qlxbapp/user.do?modifyPwd"] parameters:@{@"userId":_oldPassWord,@"oldPwd":_newsPassWord,@"newPwd":_okPassWord} completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            
            NSDictionary *obj = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            
            
            NSString*state=[obj objectForKey:@"state"];
            NSString*msg=[obj objectForKey:@"msg"];
            if ([state isEqualToString:@"1"]) {
                [self showResultThenHide:msg];
                
            }else{
                [self showResultThenHide:msg];
            }
        }];
    }else{
        [self showResultThenHide:@"原始密码、新密码、确认新密码都不能为空"];
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
