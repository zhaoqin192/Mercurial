//
//  WXWebViewController.m
//  TestWebView
//
//  Created by 王霄 on 16/3/25.
//  Copyright © 2016年 neotel. All rights reserved.
//

#import "WXWebViewController.h"

@interface WXWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@end

@implementation WXWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.mytitle;
    if (self.url) {
        NSLog(@"%@",self.url);
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    }
    else{
        [self loadUrl];
    }
}

- (void)loadUrl{
    if([self.mytitle isEqualToString:@"商城"]){
        [NetworkRequest requestMallWithName:@"天猫" success:^(NSString *text) {
           [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:text]]];
        } failure:^{
            [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        }];
    }
    else{
        [NetworkRequest requestIntroduceWithSuccess:^(NSString *url) {
            [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        } failure:^(NSString *error){
            [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        }];
    }
}

- (void)dismiss {
    [SVProgressHUD dismiss];
}

@end
