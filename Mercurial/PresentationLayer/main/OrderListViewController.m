//
//  OrderListViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/4/6.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderManager.h"
#import "AddOrderViewController.h"
#import "FriendsIntroduceViewController.h"
#import "NetworkRequest+Order.h"


@interface OrderListViewController ()
@property (nonatomic, strong) NSMutableArray *list;
@end

@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bg"]]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData];
}

- (void)loadData{
    [NetworkRequest requestOrderListWithSuccess:^{
        self.list = [OrderManager sharedManager].orderArray;
        [self.tableView reloadData];
    } failure:^{
        [SVProgressHUD showErrorWithStatus:@"退出失败，请重新尝试"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
    }];
}

- (void)dismiss {
    [SVProgressHUD dismiss];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    NSString *num = self.list[indexPath.row];
    cell.textLabel.text = @"订单号";
    cell.detailTextLabel.text = num;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identify = self.list[indexPath.row];
    AddOrderViewController *vc = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"AddOrderViewController"];
    vc.identify = identify;
    vc.myTitle = @"修改订单";
    [self.navigationController pushViewController:vc animated:YES];
}



@end
