//
//  FriendsListViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/4/6.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "FriendsListViewController.h"
#import "RecommendManager.h"
#import "Recommend.h"
#import "FriendsIntroduceViewController.h"

@interface FriendsListViewController ()
@property (nonatomic, copy) NSArray *list;
@end

@implementation FriendsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bg"]]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadData];
}

- (void)loadData{
    [NetworkRequest requestCommendList:^{
        self.list = [[RecommendManager sharedManager] fetchCommendArray];
        [self.tableView reloadData];
    } failure:^{
        [SVProgressHUD showErrorWithStatus:@"退出失败，请重新尝试"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
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
    Recommend *recommend = self.list[indexPath.row];
    cell.textLabel.text = @"推荐人";
    cell.detailTextLabel.text = recommend.recomm_name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Recommend *recommend = self.list[indexPath.row];
    FriendsIntroduceViewController *vc = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"FriendsIntroduceViewController"];
    vc.identify = recommend.user_recomm_id;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
