//
//  LoginViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/3/17.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"用户登录";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.nameTextField becomeFirstResponder];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bg"]]];
    [self configureLoginButton];
}

- (void)configureLoginButton{
    self.loginButton.backgroundColor = [UIColor clearColor];
    self.loginButton.layer.cornerRadius = 8;
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.borderWidth = 2;
    self.loginButton.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (IBAction)loginButtonClicked {
    NSLog(@"login");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
