//
//  UserInformationViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/3/14.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "UserInformationViewController.h"
#import "ActionSheetStringPicker.h"
#import "ActionSheetDatePicker.h"
#import "Account.h"
#import "AccountDao.h"
#import "UserDetailViewController.h"
#import "userIconCell.h"
#import "OldFriendIntroduceViewController.h"
#import "DatabaseManager.h"
#import "NetworkRequest.h"
#import "NetworkRequest+User.h"

@interface UserInformationViewController ()
<UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) Account *myAccount;
@end

@implementation UserInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"用户信息";
    [self.tableView registerNib:[UINib nibWithNibName:@"userIconCell" bundle:nil] forCellReuseIdentifier:@"userIconCell"];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData];
}

- (NSString *)notNil:(NSString *)text{
    if (text) {
        return text;
    }
    else{
        return @"";
    }
}

- (void)loadData{
    [NetworkRequest requestUserInformationWithToken:^{
        self.myAccount = [[DatabaseManager sharedAccount] getAccount];
        [self.tableView reloadData];
    } failure:^{
        [SVProgressHUD showErrorWithStatus:@"获取数据失败，请重新尝试"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
    }];
}

- (void)dismiss {
    [SVProgressHUD dismiss];
}

- (void)uploadData{
    [NetworkRequest updateUserInformationWithSex:[self notNil:self.myAccount.sex] age:[self notNil:[NSString stringWithFormat:@"%@",self.myAccount.age]] Email:[self notNil:self.myAccount.email] phone:[self notNil:self.myAccount.fixedTel] photo:@"" name:[self notNil:self.myAccount.name] birth:[self notNil:self.myAccount.birth] cardID:[self notNil:self.myAccount.cardID] degree:[self notNil:self.myAccount.degree] job:[self notNil:self.myAccount.job] province:[self notNil:self.myAccount.province] city:[self notNil:self.myAccount.city] district:[self notNil:self.myAccount.district] address:[self notNil:self.myAccount.address] isBought:self.myAccount.isBought brand:[self notNil:self.myAccount.brand] way:[self notNil:self.myAccount.way] experience:[self notNil:self.myAccount.experience] recommendName:[self notNil:self.myAccount.recommendName] recommendPhone:[self notNil:self.myAccount.recommendPhone] success:^{
    } failure:^(NSString *error){
        [SVProgressHUD showErrorWithStatus:@"更新数据失败，请重新尝试"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
    }];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = (userIconCell *)[self.tableView dequeueReusableCellWithIdentifier:@"userIconCell"];
    }
    else{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"informationCell"];
    }
    switch (indexPath.row) {
        case 0:{
            userIconCell *ucell = (userIconCell *)cell;
            ucell.iconUrl = self.myAccount.avatar;
            return ucell;
//            cell.textLabel.text = @"用户名";
//            cell.detailTextLabel.text = self.myAccount.accountName;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        }
        case 1:
            cell.textLabel.text = @"真实姓名";
            cell.detailTextLabel.text = self.myAccount.name;
            break;
        case 2:
            cell.textLabel.text = @"性别";
            cell.detailTextLabel.text = self.myAccount.sex;
            break;
        case 3:
            cell.textLabel.text = @"年龄";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.myAccount.age];
            break;
        case 4:
            cell.textLabel.text = @"出生日期";
            cell.detailTextLabel.text = self.myAccount.birth;
            break;
        case 5:
            cell.textLabel.text = @"身份证号";
            cell.detailTextLabel.text = self.myAccount.cardID;
           // NSLog(@"%@",self.myAccount.cardID);
            break;
        case 6:
            cell.textLabel.text = @"固定电话";
            cell.detailTextLabel.text = self.myAccount.fixedTel;
            break;
        case 7:
            cell.textLabel.text = @"邮箱";
            cell.detailTextLabel.text = self.myAccount.email;
            break;
        case 8:
            cell.textLabel.text = @"职业";
            cell.detailTextLabel.text = self.myAccount.job;
            break;
        case 9:
            cell.textLabel.text = @"学历";
            cell.detailTextLabel.text = self.myAccount.degree;
            break;
        case 10:
            cell.textLabel.text = @"详细地址";
            cell.detailTextLabel.text = self.myAccount.address;
            break;
        case 11:
            cell.textLabel.text = @"装修经验";
            cell.detailTextLabel.text = self.myAccount.experience;
            break;
        case 12:
            cell.textLabel.text = @"了解渠道";
            cell.detailTextLabel.text = self.myAccount.way;
            break;
        case 13:
            cell.textLabel.text = @"是否购买过本品牌";
            if ([self.myAccount.isBought  isEqual: @(1)]) {
                cell.detailTextLabel.text = @"是";
            }
            else{
                cell.detailTextLabel.text = @"否";
            }
            break;
        case 14:
            cell.textLabel.text = @"购买过的品牌";
            cell.detailTextLabel.text = self.myAccount.brand;
            break;
        default:
            break;
    }
    if(indexPath.row != 0){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    [cell layoutIfNeeded];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 100;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    __weak typeof(self) weakSelf = self;
    switch (indexPath.row) {
        case 0:{
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
            [actionSheet showInView:self.view];
            break;
        }
        case 1:{
            UserDetailViewController *vc = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"UserDetailViewController"];
            vc.myTitle = @"真实姓名";
            vc.myAccount = self.myAccount;
            vc.originContent = self.myAccount.name;
            vc.returnString = ^(NSString *text){
                if ([text isEqualToString:@""]) {
                    return;
                }
                weakSelf.myAccount.name = text;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:{
            [ActionSheetStringPicker showPickerWithTitle:@"请选择性别" rows:@[@[@"男", @"女", @"未知"]] initialSelection:@[@(0)] doneBlock:^(ActionSheetStringPicker *picker, NSArray * selectedIndex, NSArray *selectedValue) {
                weakSelf.myAccount.sex = [selectedValue firstObject];
                [weakSelf.tableView reloadData];
                [self uploadData];
            } cancelBlock:nil origin:self.view];
            break;
        }
        case 3:{
            UserDetailViewController *vc = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"UserDetailViewController"];
            vc.myTitle = @"年龄";
            vc.myAccount = self.myAccount;
            vc.originContent = [NSString stringWithFormat:@"%@",self.myAccount.age];
            vc.returnString = ^(NSString *text){
                if ([text isEqualToString:@""]) {
                    return;
                }
                weakSelf.myAccount.age = [NSNumber numberWithInteger:[text integerValue]];
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 4:{
            NSDate *curDate = [NSDate dateFromString:@"1990-01-01" withFormat:@"yyyy-MM-dd"];            ActionSheetDatePicker *picker = [[ActionSheetDatePicker alloc] initWithTitle:nil datePickerMode:UIDatePickerModeDate selectedDate:curDate doneBlock:^(ActionSheetDatePicker *picker, NSDate *selectedDate, id origin) {
                weakSelf.myAccount.birth = [selectedDate string_yyyy_MM_dd];
                [weakSelf.tableView reloadData];
                [self uploadData];
            } cancelBlock:^(ActionSheetDatePicker *picker) {

            } origin:self.view];
            picker.minimumDate = [[NSDate date] offsetYear:-120];
            picker.maximumDate = [NSDate date];
            [picker showActionSheetPicker];
            break;
        }
        case 5:{
            UserDetailViewController *vc = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"UserDetailViewController"];
            vc.myTitle = @"身份证号";
            vc.myAccount = self.myAccount;
            vc.originContent = self.myAccount.cardID;
            vc.returnString = ^(NSString *text){
                if ([text isEqualToString:@""]) {
                    return;
                }
                weakSelf.myAccount.cardID = text;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 6:{
            UserDetailViewController *vc = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"UserDetailViewController"];
            vc.myTitle = @"电话号码";
            vc.myAccount = self.myAccount;
            vc.originContent = self.myAccount.fixedTel;
            vc.returnString = ^(NSString *text){
                if ([text isEqualToString:@""]) {
                    return;
                }
                weakSelf.myAccount.fixedTel = text;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 7:{
            UserDetailViewController *vc = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"UserDetailViewController"];
            vc.myTitle = @"邮箱";
            vc.myAccount = self.myAccount;
            vc.originContent = self.myAccount.email;
            vc.returnString = ^(NSString *text){
                if ([text isEqualToString:@""]) {
                    return;
                }
                weakSelf.myAccount.email = text;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 8:{
            [ActionSheetStringPicker showPickerWithTitle:@"请选择职业" rows:@[@[@"机关事业单位从业人员", @"职业经理人", @"销售人员",@"财务工作人员",@"行政内勤人员",@"医生或教师",@"从商人员（包括个体户、私营企业主等）",@"专项领域技术人员",@"媒体工作者",@"艺术或文学工作者",@"服务型人员",@"服役军人",@"学生、退休人员",@"自由职业"]] initialSelection:@[@(0)] doneBlock:^(ActionSheetStringPicker *picker, NSArray * selectedIndex, NSArray *selectedValue) {
                weakSelf.myAccount.job = [selectedValue firstObject];
                [weakSelf.tableView reloadData];
                [self uploadData];
            } cancelBlock:nil origin:self.view];
            break;
        }
        case 9:{
            [ActionSheetStringPicker showPickerWithTitle:@"请选择学历" rows:@[@[@"小学",@"初中",@"高中",@"中专",@"大专",@"本科",@"研究生",@"博士",@"博士后"]] initialSelection:@[@(0)] doneBlock:^(ActionSheetStringPicker *picker, NSArray * selectedIndex, NSArray *selectedValue) {
                weakSelf.myAccount.degree = [selectedValue firstObject];
                [weakSelf.tableView reloadData];
                [self uploadData];
            } cancelBlock:nil origin:self.view];
            break;
        }
        case 10:{
            UserDetailViewController *vc = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"UserDetailViewController"];
            vc.myTitle = @"详细地址";
            vc.myAccount = self.myAccount;
            vc.originContent = self.myAccount.address;
            vc.returnString = ^(NSString *text){
                if ([text isEqualToString:@""]) {
                    return;
                }
                weakSelf.myAccount.address = text;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 11:{
            UserDetailViewController *vc = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"UserDetailViewController"];
            vc.myTitle = @"装修经验";
            vc.myAccount = self.myAccount;
            vc.originContent = self.myAccount.experience;
            vc.returnString = ^(NSString *text){
                if ([text isEqualToString:@""]) {
                    return;
                }
                weakSelf.myAccount.experience = text;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 12:{
            [ActionSheetStringPicker showPickerWithTitle:@"了解渠道" rows:@[@[@"海报、宣传单张",@"电视",@"广播",@"网站及网络推广",@"进店了解",@"熟人介绍",@"其他渠道"]] initialSelection:@[@(0)] doneBlock:^(ActionSheetStringPicker *picker, NSArray * selectedIndex, NSArray *selectedValue) {
                if (![[selectedValue firstObject] isEqualToString:@"熟人介绍"]) {
                    weakSelf.myAccount.way = [selectedValue firstObject];
                    [weakSelf.tableView reloadData];
                    [self uploadData];
                }
                else{
                    OldFriendIntroduceViewController *vc = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"OldFriendIntroduceViewController"];
                    vc.myAccount = self.myAccount;
                    vc.returnString = ^(NSString *name, NSString *phone){
                        self.myAccount.recommendName = name;
                        self.myAccount.recommendPhone = phone;
                        [self uploadData];
                    };
                    [self.navigationController pushViewController:vc animated:YES];
                }
            } cancelBlock:nil origin:self.view];
            break;
        }
        case 13:{
            [ActionSheetStringPicker showPickerWithTitle:@"是否购买过本品牌" rows:@[@[@"是",@"否"]] initialSelection:@[@(0)] doneBlock:^(ActionSheetStringPicker *picker, NSArray * selectedIndex, NSArray *selectedValue) {
                if ([[selectedValue firstObject] isEqualToString:@"是"]) {
                    weakSelf.myAccount.isBought = @(YES);
                }
                else{
                    weakSelf.myAccount.isBought = @(NO);
                }
                [weakSelf.tableView reloadData];
                [self uploadData];
            } cancelBlock:nil origin:self.view];
            break;
        }
        case 14:{
            [ActionSheetStringPicker showPickerWithTitle:@"请选择购买过的品牌" rows:@[@[@"马可波罗",@"唯美"]] initialSelection:@[@(0)] doneBlock:^(ActionSheetStringPicker *picker, NSArray * selectedIndex, NSArray *selectedValue) {
                weakSelf.myAccount.brand = [selectedValue firstObject];
                [weakSelf.tableView reloadData];
                [self uploadData];
            } cancelBlock:nil origin:self.view];
            break;
        }
        default:
            break;
    }
}

#pragma mark UIActionSheetDelegate M
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 2) {
        return;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    
    if (buttonIndex == 0) {
        //        拍照
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else if (buttonIndex == 1){
        //        相册
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    [self presentViewController:picker animated:YES completion:nil];//进入照相界面
    
}

#pragma mark UIImagePickerControllerDelegate
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToUse;
    // Handle a still image picked from a photo album
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
        == kCFCompareEqualTo) {
        
        editedImage = (UIImage *) [info objectForKey:
                                   UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey:
                                     UIImagePickerControllerOriginalImage];
        
        if (editedImage) {
            imageToUse = editedImage;
        } else {
            imageToUse = originalImage;
        }
        // Do something with imageToUse
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        [NetworkRequest uploadAvatar:imageToUse success:^{
            [self loadData];
        } failure:^{
            [SVProgressHUD showErrorWithStatus:@"更新头像失败，请重新尝试"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end