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
#import "SDCycleScrollView.h"
#import "NetworkRequest+Product.h"


@interface ProductDetailViewController ()
@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleView;
@property (weak, nonatomic) IBOutlet UILabel *introductText;
@property (strong, nonatomic) Product *product;

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商品详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.cycleView.autoScroll = NO;
    self.cycleView.infiniteLoop = NO;
    [self loadData];
}

- (void)loadData{
    [NetworkRequest requestProductDetailWithID:self.identify success:^{
        self.product = [ProductManager sharedManager].product;
        self.introductText.text = self.product.productInfo;
        if (self.product.imageURLArray == [NSNull null]) {
            return ;
        }
        self.cycleView.imageURLStringsGroup = self.product.imageURLArray;
    } failure:^{
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
    }];
}

- (void)dismiss {
    [SVProgressHUD dismiss];
}

@end
