//
//  LCEditDataViewController.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCEditDataViewController.h"
#import "LCHeadPortraitTableViewCell.h"
#import "LCBasicTableViewCell.h"
#import "LCUserManager.h"
#import "MBProgressHUD.h"

@interface LCEditDataViewController ()

@end

@implementation LCEditDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isSave=NO;
    
    self.navigationController.navigationBar.hidden=NO;
    self.title=@"个人资料";
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTableBbarViewController" object:nil
                                                      userInfo:@{@"hidden":@"0"}];
    
    UIBarButtonItem* baritem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"编辑",@"编辑") style:UIBarButtonItemStylePlain target:self action:@selector(saveData:)];
    self.navigationItem.rightBarButtonItem = baritem;
	[self selectUserInfo];
	
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if(section == 1) {
        return 3;
    }else if(section == 2){
        return 4;
    }else if(section == 3){
        return 3;
    }else if(section == 4){
        return 1;
    }else if(section == 5){
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        static NSString *cellIdentifier = @"Cell_Head";
        LCHeadPortraitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
        if(cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LCHeadPortraitTableViewCell" owner:self options:nil];
                        cell = [nib objectAtIndex:0];
            if (_isSave) {
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.headIconImageView.layer.cornerRadius=30;
            cell.headIconImageView.layer.masksToBounds = YES;
            if ([[LCUserManager shareManager] userInfo].headIcon!=nil) {
                cell.headIconImageView.image=[UIImage imageWithData:[[LCUserManager shareManager] userInfo].headIcon];
            }
            
        }
        return cell;
    }else if(indexPath.section == 1) {
        static NSString *cellIdentifier =@"Cell_Basic";
        LCBasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
        if(cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LCBasicTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
            
        }
        if (indexPath.row==0) {
            
            cell.titleLable.text=@"账      号";
            if ([[LCUserManager shareManager]userInfo].phone.length==0) {
                cell.contentLabel.text=@"+18581876868";
                cell.contentLabel.alpha=0.5;
            }else{
                cell.contentLabel.text=[[LCUserManager shareManager]userInfo].phone;
                cell.contentLabel.alpha=1;
            }
           
        }else if (indexPath.row==1){
            if (_isSave) {
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.titleLable.text=@"昵      称";
            if ([[LCUserManager shareManager]userInfo].nickName.length==0) {
                cell.contentLabel.text=@"张女士";
                cell.contentLabel.alpha=0.5;
            }else{
                cell.contentLabel.text=[[LCUserManager shareManager]userInfo].nickName;
                cell.contentLabel.alpha=1;

            }
            
        }else if (indexPath.row==2){
            if (_isSave) {
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.titleLable.text=@"婚姻状况";
            if ([NSString stringWithFormat:@"%ld",[[LCUserManager shareManager]userInfo].maritalstatus].length==3) {
                cell.contentLabel.text=@"请选择你的婚姻状况";
                cell.contentLabel.alpha=0.5;
            }else{
                cell.contentLabel.text=[NSString stringWithFormat:@"%ld",[[LCUserManager shareManager]userInfo].maritalstatus];
                if ([[LCUserManager shareManager]userInfo].maritalstatus==0) {
                    cell.contentLabel.text=@"未婚";
                    cell.contentLabel.alpha=1;

                }else if ([[LCUserManager shareManager]userInfo].maritalstatus==1){
                    cell.contentLabel.text=@"已婚";
                    cell.contentLabel.alpha=1;

                }
                cell.contentLabel.alpha=1;
            }
            
        }
        return cell;
    }else if(indexPath.section == 2){
        static NSString *cellIdentifier =@"Cell_Basic";
        LCBasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
        if(cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LCBasicTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            if (_isSave) {
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
            
        }
        if (indexPath.row==0) {
            cell.titleLable.text=@"真实姓名";
            if ([[LCUserManager shareManager]userInfo].userName.length==0) {
                cell.contentLabel.text=@"请填写你的姓名";
                cell.contentLabel.alpha=0.5;
            }else{
                cell.contentLabel.text=[[LCUserManager shareManager]userInfo].userName;
                cell.contentLabel.alpha=1;
            }
            

        }else if (indexPath.row==1){
            cell.titleLable.text=@"性      别";
            if ([NSString stringWithFormat:@"%ld",[[LCUserManager shareManager]userInfo].sex].length==0) {
                cell.contentLabel.text=@"请选择你的性别";
                cell.contentLabel.alpha=0.5;
            }else{
                if ([[LCUserManager shareManager]userInfo].sex==1) {
                    cell.contentLabel.text=[NSString stringWithFormat:@"女"];
                    cell.contentLabel.alpha=1;
                }else if ([[LCUserManager shareManager]userInfo].sex==0){
                    cell.contentLabel.text=[NSString stringWithFormat:@"男"];
                    cell.contentLabel.alpha=1;

                }
            }
            
        }else if (indexPath.row==2){
            cell.titleLable.text=@"生      日";
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *strDate = [dateFormatter stringFromDate:[[LCUserManager shareManager]userInfo].birthday];
            
            if (strDate.length==0) {
                cell.contentLabel.text=@"请选择你的生日";
                cell.contentLabel.alpha=0.5;
            }else{
                cell.contentLabel.text=strDate;
                cell.contentLabel.alpha=1;
            }
            
        }else if (indexPath.row==3){
            cell.titleLable.text=@"星      座";
            if ([[LCUserManager shareManager]userInfo]==0) {
                cell.contentLabel.text=@"请选择你的星座";
                cell.contentLabel.alpha=0.5;
            }else{
                cell.contentLabel.text=[[LCUserManager shareManager]userInfo].constellation;
                cell.contentLabel.alpha=1;
            }
            
        }

        return cell;
    }else if(indexPath.section == 3){
        static NSString *cellIdentifier =@"Cell_Basic";
        LCBasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
        if(cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LCBasicTableViewCell" owner:self options:nil];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell = [nib objectAtIndex:0];
            if (_isSave) {
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
            
        }
        if (indexPath.row==0) {
            cell.titleLable.text=@"教育程度";
            if ([[LCUserManager shareManager]userInfo].educationlevel.length==0) {
                cell.contentLabel.text=@"请选择你的教育程度";
                cell.contentLabel.alpha=0.5;
            }else{
                cell.contentLabel.text=[[LCUserManager shareManager]userInfo].educationlevel;
                cell.contentLabel.alpha=1;
            }
            
        }else if (indexPath.row==1){
            cell.titleLable.text=@"所在行业";
            if ([[LCUserManager shareManager]userInfo].vocation.length==0) {
                cell.contentLabel.text=@"请选择你所在行业";
                cell.contentLabel.alpha=0.5;
            }else{
                cell.contentLabel.text=[[LCUserManager shareManager]userInfo].vocation;
                cell.contentLabel.alpha=1;
            }
            
        }else if (indexPath.row==2){
            cell.titleLable.text=@"家庭住址";
            if ([[LCUserManager shareManager]userInfo].homeadd.length==0) {
                cell.contentLabel.text=@"请选择你的家庭住址";
                cell.contentLabel.alpha=0.6;
            }else{
                cell.contentLabel.text=[[LCUserManager shareManager]userInfo].homeadd;
                cell.contentLabel.alpha=1;

            }
            
        }

        return cell;

    }else if(indexPath.section == 4){
        static NSString *cellIdentifier =@"Cell_Basic";
        LCBasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
        if(cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LCBasicTableViewCell" owner:self options:nil];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell = [nib objectAtIndex:0];
            if (_isSave) {
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
            
        }
        if (indexPath.row==0) {
            cell.titleLable.text=@"兴趣爱好";
            if ([[LCUserManager shareManager]userInfo].hobbies.length==0) {
                cell.contentLabel.text=@"请填写你的兴趣爱好";
                cell.contentLabel.alpha=0.6;
            }else{
                cell.contentLabel.text=[[LCUserManager shareManager]userInfo].hobbies;
                cell.contentLabel.alpha=1;
            }
        }
        return cell;
    }else if(indexPath.section == 5){
        static NSString *cellIdentifier =@"Cell_Basic";
        LCBasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
        if(cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LCBasicTableViewCell" owner:self options:nil];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell = [nib objectAtIndex:0];
            if (_isSave) {
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
            
        }
        if (indexPath.row==0) {
            cell.titleLable.text=@"是否是服务提供者";
            if ([NSString stringWithFormat:@"%ld",[[LCUserManager shareManager]userInfo].serviceflag].length==0) {
                cell.contentLabel.text=@"是";
                cell.contentLabel.alpha=0.5;
            }else{
                if ([[LCUserManager shareManager]userInfo].serviceflag==0) {
                    cell.contentLabel.text=@"非服务提供者";
                    cell.contentLabel.alpha=1;
                }else if ([[LCUserManager shareManager]userInfo].serviceflag==1){
                    cell.contentLabel.text=@"服务提供者";
                    cell.contentLabel.alpha=1;
                }
            }
            cell.contentLabel.textAlignment=UITextAlignmentRight;
        }
        return cell;

    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!_isSave) {
        return;
    }
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:@"请选择文件来源"
                                          delegate:self
                                          cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:nil
                                          otherButtonTitles:@"照相机",@"相册",nil];
            actionSheet.tag = 112;
            [actionSheet showInView:self.view];
        }
    }else if(indexPath.section==1){
        if (indexPath.row==0) {
            
        }else if (indexPath.row==1){
            LCAlertView*alertView=[[LCAlertView alloc]initForLCAlertViewType:LC_ALERTVIEW_NICKNAME];
            __weak LCEditDataViewController *temp=self;
            alertView.clickOkBlock=^(NSString* textValue,LC_ALERTVIEW_TYPE type){
                [[LCUserManager shareManager]userInfo].nickName=textValue;
                [temp.tableView reloadData];
            };
            [alertView show];
        }else if (indexPath.row==2){
            UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:@"请选择婚姻状况"
                                          delegate:self
                                          cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:nil
                                          otherButtonTitles:@"未婚",@"已婚",nil];
            actionSheet.tag = 113;
            [actionSheet showInView:self.view];
        }

    }else if(indexPath.section==2){
        if (indexPath.row==0) {
            LCAlertView*alertView=[[LCAlertView alloc]initForLCAlertViewType:LC_ALERTVIEW_NAME];
            __weak LCEditDataViewController *temp=self;
            alertView.clickOkBlock=^(NSString* textValue,LC_ALERTVIEW_TYPE type){
                [[LCUserManager shareManager]userInfo].userName=textValue;
                [temp.tableView reloadData];
            };
            [alertView show];
            
        }else if (indexPath.row==1){
            UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:@"请选性别"
                                          delegate:self
                                          cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:nil
                                          otherButtonTitles:@"男",@"女",nil];
            actionSheet.tag = 114;
            [actionSheet showInView:self.view];
            
//            NSArray *array=@[@[@"男",@"女"]];
//            _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO addPickType:LC_PICKE_SEX];
//            _pickview.delegate=self;
//            [_pickview show];

        }else if (indexPath.row==2){
            NSDate *date=[NSDate dateWithTimeIntervalSinceNow:9000000];
            _pickview=[[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO addPickType:LC_PICKE_BIRTHDAY];
            _pickview.delegate=self;
            [_pickview show];
        }else if (indexPath.row==3){
            _constellationArray=[[NSMutableArray alloc]initWithObjects:@"白羊座",@"金牛座",@"双子座",@"巨蟹座",@"狮子座",@"处女座",@"天枰座",@"天蝎座",@"射手座",@"摩羯座",@"水瓶座",@" 双鱼座", nil];

            UIActionSheet* sheet = [[UIActionSheet alloc]
                                          initWithTitle:@"请选性别"
                                          delegate:self
                                          cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:nil
                                          otherButtonTitles:nil,nil];
            sheet.tag=115;
            for (int i=0; i<[_constellationArray count]; i++) {
                NSString*title=[_constellationArray objectAtIndex:i];
                [sheet addButtonWithTitle:title];
            }
            [sheet showFromRect:self.view.bounds inView:self.view animated:YES];

            
            
//            NSArray *array=@[@[@"白羊座",@"金牛座",@"双子座",@"巨蟹座",@"狮子座",@"处女座",@"天枰座",@"天蝎座",@"射手座",@"摩羯座",@"水瓶座",@" 双鱼座"]];
//            _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO addPickType:LC_PICKE_CONSTELLATION];
//            _pickview.delegate=self;
//            [_pickview show];
        }
        
    }else if(indexPath.section==3){
        if (indexPath.row==0) {
            _educationlevelArray=[[NSMutableArray alloc] initWithObjects:@"小学",@"初中",@"中专/高中",@"专科",@"本科",@"硕士研究生",@"博士研究生",@"博士后", nil];
            UIActionSheet* sheet = [[UIActionSheet alloc]
                                    initWithTitle:@"请选性别"
                                    delegate:self
                                    cancelButtonTitle:@"取消"
                                    destructiveButtonTitle:nil
                                    otherButtonTitles:nil,nil];
            sheet.tag=116;
            for (int i=0; i<[_educationlevelArray count]; i++) {
                NSString*title=[_educationlevelArray objectAtIndex:i];
                [sheet addButtonWithTitle:title];
            }
            [sheet showFromRect:self.view.bounds inView:self.view animated:YES];

            
//            NSArray *array=@[@[@"小学",@"初中",@"中专/高中",@"专科",@"本科",@"硕士研究生",@"博士研究生",@"博士后"]];
//            _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO addPickType:LC_PICKE_EDUCATIONLEVEL];
//            _pickview.delegate=self;
//            [_pickview show];
            
        }else if (indexPath.row==1){
			NSArray *array=@[@[@"机构组织",@"农林牧渔",@"医药卫生",@"建筑建材",@"冶金矿产",@"石油化工",@"水利水电",@"交通运输",@"信息产业",@"机械机电",@"轻工食品",@"服装纺织",@"专业服务",@"安全防护",@"环保绿化",@"旅游休闲",@"办公文教",@"电子电工",@"玩具礼品",@"家居用品",@"物资",@"包装",@"体育",@"办公"]];
            _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO addPickType:LC_PICKE_VOCATION];
            _pickview.delegate=self;
            [_pickview show];
            
        }else if (indexPath.row==2){
           _pickview=[[ZHPickView alloc] initPickviewWithPlistName:@"city" isHaveNavControler:NO addPickType:LC_PICKE_HOMEADD];
            _pickview.delegate=self;
            [_pickview show];
        }
        
    }else if(indexPath.section==4){
        LCAlertView*alertView=[[LCAlertView alloc]initForLCAlertViewType:LC_ALERTVIEW_HOBBIES];
        __weak LCEditDataViewController *temp=self;
        alertView.clickOkBlock=^(NSString* textValue,LC_ALERTVIEW_TYPE type){
            [[LCUserManager shareManager]userInfo].hobbies=textValue;
            [temp.tableView reloadData];
        };
        [alertView show];

        
    }else if (indexPath.section==5){
        NSArray *array=@[@[@"非服务提供者",@"服务提供者"]];
        _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO addPickType:LC_PICKE_SERVICEFLAG];
        _pickview.delegate=self;
        [_pickview show];
    }
   
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    }else if(indexPath.section == 1) {
        return 44;
    }else if(indexPath.section == 2){
        return 44;
    }else if(indexPath.section == 3){
        return 44;
    }else if(indexPath.section == 4){
        return 44;
    }else if(indexPath.section == 5){
        return 44;
    }

    
    return 44;//这里取字典里面的值时是0,请问我要怎么改
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==112) {
        switch (buttonIndex) {
            case 0://照相机
            {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.allowsEditing = YES;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                //            [self presentModalViewController:imagePicker animated:YES];
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
                break;
                
            case 1://本地相簿
            {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.allowsEditing = YES;
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                //            [self presentModalViewController:imagePicker animated:YES];
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
                
                
            default:
                break;
        }
    }else if (actionSheet.tag==113){
        switch (buttonIndex) {
            case 0://照相机
            {
                [[LCUserManager shareManager]userInfo].maritalstatus=0;
                [_tableView reloadData];
            }
                break;
                
            case 1://本地相簿
            {
                
                [[LCUserManager shareManager]userInfo].maritalstatus=1;
                [_tableView reloadData];
            }
            default:
                break;
        }
    }else if (actionSheet.tag==114){
        switch (buttonIndex) {
            case 0://照相机
            {
                [[LCUserManager shareManager]userInfo].sex=0;
                [_tableView reloadData];
            }
                break;
                
            case 1://本地相簿
            {
                
                [[LCUserManager shareManager]userInfo].sex=1;
                [_tableView reloadData];
            }
            default:
                break;
        }
    }else if (actionSheet.tag == 115){
        if (buttonIndex <= [_constellationArray count]) {
            [[LCUserManager shareManager]userInfo].constellation=[_constellationArray objectAtIndex:buttonIndex-1];
            [_tableView reloadData];

        }
    }else if(actionSheet.tag==116){
        if (buttonIndex <= [_educationlevelArray count]) {
            [[LCUserManager shareManager]userInfo].educationlevel=[_educationlevelArray objectAtIndex:buttonIndex-1];
            [_tableView reloadData];
            
        }
    }
    
}


- (void)pressed
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message"
                                                    message:@"please input"
                                                   delegate:nil
                                          cancelButtonTitle:@"cancel"
                                          otherButtonTitles:@"OK", nil];
    // 基本输入框，显示实际输入的内容
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    // 用户名，密码登录框
    //    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    // 密码形式的输入框，输入字符会显示为圆点
    //    alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
    
    //设置输入框的键盘类型
    UITextField *tf = [alert textFieldAtIndex:0];
    tf.keyboardType = UIKeyboardTypeNumberPad;
    
    UITextField *tf2 = nil;
    if (alert.alertViewStyle == UIAlertViewStyleLoginAndPasswordInput) {
        // 对于用户名密码类型的弹出框，还可以取另一个输入框
        tf2 = [alert textFieldAtIndex:1];
        tf2.keyboardType = UIKeyboardTypeASCIICapable;
    }
    
    // 取得输入的值
    NSString* text = tf.text;
    NSLog(@"INPUT:%@", text);
    if (alert.alertViewStyle == UIAlertViewStyleLoginAndPasswordInput) {
        // 对于两个输入框的
        NSString* text2 = tf2.text;
        NSLog(@"INPUT2:%@", text2);
    }
    
    [alert show];
}


