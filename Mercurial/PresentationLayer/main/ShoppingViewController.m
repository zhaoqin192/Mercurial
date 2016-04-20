//
//  ShoppingViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/3/15.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "ShoppingViewController.h"
#import "NetworkRequest+Others.h"

@interface ShoppingViewController ()

@end

@implementation ShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商城";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mall_bg"]];
    [self loadData];
}

- (void)loadData{
    [NetworkRequest requestMallWithName:@"天猫" success:^(NSString *text) {
        NSLog(@"%@",text);
    } failure:^{
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
    }];
}

- (IBAction)viewTapped:(UITapGestureRecognizer *)sender {
    if (sender.view.tag == 100) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://ld.tmall.com/"]];
    }
    else{
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://marcopolocz.tmall.com/"]];
    }
}

@end
