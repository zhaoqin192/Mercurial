//
//  NewsViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/3/14.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsManager.h"
#import "SalesManager.h"
#import "News.h"
#import "Sales.h"
#import "WXWebViewController.h"
#import "NewsCell.h"
#import "NetworkRequest+Others.h"


@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.mytitle;
    self.tableView.rowHeight = 80;
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellReuseIdentifier:@"newsCell"];
    [self loadTableViewData];
}

- (void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
}

- (void)loadTableViewData{
    if (self.isNews) {
        [NetworkRequest requestNewsWithSuccess:^{
            self.news = [NewsManager sharedManager].newsArray;
            [self.tableView reloadData];
        } failure:^(NSString *error){
            [SVProgressHUD showErrorWithStatus:error];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        }];
    }
    else{
        [NetworkRequest requestSalesType:@(1) success:^{
            self.news = [SalesManager sharedManager].salesArray;
            [self.tableView reloadData];
        } failure:^{
            [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        }];
    }
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
    if (self.isNews) {
        News *new = self.news[indexPath.row];
        cell.mynews = new;
    }
    else{
        Sales *sale = self.news[indexPath.row];
        cell.sale = sale;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    News *new = self.news[indexPath.row];
    WXWebViewController *vc = [[WXWebViewController alloc] init];
    vc.url = new.webURL;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
