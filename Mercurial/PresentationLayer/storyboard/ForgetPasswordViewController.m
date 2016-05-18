//
//  ForgetPasswordViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/5/18.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "NetworkRequest+User.h"
#import "AccountDao.h"
#import "DatabaseManager.h"
#import "Account.h"
#import "AppDelegate.h"

@interface ForgetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *kCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTF;
@property (weak, nonatomic) IBOutlet UIButton *kCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) NSString *sid;
@end

static NSInteger count = 30;
@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bg"]]];
    [self configureButton];
}

- (void)viewDidAppear:(BOOL)animated {
    count = 30;
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)configureButton{
    self.kCodeButton.backgroundColor = [UIColor clearColor];
    self.kCodeButton.layer.cornerRadius = 8;
    self.kCodeButton.layer.masksToBounds = YES;
    self.kCodeButton.layer.borderWidth = 2;
    self.kCodeButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.commitButton.backgroundColor = [UIColor clearColor];
    self.commitButton.layer.cornerRadius = 8;
    self.commitButton.layer.masksToBounds = YES;
    self.commitButton.layer.borderWidth = 2;
    self.commitButton.layer.borderColor = [UIColor whiteColor].CGColor;
}
- (IBAction)kcodeButtonClicked {
    if (self.phoneTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    [NetworkRequest fetchSmsCode:self.phoneTF.text success:^(NSString *sid){
        self.sid = sid;
        self.kCodeButton.enabled = NO;
        [self.kCodeTF becomeFirstResponder];
        self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(startTimer) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    } failure:^(NSString *error) {
        [SVProgressHUD showErrorWithStatus:error];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
    }];
}

- (void)startTimer {
    if (count == 0) {
        count = 30;
        [self.timer invalidate];
        self.kCodeButton.enabled = YES;
        [self.kCodeButton setTitle:@"再次发送" forState:UIControlStateNormal];
        [self.kCodeButton setTitle:@"再次发送" forState:UIControlStateDisabled];
    } else {
        [self.kCodeButton setTitle:[NSString stringWithFormat:@"%ld秒",(long)count] forState:UIControlStateDisabled];
        count--;
    }
}

- (IBAction)buttonClicked {
    if (self.phoneTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    if (self.kCodeTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    if (self.passwordTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    if(![self.confirmPasswordTF.text isEqualToString:self.passwordTF.text]){
        [SVProgressHUD showErrorWithStatus:@"两次密码不一致，请重新输入"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    NSLog(@"%@ %@ %@",self.sid,self.passwordTF.text,self.kCodeTF.text);
    [NetworkRequest forgetPasswordWithSid:self.sid password:self.passwordTF.text code:self.kCodeTF.text success:^{
        [SVProgressHUD showSuccessWithStatus:@"修改密码成功"];
        account.password = self.passwordTF.text;
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate saveContext];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *error) {
        [SVProgressHUD showErrorWithStatus:error];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)dismiss {
    [SVProgressHUD dismiss];
}

@end
