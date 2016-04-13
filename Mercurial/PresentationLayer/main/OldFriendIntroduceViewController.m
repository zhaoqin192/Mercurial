//
//  OldFriendIntroduceViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/4/11.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "OldFriendIntroduceViewController.h"
#import "Account.h"

@interface OldFriendIntroduceViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation OldFriendIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureButton];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bg"]]];
    [self.nameTF becomeFirstResponder];
    [self configureTextField];
}

- (void)configureTextField{
    self.myAccount = [[DatabaseManager sharedAccount] getAccount];
    self.nameTF.text = self.myAccount.recommendName;
    self.phoneTF.text = self.myAccount.recommendPhone;
}

- (void)configureButton{
    self.saveButton.backgroundColor = [UIColor clearColor];
    self.saveButton.layer.cornerRadius = 8;
    self.saveButton.layer.masksToBounds = YES;
    self.saveButton.layer.borderWidth = 2;
    self.saveButton.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (IBAction)buttonClicked {
    if(![self isValidPhoneNumber:self.phoneTF.text]){
        [SVProgressHUD showErrorWithStatus:@"请输入正确的电话号码"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    if (self.nameTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入姓名"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    if (self.returnString) {
        self.returnString(self.nameTF.text,self.phoneTF.text);
    }
   // [self uploadData];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)uploadData{
    [NetworkRequest updateUserInformationWithSex:[self notNil:self.myAccount.sex] age:[self notNil:[NSString stringWithFormat:@"%@",self.myAccount.age]] Email:[self notNil:self.myAccount.email] phone:[self notNil:self.myAccount.fixedTel] photo:@"" name:[self notNil:self.myAccount.name] birth:[self notNil:self.myAccount.birth] cardID:[self notNil:self.myAccount.cardID] degree:[self notNil:self.myAccount.degree] job:[self notNil:self.myAccount.job] province:[self notNil:self.myAccount.province] city:[self notNil:self.myAccount.city] district:[self notNil:self.myAccount.district] address:[self notNil:self.myAccount.address] isBought:self.myAccount.isBought brand:[self notNil:self.myAccount.brand] way:[self notNil:self.myAccount.way] experience:[self notNil:self.myAccount.experience] recommendName:[self notNil:self.myAccount.recommendName] recommendPhone:[self notNil:self.myAccount.recommendPhone] success:^{
    } failure:^(NSString *error){
        [SVProgressHUD showErrorWithStatus:@"更新数据失败，请重新尝试"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
    }];
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
