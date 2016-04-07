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
#import "Sales.h"
#import "ProductViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "AccountDao.h"

@interface HomePageViewController () <SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet SDCycleScrollView *scrollAdView;
@property (strong, nonatomic) NSMutableArray *salesArray;
@property (strong, nonatomic) NSMutableArray *imageUrlArray;

@end

@implementation HomePageViewController
- (IBAction)viewTapped:(UITapGestureRecognizer *)sender {
    UIView *view = sender.view;
    [self buttonClicked:view];
}

- (void)configureNotifacation{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginButtonClicked) name:@"loginButtonClicked" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerButtonClicked) name:@"registerButtonClicked" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOutButtonClicked) name:@"loginOutButtonClicked" object:nil];
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
        case 102:{
            ProductViewController *vc = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"ProductViewController"];
            vc.mytitle = @"产品品牌";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 103:{
            ProductViewController *vc = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"ProductViewController"];
            vc.mytitle = @"产品品牌";
            vc.isNews = YES;
            [self.navigationController pushViewController:vc animated:YES];
            NSLog(@"产品推荐");
            break;
        }
        case 104:{
            NewsViewController *vc = [[NewsViewController alloc] initWithStyle:UITableViewStylePlain];
            vc.isNews = NO;
            vc.mytitle = @"促销信息";
            [self.navigationController pushViewController:vc animated:YES];
            NSLog(@"促销信息");
            break;
        }
        case 105:{
//            ShoppingViewController *vc = [[ShoppingViewController alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
            WXWebViewController *vc = [[WXWebViewController alloc] init];
            vc.mytitle = @"商城";
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
            if([[[AccountDao alloc] init] isLogin]){
                UITableViewController *vc = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateInitialViewController];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else{
                [self showLoginAlert];
            }
            break;
        }
        default:
            break;
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.salesArray = [[NSMutableArray alloc] init];
    [self configureScrollView];
    [self configureNotifacation];
}

- (void)showLoginAlert{
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"请登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self loginButtonClicked];
    }];
    [vc addAction:cancel];
    [vc addAction:sure];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)configureScrollView{
    self.scrollAdView.delegate = self;
    [NetworkRequest requestSalesType:@(0) success:^{
        self.salesArray = [[SalesManager sharedManager] fetchRoundArray];
        self.imageUrlArray = [[NSMutableArray alloc] init];
        for (Sales *sale in self.salesArray) {
            [self.imageUrlArray addObject:sale.imageURL];
        }
        self.scrollAdView.imageURLStringsGroup = self.imageUrlArray;
    } failure:^{
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
    }];
}

- (void)dismiss {
    [SVProgressHUD dismiss];
}

- (IBAction)barButtonClicked:(UIBarButtonItem *)sender {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
//    NSArray *menuItems =
//    @[
//      [KxMenuItem menuItem:@"注册"
//                     image:nil
//                    target:self
//                    action:@selector(registerButtonClicked)],
//      
//      [KxMenuItem menuItem:@"登录"
//                     image:nil
//                    target:self
//                    action:@selector(loginButtonClicked)],
//      ];
//    [KxMenu showMenuInView:self.view
//                  fromRect:CGRectMake(KScreen_width-40, 44, 20, 20)
//                 menuItems:menuItems];
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

- (void)loginOutButtonClicked{
    [NetworkRequest userLogoutWithSuccess:^{
        [SVProgressHUD showErrorWithStatus:@"退出成功"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
    } failure:^{
        [SVProgressHUD showErrorWithStatus:@"退出失败，请重新尝试"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
    }];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    Sales *sale = self.salesArray[index];
    WXWebViewController *vc = [[WXWebViewController alloc] init];
    vc.mytitle = @"促销信息";
    vc.url = sale.webURL;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
