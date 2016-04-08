//
//  AddOrderViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/4/6.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "AddOrderViewController.h"
#import "Account.h"
#import "SearchOrder.h"

@interface AddOrderViewController ()
@property (weak, nonatomic) IBOutlet UITextField *numTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *dateTF;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *modifyButton;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (nonatomic, strong) Account *myAccount;
@property (nonatomic, strong) SearchOrder *searchOrder;
@end

@implementation AddOrderViewController
- (IBAction)addButtonClicked {
}

- (IBAction)modifyButtonClicked {
}

- (IBAction)createButtonClicked {
    if(![self isValidPhoneNumber:self.phoneTF.text]){
        [SVProgressHUD showErrorWithStatus:@"请输入正确的电话号码"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        return;
    }
    if (self.nameTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入姓名"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        return;
    }
    if (self.addressTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入配送地址"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        return;
    }
    if (self.numTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入订单号"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        return;
    }
    if (self.dateTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入购买日期"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        return;
    }
    [SVProgressHUD show];
    self.myAccount = [[[AccountDao alloc] init] getAccount];
    
    [NetworkRequest requestAddOrderWithID:self.numTF.text name:self.nameTF.text province:[self notNil:self.myAccount.province] city:[self notNil:self.myAccount.city] district:[self notNil:self.myAccount.district] address:self.addressTF.text phone:self.phoneTF.text date:self.dateTF.text item:nil success:^{
        [SVProgressHUD showSuccessWithStatus:@"创建订单成功!"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *error){
        [SVProgressHUD showErrorWithStatus:@"创建失败"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"修改订单";
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bg"]]];
    [self configureRegisterButton];
    [self.numTF becomeFirstResponder];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    if (self.identify) {
        [self configureTextField];
    }
}

- (void)configureTextField{
    [NetworkRequest requestSearchOrder:self.identify success:^{
        self.searchOrder = [[OrderManager sharedManager] searchOrder];
        self.numTF.text = self.searchOrder.order_id;
        self.phoneTF.text = self.searchOrder.phone;
        self.nameTF.text = self.searchOrder.username;
        self.addressTF.text = self.searchOrder.delivery_address;
        self.dateTF.text = self.searchOrder.buy_date;
    } failure:^{
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
    }];
}

- (void)configureRegisterButton{
    self.addButton.backgroundColor = [UIColor clearColor];
    self.addButton.layer.cornerRadius = 8;
    self.addButton.layer.masksToBounds = YES;
    self.addButton.layer.borderWidth = 2;
    self.addButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.createButton.backgroundColor = [UIColor clearColor];
    self.createButton.layer.cornerRadius = 8;
    self.createButton.layer.masksToBounds = YES;
    self.createButton.layer.borderWidth = 2;
    self.createButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.modifyButton.backgroundColor = [UIColor clearColor];
    self.modifyButton.layer.cornerRadius = 8;
    self.modifyButton.layer.masksToBounds = YES;
    self.modifyButton.layer.borderWidth = 2;
    self.modifyButton.layer.borderColor = [UIColor whiteColor].CGColor;
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

- (NSString *)notNil:(NSString *)text{
    if (text) {
        return text;
    }
    else{
        return @"";
    }
}

@end
