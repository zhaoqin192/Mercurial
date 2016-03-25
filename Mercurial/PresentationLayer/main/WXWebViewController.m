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
    self.navigationItem.title = @"公司简介";
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
}

@end
