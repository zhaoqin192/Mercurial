//
//  HomeLeftViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/3/31.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "HomeLeftViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "AccountDao.h"
#import "Account.h"
#import "DatabaseManager.h"

@interface HomeLeftViewController ()
@property (weak, nonatomic) IBOutlet UIView *MiddleView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation HomeLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.MiddleView.backgroundColor = [UIColor clearColor];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bg"]]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self configureButton];
}

- (void)configureButton{
    if ([[DatabaseManager sharedAccount] isLogin]) {
        [self.loginButton setTitle:@"退出" forState:UIControlStateNormal];
    }
    else{
        [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    //NSLog(@"touch");
}

- (IBAction)loginButtonClicked {
    if ([self.loginButton.titleLabel.text isEqualToString:@"登录"]) {
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginButtonClicked" object:nil];
        }];
    }
    else{
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginOutButtonClicked" object:nil];
        }];
    }
}

- (IBAction)registerButtonClicked {
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"registerButtonClicked" object:nil];
    }];
}

@end