#pragma mark - 图片选择器
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
    
    //    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 保存图片
- (void)saveImage:(UIImage *)image {
    
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:@"selfPhoto.jpg"];
    NSLog(@"imageFile->>%@",imageFilePath);
    success = [fileManager fileExistsAtPath:imageFilePath];
    if(success) {
        success = [fileManager removeItemAtPath:imageFilePath error:&error];
    }
    
    
    [UIImageJPEGRepresentation(image, 1.0f) writeToFile:imageFilePath atomically:YES];//写入文件
    UIImage *selfPhoto = [UIImage imageWithContentsOfFile:imageFilePath];//读取图片文件
    
    NSData *imageData = UIImagePNGRepresentation(selfPhoto);
    [[LCUserManager shareManager]userInfo].headIcon=imageData;
    [LCUserManager writeheadIconData:imageData To:[LCUserManager dataFilepath]];
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];//设置相应内容类型
    NSString *uslStr=[NSString stringWithFormat:@"%@",@"http://120.25.222.190:8081/qlxb/app/file.do?upload"];
    [self showHUDLoading:@"正在上传..."];
    [mgr POST:uslStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData* data = UIImageJPEGRepresentation(selfPhoto,0.01);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) { // 请求成功后会调用
		
		NSString*state=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"state"]];
		NSString*msg=[responseObject objectForKey:@"msg"];
		if ([state isEqualToString:@"1"]) {
			[self showResultThenHide:msg];
			[self hideHUDLoading];
			[_tableView reloadData];
		}else{
			[self showResultThenHide:msg];
			[self hideHUDLoading];
			
		}
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) { // 请求失败后会调用
        NSLog(@"%@",error);
        [self showResultThenHide:@"图片上传失败"];
        [self hideHUDLoading];
    }];
    
}

