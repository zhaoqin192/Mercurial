//
//  AddProductViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/4/9.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "AddProductViewController.h"
#import "Order.h"

@interface AddProductViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *rankTF;
@property (weak, nonatomic) IBOutlet UITextField *numTF;
@property (weak, nonatomic) IBOutlet UITextField *priceTF;
@property (weak, nonatomic) IBOutlet UITextField *usageTF;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *returnButton;
@end

@implementation AddProductViewController

- (IBAction)saveButtonClicked {
    if(self.nameTF.text.length == 0){
        [SVProgressHUD showErrorWithStatus:@"请输入产品名称"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        return;
    }
    if (self.rankTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入产品等级"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        return;
    }
    if (self.numTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入产品数量"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        return;
    }
    if (self.priceTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入产品价格"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        return;
    }
    if (self.usageTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入产品用途"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        return;
    }
    Order *order = [[Order alloc] init];
    order.product_name = self.nameTF.text;
    order.product_level = self.rankTF.text;
    order.product_amount = [NSNumber numberWithInteger:[self.numTF.text integerValue]];
    order.product_price = [NSNumber numberWithInteger:[self.priceTF.text integerValue]];
    order.product_usage = self.usageTF.text;
    if (self.addOrder) {
        self.addOrder(order);
    }else{
        self.order.product_name = self.nameTF.text;
        self.order.product_level = self.rankTF.text;
        self.order.product_amount = [NSNumber numberWithInteger:[self.numTF.text integerValue]];
        self.order.product_price = [NSNumber numberWithInteger:[self.priceTF.text integerValue]];
        self.order.product_usage = self.usageTF.text;
    }
    [self returnButtonClicked];
}

- (IBAction)returnButtonClicked {
    [self.navigationController popViewControllerAnimated:YES];
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
    if (self.order) {
        [self configureTextField];
    }
}

- (void)configureTextField{
    self.numTF.text = [NSString stringWithFormat:@"%@",self.order.product_amount];
    self.nameTF.text = self.order.product_name;
    self.rankTF.text = self.order.product_level;
    self.usageTF.text = self.order.product_usage;
    self.priceTF.text = [NSString stringWithFormat:@"%@",self.order.product_price];
}

- (void)configureRegisterButton{
    self.saveButton.backgroundColor = [UIColor clearColor];
    self.saveButton.layer.cornerRadius = 8;
    self.saveButton.layer.masksToBounds = YES;
    self.saveButton.layer.borderWidth = 2;
    self.saveButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.returnButton.backgroundColor = [UIColor clearColor];
    self.returnButton.layer.cornerRadius = 8;
    self.returnButton.layer.masksToBounds = YES;
    self.returnButton.layer.borderWidth = 2;
    self.returnButton.layer.borderColor = [UIColor whiteColor].CGColor;
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
