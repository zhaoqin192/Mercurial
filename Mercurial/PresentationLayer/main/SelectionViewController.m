//
//  SelectionViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/4/9.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "SelectionViewController.h"
#import "TypeManager.h"
#import "Type.h"

@interface SelectionViewController ()
@property (nonatomic, copy) NSArray *list;
@end

@implementation SelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

- (void)loadData{
    [NetworkRequest requestTopicCondition:self.type success:^{
        self.list = [[TypeManager sharedManager] fetchTypeArray];
        [self.tableView reloadData];
    } failure:^{
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    Type *type = self.list[indexPath.row];
    if ([self.type isEqualToString:@"product_area"]) {
        cell.textLabel.text = type.product_area_name;
    }
    else if ([self.type isEqualToString:@"product_type"]) {
        cell.textLabel.text = type.product_type_name;
    }
    else if ([self.type isEqualToString:@"product_price"]) {
        cell.textLabel.text = type.product_price_name;
    }
    else if ([self.type isEqualToString:@"product_decro_experience"]) {
        cell.textLabel.text = type.product_decro_experience_name;
    }
    else if ([self.type isEqualToString:@"product_other"]) {
        cell.textLabel.text = type.product_other_name;
    }
    return cell;
}

//筛选条件包括区域（type = product_area）、系列（type = product_type）、价位（type = product_price）、装修经验（type = product_decro_experience）、其他（type = product_other）

@end
