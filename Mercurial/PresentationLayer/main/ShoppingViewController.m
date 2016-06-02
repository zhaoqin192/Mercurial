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
}

- (void)loadData:(NSString *)platform{
    [NetworkRequest requestMallWithName:platform success:^(NSString *text) {
        NSLog(@"%@",text);
        if ([platform isEqualToString:@"ld"]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:text]];
        }
        else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:text]];
        }
    } failure:^{
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
    }];
}

- (IBAction)viewTapped:(UITapGestureRecognizer *)sender {
    if (sender.view.tag == 100) {
        [self loadData:@"ld"];
    }
    else{
        [self loadData:@"mk"];
    }
}

- (void)dismiss {
    [SVProgressHUD dismiss];
}

@end
