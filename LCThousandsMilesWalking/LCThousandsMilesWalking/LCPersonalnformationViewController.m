//
//  LCPersonalnformationViewController.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCPersonalnformationViewController.h"
#import "LCEditDataViewController.h"
#import "LCPersonaDataViewController.h"

@interface LCPersonalnformationViewController ()

@end

@implementation LCPersonalnformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=NO;
    self.title=@"个人信息";
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTableBbarViewController" object:nil
                                                      userInfo:@{@"hidden":@"0"}];

    
    // Do any additional setup after loading the view from its nib.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)clickEditData:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LCEditDataViewController * editDataViewController = [storyboard instantiateViewControllerWithIdentifier:@"EditDataViewController"];
    [self.navigationController pushViewController:editDataViewController animated:YES];
   
   
}

- (IBAction)clickSkip:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LCPersonaDataViewController * personaDataViewController = [storyboard instantiateViewControllerWithIdentifier:@"PersonaDataViewController"];
    [self.navigationController pushViewController:personaDataViewController animated:YES];
}
@end
