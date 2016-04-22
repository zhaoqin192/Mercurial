//
//  RevisePasswordViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/4/20.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "RevisePasswordViewController.h"
#import "NetworkRequest+User.h"
#import "AccountDao.h"
#import "DatabaseManager.h"
#import "Account.h"

@interface RevisePasswordViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UITextField *originPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *comfirmTF;

@end

@implementation RevisePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bg"]]];
    [self configureButton];
}

- (void)configureButton{
    self.button.backgroundColor = [UIColor clearColor];
    self.button.layer.cornerRadius = 8;
    self.button.layer.masksToBounds = YES;
    self.button.layer.borderWidth = 2;
    self.button.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (IBAction)buttonClicked {
    if (self.originPasswordTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入原密码"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    if (self.PasswordTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入新密码"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    if (self.comfirmTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请再次输入密码"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    if(![self.comfirmTF.text isEqualToString:self.PasswordTF.text]){
        [SVProgressHUD showErrorWithStatus:@"两次密码不一致，请重新输入"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    NSString *phone = account.accountName;
    NSLog(@"%@",phone);
    [NetworkRequest revisePasswordWithName:phone oldPassword:self.originPasswordTF.text newPassword:self.PasswordTF.text success:^{
        [SVProgressHUD showSuccessWithStatus:@"修改密码成功"];
        account.password = self.PasswordTF.text;
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *error) {
        [SVProgressHUD showErrorWithStatus:error];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
    }];
    
}

- (void)dismiss {
    [SVProgressHUD dismiss];
}

@end
