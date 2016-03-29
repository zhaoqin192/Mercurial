//
//  ProductViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/3/29.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "ProductViewController.h"
#import "NewsCell.h"
#import "ProductManager.h"
#import "ProductKind.h"

@interface ProductViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = self.mytitle;
    self.myTableView.rowHeight = 80;
    [self.myTableView registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellReuseIdentifier:@"newsCell"];
    [self loadTableViewData];
}

- (void)viewDidAppear:(BOOL)animated{
    [self.myTableView reloadData];
}

- (void)loadTableViewData{
    if (self.isNews) {
        [NetworkRequest requestNewsWithSuccess:^{
            self.news = [[NewsManager sharedManager] fetchArray];
            [self.myTableView reloadData];
        } failure:^{
            [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        }];
    }
    else{
        [NetworkRequest requestProductKindSuccess:^{
            self.news = [[ProductManager sharedManager] fetchProductKindArray];
            [self.myTableView reloadData];
        } failure:^{
            [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
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
        ProductKind *product = self.news[indexPath.row];
        cell.product = product;
        NSLog(@"%@",product.imageURL);
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%zd",indexPath.row);
}

@end
