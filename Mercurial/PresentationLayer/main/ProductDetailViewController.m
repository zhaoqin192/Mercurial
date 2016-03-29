//
//  ProductDetailViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/3/29.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ProductManager.h"
#import "Product.h"

@interface ProductDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UILabel *introductText;
@property (strong, nonatomic) Product *product;

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商品详情";
    [self loadData];
}

- (void)loadData{
    [NetworkRequest requestProductDetailWithID:self.identify success:^{
        self.product = [ProductManager sharedManager].product;
        
        self.introductText.text = self.product.productInfo;
    } failure:^{
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
    }];
}

- (void)dismiss {
    [SVProgressHUD dismiss];
}

@end
