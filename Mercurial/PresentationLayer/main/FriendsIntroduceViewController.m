//
//  FriendsIntroduceViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/4/6.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "FriendsIntroduceViewController.h"
#import "Account.h"

@interface FriendsIntroduceViewController ()
@property (nonatomic, copy) NSArray *list;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *productTF;
@property (weak, nonatomic) IBOutlet UITextField *reasonTF;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (nonatomic, strong) Account *myAccount;
@end

@implementation FriendsIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"用户推荐";
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bg"]]];
    [self configureRegisterButton];
    [self.nameTF becomeFirstResponder];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    if (self.identify) {
        [self configureTextField];
    }
}

- (void)configureTextField{
    [NetworkRequest requestCommendItem:self.identify success:^{
        self.list = [[RecommendManager sharedManager] fetchCommendArray];
        NSLog(@"%d",self.list.count);
        Recommend *recommend = [self.list firstObject];
        self.nameTF.text = recommend.recomm_name;
        self.phoneTF.text = recommend.recomm_phone;
        self.addressTF.text = recommend.address;
        self.productTF.text = recommend.recomm_product_name;
        self.reasonTF.text = recommend.recomm_reason;
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
        [SVProgressHUD showErrorWithStatus:@"请输入推荐人地址"];
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
    [SVProgressHUD show];
    self.myAccount = [[[AccountDao alloc] init] getAccount];
    
    NSDate *date1 = [NSDate date];
    //然后您需要定义一个NSDataFormat的对象
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc]init];
    //然后设置这个类的dataFormate属性为一个字符串，系统就可以因此自动识别年月日时间
    dateFormat.dateFormat = @"yyyy年MM月dd日 HH:mm:SS";
    //之后定义一个字符串，使用stringFromDate方法将日期转换为字符串
    NSString * dateToString = [dateFormat stringFromDate:date1];
    
    [NetworkRequest requestAddCommend:self.nameTF.text phone:self.phoneTF.text province:[self notNil:self.myAccount.province] city:[self notNil:self.myAccount.city] district:[self notNil:self.myAccount.district] address:self.addressTF.text commendName:self.productTF.text date:dateToString reason:self.reasonTF.text success:^{
        [SVProgressHUD showSuccessWithStatus:@"推荐成功!"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *error){
        [SVProgressHUD showErrorWithStatus:@"推荐失败"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
    }];
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
