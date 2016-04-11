//
//  FriendsIntroduceViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/4/6.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "FriendsIntroduceViewController.h"
#import "Account.h"
#import "ActionSheetDatePicker.h"

@interface FriendsIntroduceViewController () <UITextFieldDelegate>
@property (nonatomic, strong) Recommend *recommend;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *productTF;
@property (weak, nonatomic) IBOutlet UITextField *reasonTF;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (nonatomic, strong) Account *myAccount;
@property (weak, nonatomic) IBOutlet UITextField *longAddressTF;
@property (weak, nonatomic) IBOutlet UITextField *dateTF;
@property (strong, nonatomic) ActionSheetDatePicker *picker;
@end

@implementation FriendsIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dateTF.delegate = self;
    self.dateTF.inputView = [[UIView alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"用户推荐";
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bg"]]];
    [self configureRegisterButton];
    [self configurePicker];
    [self.nameTF becomeFirstResponder];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    if (self.identify) {
        [self configureTextField];
    }
}

- (void)configurePicker{
    NSDate *curDate = [NSDate dateFromString:@"1990-01-01" withFormat:@"yyyy-MM-dd"];
    self.picker = [[ActionSheetDatePicker alloc] initWithTitle:nil datePickerMode:UIDatePickerModeDate selectedDate:curDate doneBlock:^(ActionSheetDatePicker *picker, NSDate *selectedDate, id origin) {
        NSLog(@"%@",[selectedDate string_yyyy_MM_dd]);
        [self.dateTF setValue:[selectedDate string_yyyy_MM_dd] forKey:@"text"];
        [self.dateTF resignFirstResponder];
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        
    } origin:self.view];
    self.picker.minimumDate = [[NSDate date] offsetYear:-120];
    self.picker.maximumDate = [NSDate date];
}

- (void)configureTextField{
    [NetworkRequest requestCommendItem:self.identify success:^{
        self.recommend = [[RecommendManager sharedManager] recommend];
        self.nameTF.text = self.recommend.recomm_name;
        self.phoneTF.text = self.recommend.recomm_phone;
        self.addressTF.text = self.recommend.address;
        self.productTF.text = self.recommend.recomm_product_name;
        self.reasonTF.text = self.recommend.recomm_reason;
        self.dateTF.text = self.recommend.date;
        self.longAddressTF.text = [[self.recommend.city stringByAppendingString:self.recommend.province] stringByAppendingString:self.recommend.district];
    } failure:^{
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
    }];
}

- (void)configureRegisterButton{
    self.saveButton.backgroundColor = [UIColor clearColor];
    self.saveButton.layer.cornerRadius = 8;
    self.saveButton.layer.masksToBounds = YES;
    self.saveButton.layer.borderWidth = 2;
    self.saveButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.backButton.backgroundColor = [UIColor clearColor];
    self.backButton.layer.cornerRadius = 8;
    self.backButton.layer.masksToBounds = YES;
    self.backButton.layer.borderWidth = 2;
    self.backButton.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)dismiss {
    [SVProgressHUD dismiss];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark -<TextFieldDelegate>

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField == self.dateTF){
        [self.picker showActionSheetPicker];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return NO;
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
- (IBAction)saveButtonClicked {
    if(![self isValidPhoneNumber:self.phoneTF.text]){
        [SVProgressHUD showErrorWithStatus:@"请输入正确的推荐人电话号码"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        return;
    }
    if (self.nameTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入推荐人姓名"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        return;
    }
    if (self.addressTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入详细地址"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        return;
    }
    if (self.productTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入推荐产品"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        return;
    }
    if (self.reasonTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入推荐理由"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        return;
    }
    if (self.dateTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入推荐日期"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        return;
    }
    if (self.longAddressTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入推荐人地址"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        return;
    }
    [SVProgressHUD show];
    self.myAccount = [[[AccountDao alloc] init] getAccount];
    
    NSDate *date1 = [NSDate date];
    //然后您需要定义一个NSDataFormat的对象
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc]init];
    //然后设置这个类的dataFormate属性为一个字符串，系统就可以因此自动识别年月日时间
    dateFormat.dateFormat = @"yyyy-MM-dd";
    //之后定义一个字符串，使用stringFromDate方法将日期转换为字符串
    NSString * dateToString = [dateFormat stringFromDate:date1];
    
    if(!self.identify){
        [NetworkRequest requestAddCommend:self.nameTF.text phone:self.phoneTF.text province:[self notNil:self.myAccount.province] city:[self notNil:self.myAccount.city] district:[self notNil:self.myAccount.district] address:self.addressTF.text commendName:self.productTF.text date:dateToString reason:self.reasonTF.text success:^{
            [SVProgressHUD showSuccessWithStatus:@"推荐成功!"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSString *error){
            [SVProgressHUD showErrorWithStatus:error];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        }];
    }
    else{
        [NetworkRequest requestUpdateCommend:self.nameTF.text phone:self.phoneTF.text province:[self notNil:self.myAccount.province] city:[self notNil:self.myAccount.city] district:[self notNil:self.myAccount.district] address:self.addressTF.text commendName:self.productTF.text date:dateToString reason:self.reasonTF.text recommentID:self.identify success:^{
            [SVProgressHUD showSuccessWithStatus:@"修改推荐成功!"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSString *error) {
            [SVProgressHUD showErrorWithStatus:error];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        }];
    }
}

- (IBAction)backButtonClicked {
    [self.navigationController popViewControllerAnimated:YES];
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
