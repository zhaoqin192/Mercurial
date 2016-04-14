//
//  RegisterViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/3/17.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "RegisterViewController.h"
#import "NetworkRequest+User.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;
@property (weak, nonatomic) IBOutlet UISwitch *sexSwitch;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"用户注册";
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bg"]]];
    [self configureRegisterButton];
    [self.phoneNumTextField becomeFirstResponder];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}

- (void)configureRegisterButton{
    self.registerButton.backgroundColor = [UIColor clearColor];
    self.registerButton.layer.cornerRadius = 8;
    self.registerButton.layer.masksToBounds = YES;
    self.registerButton.layer.borderWidth = 2;
    self.registerButton.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (IBAction)registerButtonClicked {
    if(![self isValidPhoneNumber:self.phoneNumTextField.text]){
        [SVProgressHUD showErrorWithStatus:@"请输入正确的电话号码"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    if (self.nameTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入姓名"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    if (self.passwordTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    if (self.mailTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入邮箱"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    if (![self isValidAgeNumber:self.ageTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入年龄"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    [SVProgressHUD show];
    NSString *sex = self.sexSwitch.isOn ? @"女" : @"男";
    NSLog(@"%@",sex);
    [NetworkRequest userRegisterWithName:self.nameTextField.text password:self.passwordTextField.text phone:self.phoneNumTextField.text sex:sex age:[self.ageTextField.text integerValue] Email:self.mailTextField.text success:^{
        [SVProgressHUD showSuccessWithStatus:@"注册成功!"];
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
