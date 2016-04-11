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
#import "FormViewController.h"
#import "MessageViewController.h"
#import "DatabaseManager.h"

@interface HomePageViewController () <SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet SDCycleScrollView *scrollAdView;
@property (strong, nonatomic) NSMutableArray *salesArray;
@property (strong, nonatomic) NSMutableArray *imageUrlArray;
@property (weak, nonatomic) IBOutlet UIView *AlertView;
@property (copy, nonatomic) NSArray *messageList;
@property (strong, nonatomic) NSTimer *timer;
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
        case 106:{
            UIAlertController *vc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *formAction = [UIAlertAction actionWithTitle:@"进入论坛" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                FormViewController *vc = [[FormViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }];
            UIAlertAction *answerAction = [UIAlertAction actionWithTitle:@"查看回复" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self fetchMessage];
            }];
            [vc addAction:cancel];
            [vc addAction:formAction];
            [vc addAction:answerAction];
            [self presentViewController:vc animated:YES completion:nil];
            break;
        }
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
    [self configureLogin];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self configureMessage];
}

- (void)configureTimer{
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(alertMessage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)alertMessage{
    NSLog(@"timer");
    if (self.AlertView.backgroundColor == [UIColor redColor]) {
        self.AlertView.backgroundColor = [UIColor whiteColor];
    }
    else{
        self.AlertView.backgroundColor = [UIColor redColor];
    }
}

- (void)configureMessage{
    if ([[[AccountDao alloc] init] isLogin]) {
        [NetworkRequest requestMessageList:^{
            self.messageList = [[MessageManager sharedManager] fetchMessageArray];
            for (Message *msg in self.messageList) {
                if ([msg.readed  isEqual: @(0)]) {
                    [self configureTimer];
                    return;
                }
            }
        } failure:^{
            [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        }];
    }
}

- (void)configureLogin{
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    if (account) {
        [NetworkRequest userLoginWithName:account.accountName password:account.password success:^{
           // [SVProgressHUD showSuccessWithStatus:@"登录成功"];
        } failure:^(NSString *error) {
            [SVProgressHUD showErrorWithStatus:@"登录失败"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        }];
    }
    else{
        NSLog(@"no user");
    }
}

- (void)fetchMessage{
    if([[[AccountDao alloc] init] isLogin]){
        [NetworkRequest requestMessageList:^{
            self.messageList = [[MessageManager sharedManager] fetchMessageArray];
            if (self.messageList.count == 0) {
                [SVProgressHUD showWithStatus:@"没有新消息"];
                [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
            }
            else{
                MessageViewController *vc = [[MessageViewController alloc] init];
                vc.messageList = self.messageList;
                [self.timer invalidate];
                self.AlertView.backgroundColor = [UIColor whiteColor];
                [self.navigationController pushViewController:vc animated:YES];
            }
        } failure:^{
            [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        }];
    }
    else{
        [self showLoginAlert];
    }
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
    [[DatabaseManager sharedAccount] deleteAccountSuccess:^{
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