#pragma mark ZhpickVIewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString addPickType:(LC_PICKE_TYPE)pickType{
    
    if (pickType==  LC_PICKE_MARITALSTATUS) {
//        =resultString;
        if ([resultString isEqualToString:@"未婚"]) {
            [[LCUserManager shareManager]userInfo].maritalstatus=0;
            
        }else if ([resultString isEqualToString:@"已婚"]){
            [[LCUserManager shareManager]userInfo].maritalstatus=1;
        }
        [_tableView reloadData];
    }else if (pickType==  LC_PICKE_SEX){
        if ([resultString isEqualToString:@"男"]) {
            [[LCUserManager shareManager]userInfo].sex=1;
        }else{
            [[LCUserManager shareManager]userInfo].sex=0;
        }
        [_tableView reloadData];

        
    }else if (pickType==  LC_PICKE_CONSTELLATION){
        [[LCUserManager shareManager]userInfo].constellation=resultString;
        [_tableView reloadData];
        
        
    }else if (pickType==  LC_PICKE_EDUCATIONLEVEL){
        [[LCUserManager shareManager]userInfo].educationlevel=resultString;
        [_tableView reloadData];

        
    }else if (pickType==  LC_PICKE_VOCATION){
        [[LCUserManager shareManager]userInfo].vocation=resultString;
        [_tableView reloadData];

        
    }else if (pickType==  LC_PICKE_HOMEADD){
        [[LCUserManager shareManager]userInfo].homeadd=resultString;
        [_tableView reloadData];

        
    }else if (pickType==  LC_PICKE_SERVICEFLAG){
        if ([resultString isEqualToString:@"非服务提供者"]) {
            [[LCUserManager shareManager]userInfo].serviceflag=0;
        }else{
            [[LCUserManager shareManager]userInfo].serviceflag=1;
        }
        [_tableView reloadData];

        
    }else if (pickType==  LC_PICKE_BIRTHDAY){
        NSArray*timeArray=[resultString componentsSeparatedByString:@" "];
        NSString*time=[timeArray objectAtIndex:0];
        NSArray*dataArray=[time componentsSeparatedByString:@"-"];
        NSString*year=[dataArray objectAtIndex:0];
        NSString*moth=[dataArray objectAtIndex:1];
        NSString*day=[dataArray objectAtIndex:2];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@-%@-%@",year,moth,day]];
        
        [[LCUserManager shareManager]userInfo].birthday=date;
        [_tableView reloadData];

        
    }
}

