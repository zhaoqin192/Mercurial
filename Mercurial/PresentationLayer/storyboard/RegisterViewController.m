//
//  RegisterViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/3/17.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "RegisterViewController.h"

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
}

- (void)configureRegisterButton{
    self.registerButton.backgroundColor = [UIColor clearColor];
    self.registerButton.layer.cornerRadius = 8;
    self.registerButton.layer.masksToBounds = YES;
    self.registerButton.layer.borderWidth = 2;
    self.registerButton.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (IBAction)registerButtonClicked {
    NSLog(@"register");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
