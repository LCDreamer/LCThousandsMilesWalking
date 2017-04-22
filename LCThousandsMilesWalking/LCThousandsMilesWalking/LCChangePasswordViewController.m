//
//  LCChangePasswordViewController.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCChangePasswordViewController.h"
#import "MBProgressHUD.h"
#import "LCUserManager.h"

@interface LCChangePasswordViewController ()

@end

@implementation LCChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"修改密码";
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTableBbarViewController" object:nil
                                                      userInfo:@{@"hidden":@"0"}];
    [self initChangePasswordView];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=NO;
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTableBbarViewController" object:nil
//                                                      userInfo:@{@"hidden":@"0"}];
    
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

-(void)initChangePasswordView{
    self.navigationController.title=@"修改密码";
    
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

-(void)clickOkButton:(id)sender{
    _oldPassWord=_oldePassWordTextField.text;
    _newsPassWord=_newsPassWordTextField.text;
    _okPassWord=_okPassWordTextField.text;
    NSLog(@"%@",[[LCUserManager shareManager] userInfo].userID);
    if (_oldPassWord.length!=0 && _newsPassWord.length != 0 && _okPassWord.length!=0) {
        [WTRequestCenter postWithoutCacheURL:[NSURL URLWithString:@"http://120.25.222.190:8081/qlxb/app/user.do?modifyPwd"] parameters:@{@"userId":[[LCUserManager shareManager] userInfo].userID,@"oldPwd":_oldPassWord,@"newPwd":_newsPassWord} completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
