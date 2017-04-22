//
//  LCEventListViewController.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/9/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCEventListViewController.h"

@interface LCEventListViewController ()

@end

@implementation LCEventListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _warnInfoArray=[[NSMutableArray alloc] init];
    [self selectEventListInfo];
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
    return [_warnInfoArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    声明静态字符串型对象，用来标记重用单元格
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    //    用TableSampleIdentifier表示需要重用的单元
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    //    如果如果没有多余单元，则需要创建新的单元
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TableSampleIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        LCWarnInfo*warnInfo=[_warnInfoArray objectAtIndex:indexPath.row];
        cell.textLabel.text=warnInfo.warnTitle;
        if (warnInfo.warnflag==0) {
            [cell.imageView setImage:[UIImage imageNamed:@"warnflag0.png"]];
        }else if(warnInfo.warnflag==1){
            [cell.imageView setImage:[UIImage imageNamed:@"warnflag1.png"]];
        }

    }

    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LCEventDetailsViewController*eventDetailsViewController= [storyboard instantiateViewControllerWithIdentifier:@"EventDetailsViewController"];
    eventDetailsViewController.hidesBottomBarWhenPushed=YES;
    LCWarnInfo*warnInfo=[_warnInfoArray objectAtIndex:indexPath.row];
    eventDetailsViewController.warnInfo=warnInfo;
    [self.navigationController pushViewController:eventDetailsViewController animated:YES];
}


-(void)selectEventListInfo{
    [self showHUDLoading:@"获取数据中"];
    NSLog(@"%@",[[LCUserManager shareManager] userInfo].userID);
    [WTRequestCenter postWithoutCacheURL:[NSURL URLWithString:@"http://120.25.222.190:8081/qlxb/app/warn.do?page"] parameters:@{@"userId":[[LCUserManager shareManager] userInfo].userID,@"pageNo":[NSNumber numberWithInteger:1],@"PageSize":[NSNumber numberWithInteger:1000],@"warnType":[NSNumber numberWithInteger:_warnType]} completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSDictionary *obj = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSString*state=[NSString stringWithFormat:@"%@",[obj objectForKey:@"state"]];
        NSString*msg=[obj objectForKey:@"msg"];
        if ([state isEqualToString:@"1"]) {
            NSDictionary*warnDataDic=[obj objectForKey:@"data"];
            NSArray*warnList=[warnDataDic objectForKey:@"list"];
            _warnInfoArray=[[NSMutableArray alloc] init];
            for (int i=0; i<[warnList count]; i++) {
                NSDictionary*warnDic=[warnList objectAtIndex:i];
                LCWarnInfo*warnInfo=[[LCWarnInfo alloc] init];
                warnInfo.warncontent=[warnDic objectForKey:@"warnContent"];
                warnInfo.warnID=[warnDic objectForKey:@"id"];
                warnInfo.warnTitle=[warnDic objectForKey:@"warnTitle"];
                warnInfo.warnflag=[[warnDic objectForKey:@"warnFlag"] integerValue];
                warnInfo.warnType=[[warnDic objectForKey:@"warnType"] integerValue];
                warnInfo.warnremark=[warnDic objectForKey:@"warnRemark"];
                warnInfo.warnTitle=[warnDic objectForKey:@"warnTitle"];
                [_warnInfoArray addObject:warnInfo];
            }
            [self showResultThenHide:msg];
            [_myTableView reloadData];
            
        }else{
            [self showResultThenHide:msg];

        }
    }];
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
