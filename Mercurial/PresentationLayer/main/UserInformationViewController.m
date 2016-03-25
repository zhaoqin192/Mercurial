//
//  UserInformationViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/3/14.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "UserInformationViewController.h"

@interface UserInformationViewController ()

@end

@implementation UserInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"用户信息";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 13;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"informationCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"informationCell"];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"登录用户";
            cell.detailTextLabel.text = @"xxxx";
            break;
        case 1:
            cell.textLabel.text = @"真实姓名";
            cell.detailTextLabel.text = @"xxxx";
            break;
        case 2:
            cell.textLabel.text = @"性别";
            cell.detailTextLabel.text = @"xxxx";
            break;
        case 3:
            cell.textLabel.text = @"出生日期";
            cell.detailTextLabel.text = @"xxxx";
            break;
        case 4:
            cell.textLabel.text = @"身份证号";
            cell.detailTextLabel.text = @"xxxx";
            break;
        case 5:
            cell.textLabel.text = @"固定电话";
            cell.detailTextLabel.text = @"xxxx";
            break;
        case 6:
            cell.textLabel.text = @"邮箱";
            cell.detailTextLabel.text = @"xxxx";
            break;
        case 7:
            cell.textLabel.text = @"职业";
            cell.detailTextLabel.text = @"xxxx";
            break;
        case 8:
            cell.textLabel.text = @"学历";
            cell.detailTextLabel.text = @"xxxx";
            break;
        case 9:
            cell.textLabel.text = @"省";
            cell.detailTextLabel.text = @"xxxx";
            break;
        case 10:
            cell.textLabel.text = @"市";
            cell.detailTextLabel.text = @"xxxx";
            break;
        case 11:
            cell.textLabel.text = @"区县";
            cell.detailTextLabel.text = @"xxxx";
            break;
        case 12:
            cell.textLabel.text = @"地址";
            cell.detailTextLabel.text = @"xxxx";
            break;
        default:
            break;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"clicked");
}

@end