-(void)selectUserInfo{
	NSLog(@"%@",[LCUserManager shareManager].userInfo.userID);
	[WTRequestCenter postWithoutCacheURL:[NSURL URLWithString:@"http://120.25.222.190:8081/qlxb/app/userinfo.do?detail"] parameters:@{@"id":[LCUserManager shareManager].userInfo.userID} completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
		
		NSDictionary *obj = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
		NSInteger state=[[obj objectForKey:@"state"] integerValue];
		NSString*msg=[obj objectForKey:@"msg"];
		NSDictionary*datailDic=[[obj objectForKey:@"data" ] objectForKey:@"detail"];
		if (state==1 ) {
			[self showResultThenHide:msg];
			[LCUserManager shareManager].userInfo.userName=[datailDic objectForKey:@"username"];
			[LCUserManager shareManager].userInfo.sex=[[datailDic objectForKey:@"sex"] intValue];
			NSDate *birthday = [NSDate dateWithTimeIntervalSinceReferenceDate:[[datailDic objectForKey:@"birthday"] doubleValue]];
//			NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//			//zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
//			[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
//			NSString *destDateString = [dateFormatter stringFromDate:birthday];
			[LCUserManager shareManager].userInfo.birthday=birthday;
			[LCUserManager shareManager].userInfo.vocation=[datailDic objectForKey:@"vocation"];
			[LCUserManager shareManager].userInfo.homeadd=[datailDic objectForKey:@"homeadd"];
			[LCUserManager shareManager].userInfo.hobbies=[datailDic objectForKey:@"hobbies"];
//			[LCUserManager shareManager].userInfo.modifytime=[datailDic objectForKey:@"vocation"];
			[LCUserManager shareManager].userInfo.maritalstatus=[[datailDic objectForKey:@"maritalstatus"] intValue];
			[LCUserManager shareManager].userInfo.constellation=[datailDic objectForKey:@"constellation"];
			[LCUserManager shareManager].userInfo.educationlevel=[datailDic objectForKey:@"educationlevel"];
			[LCUserManager shareManager].userInfo.serviceflag=[[datailDic objectForKey:@"serviceflag"] intValue];
			[_tableView reloadData];
		}else{
            [self showResultThenHide:msg];
		}
		
	}];
}



