//
//  LCEventRemindViewController.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCEventRemindViewController.h"
#import "LCEventTableViewCell.h"
#import "LCAddEventRemindViewController.h"

@interface LCEventRemindViewController ()

@end

@implementation LCEventRemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem* baritem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addEventRemind:)];
    
    self.navigationItem.rightBarButtonItem = baritem;

    // Do any additional setup after loading the view.
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
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell_Event";
    LCEventTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LCEventTableViewCell" owner:self options:nil];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell = [nib objectAtIndex:0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row==0) {
            [cell.imageIcon setImage:[UIImage imageNamed:@"today.png"]];
            cell.titleName.text=@"今日提醒";
        }else if (indexPath.row==1){
            [cell.imageIcon setImage:[UIImage imageNamed:@"work.png"]];
            cell.titleName.text=@"作息提醒";
            
        }else if (indexPath.row==2){
            [cell.imageIcon setImage:[UIImage imageNamed:@"event.png"]];
            cell.titleName.text=@"事件提醒";
            
        }
        
        
    }
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LCEventListViewController * eventListViewController = [storyboard instantiateViewControllerWithIdentifier:@"EventListViewController"];
                eventListViewController.hidesBottomBarWhenPushed=YES;
        eventListViewController.warnType=0;
        eventListViewController.title=@"今日提醒";
        [self.navigationController pushViewController:eventListViewController animated:YES];

        
    }else if(indexPath.row==1){
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LCEventListViewController * eventListViewController = [storyboard instantiateViewControllerWithIdentifier:@"EventListViewController"];
        eventListViewController.hidesBottomBarWhenPushed=YES;
        eventListViewController.warnType=1;
        eventListViewController.title=@"作息提醒";
        [self.navigationController pushViewController:eventListViewController animated:YES];
        
    }else if (indexPath.row==2){
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LCEventListViewController * eventListViewController = [storyboard instantiateViewControllerWithIdentifier:@"EventListViewController"];
        eventListViewController.hidesBottomBarWhenPushed=YES;
        eventListViewController.warnType=2;
        eventListViewController.title=@"事件提醒";
        [self.navigationController pushViewController:eventListViewController animated:YES];
    }
    }

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;//这里取字典里面的值时是0,请问我要怎么改
}


-(void)addEventRemind:(id)sender
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LCAddEventRemindViewController*addEventRemindViewController= [storyboard instantiateViewControllerWithIdentifier:@"AddEventRemindViewController"];
    [self.navigationController pushViewController:addEventRemindViewController animated:YES];
    
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
