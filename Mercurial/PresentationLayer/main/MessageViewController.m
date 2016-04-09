//
//  MessageViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/4/9.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "MessageViewController.h"
#import "Message.h"
#import "FormDetailViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息提醒";
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    Message *msg = self.messageList[indexPath.row];
    if (msg.readed) {
        cell.textLabel.text = [NSString stringWithFormat:@"已读 %@",msg.main_title];
    }
    else{
        cell.textLabel.text = [NSString stringWithFormat:@"未读 %@",msg.main_title];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Message *msg = self.messageList[indexPath.row];
    FormDetailViewController *vc = [[FormDetailViewController alloc] init];
    vc.topic_id = msg.topic_id;
    [self.navigationController pushViewController:vc animated:YES];
    
//    [NetworkRequest requestReadMessage:msg.topic_id success:^{
//    } failure:^{
//        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
//        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
//    }];
}

- (void)dismiss {
    [SVProgressHUD dismiss];
}


@end
