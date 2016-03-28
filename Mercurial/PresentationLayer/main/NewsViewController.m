//
//  NewsViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/3/14.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsManager.h"
#import "News.h"
#import "WXWebViewController.h"
#import "NewsCell.h"

@interface NewsViewController ()
@property (nonatomic, copy) NSArray *news;
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"公司新闻";
    self.tableView.rowHeight = 80;
    [self loadTableViewData];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellReuseIdentifier:@"newsCell"];
}

- (void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
}

- (void)loadTableViewData{
    [NetworkRequest requestNewsWithSuccess:^{
       self.news = [[NewsManager sharedManager] fetchArray];
        [self.tableView reloadData];
    } failure:^{
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
    }];
}

- (void)dismiss {
    [SVProgressHUD dismiss];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.news count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell"];
    News *new = self.news[indexPath.row];
    cell.mynews = new;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    News *new = self.news[indexPath.row];
    WXWebViewController *vc = [[WXWebViewController alloc] init];
    vc.url = new.webURL;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