-(void)saveData:(id)sender
{
    UIBarButtonItem* baritem = (UIBarButtonItem*)sender;
    
    if (_isSave) {
        
        baritem.title=@"编辑";
        self.title=@"个人质料";
        _isSave=NO;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *strDate = [dateFormatter stringFromDate:[[LCUserManager shareManager]userInfo].birthday];
        
        [self showResultThenHide:@"正在保存"];
        
        [WTRequestCenter postWithoutCacheURL:[NSURL URLWithString:@"http://120.25.222.190:8081/qlxb/app/userinfo.do?save"] parameters:@{@"user.id":[LCUserManager shareManager].userInfo.userID,@"username":[LCUserManager shareManager].userInfo.userName,@"birthday":strDate,@"sex":[NSNumber numberWithInt:[LCUserManager shareManager].userInfo.sex],@"Maritalstatus":[NSNumber numberWithInt:[LCUserManager shareManager].userInfo.maritalstatus],@"constellation":[LCUserManager shareManager].userInfo.constellation,@"Educationlevel":[LCUserManager shareManager].userInfo.educationlevel,@"vocation":[LCUserManager shareManager].userInfo.vocation,@"homeadd":[LCUserManager shareManager].userInfo.homeadd,@"hobbies":[LCUserManager shareManager].userInfo.hobbies,@"serviceflag":[NSNumber numberWithInt:[LCUserManager shareManager].userInfo.serviceflag]} completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            
            NSDictionary *obj = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSInteger state=[[obj objectForKey:@"state"]integerValue];
            NSString*msg=[obj objectForKey:@"msg"];
            if (state==1 ) {
                [self showResultThenHide:msg];
            }else{
                [self showResultThenHide:msg];
            }
            [_tableView reloadData];
        }];
    }else{
        self.title=@"编辑质料";
        baritem.title=@"保存";
        _isSave=YES;
        [_tableView reloadData];
    }
//    LCDataInteraction * dataInteraction=[[LCDataInteraction alloc] init];
//    [dataInteraction adddUserInfoForUserData:[LCUserManager shareManager]];
    
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

- (void)hideHUDLoading{
    [self hideHUDOnView:self.view];
}
- (void)hideHUDOnView:(UIView *)view{
    MBProgressHUD *hud=[MBProgressHUD HUDForView:view];
    [hud hide:YES];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
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
