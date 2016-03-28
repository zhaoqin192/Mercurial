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
    self.navigationItem.title = self.title;
    if (self.url) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
        return;
    }
    [self loadUrl];
}

- (void)loadUrl{
    [NetworkRequest requestIntroduceWithSuccess:^(NSString *url) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    } failure:^{
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
    }];
}

- (void)dismiss {
    [SVProgressHUD dismiss];
}

@end
