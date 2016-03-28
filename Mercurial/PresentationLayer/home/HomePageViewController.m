//
//  HomePageViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/3/20.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "HomePageViewController.h"
#import "SDCycleScrollView.h"
#import "NewsViewController.h"
#import "ScanViewController.h"
#import "ShoppingViewController.h"
#import "KxMenu.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "WXWebViewController.h"

@interface HomePageViewController ()
@property (weak, nonatomic) IBOutlet SDCycleScrollView *scrollAdView;

@end

@implementation HomePageViewController
- (IBAction)viewTapped:(UITapGestureRecognizer *)sender {
    UIView *view = sender.view;
    [self buttonClicked:view];
}

- (void)buttonClicked:(UIView *)sender {
    switch (sender.tag) {
        case 100:{
            WXWebViewController *vc = [[WXWebViewController alloc] init];
            vc.mytitle = @"公司简介";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 101:{
            NewsViewController *vc = [[NewsViewController alloc] initWithStyle:UITableViewStylePlain];
            vc.isNews = YES;
            vc.mytitle = @"公司新闻";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 102:
            NSLog(@"产品介绍");
            break;
        case 103:
            NSLog(@"产品推荐");
            break;
        case 104:{
            NewsViewController *vc = [[NewsViewController alloc] initWithStyle:UITableViewStylePlain];
            vc.isNews = NO;
            vc.mytitle = @"促销信息";
            [self.navigationController pushViewController:vc animated:YES];
            NSLog(@"促销信息");
            break;
        }
        case 105:{
            ShoppingViewController *vc = [[ShoppingViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            NSLog(@"商城");
            break;
        }
        case 106:
            NSLog(@"互动留言");
            break;
        case 107:{
            ScanViewController * vc = [[ScanViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            NSLog(@"防伪查询");
            break;
        }
        case 108:{
            UITableViewController *vc = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateInitialViewController];
            [self.navigationController pushViewController:vc animated:YES];
            NSLog(@"用户中心");
            break;
        }
        default:
            break;
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureScrollView];
}


- (void)configureScrollView{
    NSArray *array = @[@"roundImage0", @"roundImage1", @"roundImage2"];
    self.scrollAdView.localizationImageNamesGroup = array;
}

- (IBAction)barButtonClicked:(UIBarButtonItem *)sender {
    NSArray *menuItems =
    @[
      [KxMenuItem menuItem:@"注册"
                     image:nil
                    target:self
                    action:@selector(registerButtonClicked)],
      
      [KxMenuItem menuItem:@"登录"
                     image:nil
                    target:self
                    action:@selector(loginButtonClicked)],
      ];
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(KScreen_width-40, 44, 20, 20)
                 menuItems:menuItems];
}

- (void)loginButtonClicked{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:nil];
    LoginViewController *vc = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)registerButtonClicked{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RegisterStoryBoard" bundle:nil];
    RegisterViewController *vc = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
