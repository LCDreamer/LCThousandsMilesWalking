//
//  LCAboutViewController.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCAboutViewController.h"
#import "LCBasicTableViewCell.h"

@interface LCAboutViewController ()

@end

@implementation LCAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"关于版本";
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTableBbarViewController" object:nil
                                                      userInfo:@{@"hidden":@"0"}];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
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
            cell.titleLable.text=@"服务条款";
            cell.contentLabel.hidden=YES;
            
        }else if (indexPath.row==1){
            cell.titleLable.text=@"功能说明";
            cell.contentLabel.hidden=YES;

        }
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;//这里取字典里面的值时是0,请问我要怎么改
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
