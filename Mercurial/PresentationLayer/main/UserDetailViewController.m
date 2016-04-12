//
//  UserDetailViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/4/4.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "UserDetailViewController.h"
#import "Account.h"

@interface UserDetailViewController ()
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation UserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.myTitle;
    [self configureButton];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bg"]]];
    [self.textField becomeFirstResponder];
}

- (void)configureButton{
    self.saveButton.backgroundColor = [UIColor clearColor];
    self.saveButton.layer.cornerRadius = 8;
    self.saveButton.layer.masksToBounds = YES;
    self.saveButton.layer.borderWidth = 2;
    self.saveButton.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (IBAction)buttonClicked {
    if (self.returnString) {
        self.returnString(self.textField.text); 
    }
    [self uploadData];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)uploadData{
    [NetworkRequest updateUserInformationWithSex:[self notNil:self.myAccount.sex] age:[self notNil:[NSString stringWithFormat:@"%@",self.myAccount.age]] Email:[self notNil:self.myAccount.email] phone:[self notNil:self.myAccount.fixedTel] photo:@"" name:[self notNil:self.myAccount.name] birth:[self notNil:self.myAccount.birth] cardID:[self notNil:self.myAccount.cardID] degree:[self notNil:self.myAccount.degree] job:[self notNil:self.myAccount.job] province:[self notNil:self.myAccount.province] city:[self notNil:self.myAccount.city] district:[self notNil:self.myAccount.district] address:[self notNil:self.myAccount.address] isBought:self.myAccount.isBought brand:[self notNil:self.myAccount.brand] way:[self notNil:self.myAccount.way] experience:[self notNil:self.myAccount.experience] recommendName:[self notNil:self.myAccount.recommendName] recommendPhone:[self notNil:self.myAccount.recommendPhone] success:^{
    } failure:^(NSString *error){
        [SVProgressHUD showErrorWithStatus:@"更新数据失败，请重新尝试"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
    }];
}

- (NSString *)notNil:(NSString *)text{
    if (text) {
        return text;
    }
    else{
        return @"";
    }
}

- (void)dismiss {
    [SVProgressHUD dismiss];
}

@end
