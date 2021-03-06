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
#import "ProductType.h"
#import "Product.h"
#import "ProductDetailViewController.h"
#import "NetworkRequest+Product.h"


@interface ProductViewController ()
<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, copy) NSArray *logo;
@property (nonatomic, copy) NSArray *types;
@property (nonatomic, copy) NSArray *list;
@property (nonatomic, copy) NSArray *selectArray;
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
    if ([self.mytitle isEqualToString:@"产品类型"]) {
        [NetworkRequest requestProductTypeWithKind:self.identify success:^{
            self.types = [ProductManager sharedManager].productTypeArray;
            [self.myTableView reloadData];
        } failure:^{
            [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        }];
    }
    else if([self.mytitle isEqualToString:@"产品品牌"]){
        [NetworkRequest requestProductKindSuccess:self.isNews success:^{
            self.logo = [ProductManager sharedManager].productKindArray;
            [self.myTableView reloadData];
        } failure:^{
            [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        }];
    }
    else if ([self.mytitle isEqualToString:@"产品列表"]){
        [NetworkRequest requestProductListWithKind:self.identify type:self.Typeidentify
        success:^{
            self.list = [ProductManager sharedManager].productArray;
            [self.myTableView reloadData];
        }
        failure:^{
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
    if ([self.mytitle isEqualToString:@"产品品牌"]) {
        if (!self.searchBar.isFirstResponder || self.searchBar.text.length == 0) {
            return self.logo.count;
        }
        else{
            return self.selectArray.count;
        }
    }
    else if([self.mytitle isEqualToString:@"产品类型"]){
        if (!self.searchBar.isFirstResponder || self.searchBar.text.length == 0) {
            return self.types.count;
        }
        else{
            return self.selectArray.count;
        }
    }
    else if([self.mytitle isEqualToString:@"产品列表"]){
        if (!self.searchBar.isFirstResponder || self.searchBar.text.length == 0) {
            return self.list.count;
        }
        else{
            return self.selectArray.count;
        }
    }
    else{
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell"];
    if([self.mytitle isEqualToString:@"产品品牌"]){
        if (!self.searchBar.isFirstResponder || self.searchBar.text.length == 0) {
            ProductKind *productKind = self.logo[indexPath.row];
            cell.productKind = productKind;
        }
        else{
            ProductKind *productKind = self.selectArray[indexPath.row];
            cell.productKind = productKind;
        }
    }
    else if ([self.mytitle isEqualToString:@"产品类型"]){
        if (!self.searchBar.isFirstResponder || self.searchBar.text.length == 0) {
            ProductType *type = self.types[indexPath.row];
            cell.productType = type;
        }
        else{
            ProductType *type = self.selectArray[indexPath.row];
            cell.productType = type;
        }
    }
    else if ([self.mytitle isEqualToString:@"产品列表"]){
        if (!self.searchBar.isFirstResponder || self.searchBar.text.length == 0) {
            Product *product = self.list[indexPath.row];
            cell.product = product;
        }
        else{
            Product *product = self.selectArray[indexPath.row];
            cell.product = product;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.mytitle isEqualToString:@"产品品牌"]) {
        ProductViewController *vc = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"ProductViewController"];
        ProductKind *product = self.logo[indexPath.row];
        vc.identify = product.identifier;
        vc.mytitle = @"产品类型";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if([self.mytitle isEqualToString:@"产品类型"]){
        ProductViewController *vc = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"ProductViewController"];
        ProductType *productType = self.types[indexPath.row];
        vc.identify = self.identify;
        vc.Typeidentify = productType.identifier;
        vc.mytitle = @"产品列表";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if([self.mytitle isEqualToString:@"产品列表"]){
        ProductDetailViewController *vc = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"ProductDetailViewController"];
        Product *product = self.list[indexPath.row];
        vc.identify = product.identifier;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark <UISearchBarDelegate>

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS %@",searchBar.text];
    if([self.mytitle isEqualToString:@"产品品牌"]){
        self.selectArray = [self.logo filteredArrayUsingPredicate:predicate];
        [self.myTableView reloadData];
    }
    else if ([self.mytitle isEqualToString:@"产品类型"]){
        self.selectArray = [self.types filteredArrayUsingPredicate:predicate];
        [self.myTableView reloadData];
    }
    else if ([self.mytitle isEqualToString:@"产品列表"]){
        self.selectArray = [self.list filteredArrayUsingPredicate:predicate];
        [self.myTableView reloadData];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];
    [self.myTableView reloadData];
}

@end
