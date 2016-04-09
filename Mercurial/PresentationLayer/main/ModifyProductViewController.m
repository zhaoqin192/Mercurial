//
//  ModifyProductViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/4/9.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "ModifyProductViewController.h"
#import "Order.h"
#import "AddProductViewController.h"

@interface ModifyProductViewController ()

@end

@implementation ModifyProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bg"]]];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.productList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    Order *order = self.productList[indexPath.row];
    cell.textLabel.text = @"产品名称";
    NSLog(@"%@",order.product_name);
    cell.detailTextLabel.text = order.product_name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Order *order = self.productList[indexPath.row];
    AddProductViewController *vc = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"AddProductViewController"];
    vc.order = order;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
