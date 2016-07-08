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
#import "CityPickView.h"
#import "AccountDao.h"
#import "DatabaseManager.h"
#import "Recommend.h"
#import "RecommendManager.h"
#import "NetworkRequest+Order.h"


@interface FriendsIntroduceViewController ()
<UITextFieldDelegate,CityPickViewDelegate>

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
@property (nonatomic,strong) CityPickView *pickView;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *district;
@end

@implementation FriendsIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pickView = [[CityPickView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 180)];;
    self.pickView.delegate = self;
    self.dateTF.delegate = self;
    self.dateTF.inputView = [[UIView alloc] init];
    self.longAddressTF.delegate = self;
    self.longAddressTF.inputView = self.pickView;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"用户推荐";
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bg"]]];
    [self configureRegisterButton];
    [self configurePicker];
    [self.nameTF becomeFirstResponder];
    [self configureNameTF];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    if (self.identify) {
        [self configureTextField];
    }
    else {
        [self configureDateToday];
    }
}

- (void)configureNameTF{
    [self.productTF addTarget:self action:@selector(changeName) forControlEvents:UIControlEventEditingChanged];
}

- (void)changeName{
    self.productTF.text = self.productTF.text.uppercaseString;
}

- (void)configureDateToday{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    self.dateTF.text = date;
}

- (void)configurePicker{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    
    NSDate *curDate = [NSDate dateFromString:date withFormat:@"yyyy-MM-dd"];
    self.picker = [[ActionSheetDatePicker alloc] initWithTitle:nil datePickerMode:UIDatePickerModeDate selectedDate:curDate doneBlock:^(ActionSheetDatePicker *picker, NSDate *selectedDate, id origin) {
       // NSLog(@"%@",[selectedDate string_yyyy_MM_dd]);
        self.dateTF.text = [selectedDate string_yyyy_MM_dd];
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
        self.longAddressTF.text = [[self.recommend.province stringByAppendingString:self.recommend.city] stringByAppendingString:self.recommend.district];
        self.province = self.recommend.province;
        self.city = self.recommend.city;
        self.district = self.recommend.district;
    } failure:^{
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
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

- (void)selectCity:(NSString *)city{
    self.longAddressTF.text = city;
}

- (void)fetchDetail:(NSString *)province city:(NSString *)city district:(NSString *)district{
    NSLog(@"fetch");
    self.province = province;
    self.city = city;
    self.district = district;
    [self.longAddressTF resignFirstResponder];
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
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    if (self.nameTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入推荐人姓名"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    if (self.addressTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入详细地址"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    if (self.productTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入推荐产品"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    if (self.reasonTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入推荐理由"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    if (self.dateTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入推荐日期"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    if (self.longAddressTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入推荐人地址"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    [SVProgressHUD show];
    self.myAccount = [[DatabaseManager sharedAccount] getAccount];
    if(!self.identify){
        [NetworkRequest requestAddCommend:self.nameTF.text phone:self.phoneTF.text province:self.province city:self.city district:self.district address:self.addressTF.text commendName:self.productTF.text date:self.dateTF.text reason:self.reasonTF.text success:^{
            [SVProgressHUD showSuccessWithStatus:@"推荐成功!"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSString *error){
            [SVProgressHUD showErrorWithStatus:error];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        }];
    }
    else{
        [NetworkRequest requestUpdateCommend:self.nameTF.text phone:self.phoneTF.text province:self.province city:self.city district:self.district address:self.addressTF.text commendName:self.productTF.text date:self.dateTF.text reason:self.reasonTF.text recommentID:self.identify success:^{
            [SVProgressHUD showSuccessWithStatus:@"修改推荐成功!"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
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
