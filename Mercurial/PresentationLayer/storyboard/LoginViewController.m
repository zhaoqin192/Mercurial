//
//  LoginViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/3/17.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "LoginViewController.h"
#import "AccountDao.h"
#import "Account.h"
#import "DatabaseManager.h"
#import "NetworkRequest+User.h"


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
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bg"]]];
    [self configureLoginButton];
    [self configureTextField];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}

- (void)configureTextField{
    NSLog(@"login");
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    if (account) {
        self.nameTextField.text = account.phone;
        [self.passwordTextField becomeFirstResponder];
    }
    else{
        [self.nameTextField becomeFirstResponder];
    }
}

- (void)configureLoginButton{
    self.loginButton.backgroundColor = [UIColor clearColor];
    self.loginButton.layer.cornerRadius = 8;
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.borderWidth = 2;
    self.loginButton.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (IBAction)loginButtonClicked {
    if(![self isValidPhoneNumber:self.nameTextField.text]){
        [SVProgressHUD showErrorWithStatus:@"请输入正确的电话号码"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    if (self.passwordTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    [SVProgressHUD show];
    [NetworkRequest userLoginWithName:self.nameTextField.text password:self.passwordTextField.text success:^{
        [SVProgressHUD showSuccessWithStatus:@"登录成功!"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *error){
        [SVProgressHUD showErrorWithStatus:error];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
    }];
}

- (void)dismiss {
    [SVProgressHUD dismiss];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark -<VerficationCode>

- (BOOL)isValidPhoneNumber:(NSString *)text{
    if (text.length != 11) {
        return NO;
    }else if (![self isAllNum:text]){
        return NO;
    }else{
        return YES;
    }
}

- (BOOL)isValidAgeNumber:(NSString *)text{
    if (!(text.length == 1 || text.length == 2)) {
        return NO;
    }else if (![self isAllNum:text]){
        return NO;
    }else{
        return YES;
    }
}

- (BOOL)isAllNum:(NSString *)text{
    unichar c;
    for (int i=0; i<text.length; i++) {
        c=[text characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}


@end
