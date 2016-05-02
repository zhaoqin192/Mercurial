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
#import "AddProductViewController.h"
#import "ModifyProductViewController.h"
#import "ActionSheetDatePicker.h"
#import "CityPickView.h"
#import "DatabaseManager.h"
#import "AccountDao.h"
#import "OrderManager.h"
#import "NetworkRequest+Order.h"
#import <CoreLocation/CoreLocation.h>

@interface AddOrderViewController ()<CLLocationManagerDelegate,UITextFieldDelegate,CityPickViewDelegate>

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
@property (nonatomic, strong) NSMutableArray *items;
@property (strong, nonatomic) ActionSheetDatePicker *picker;
@property (nonatomic,strong) CityPickView *pickView;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *district;
@property(nonatomic ,strong) CLLocationManager *locationM;
@end

@implementation AddOrderViewController
- (IBAction)addButtonClicked {
    AddProductViewController *vc = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"AddProductViewController"];
    vc.addOrder = ^(Order *order){
        [self.items addObject:order];
        [self createButtonClicked];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)modifyButtonClicked {
    ModifyProductViewController *vc = [[ModifyProductViewController alloc] init];
    vc.productList = self.items;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)createButtonClicked {
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
    if (self.addressTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入配送地址"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    if (self.numTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入订单号"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    if (self.dateTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入购买日期"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        return;
    }
    [SVProgressHUD show];
    self.myAccount = [[DatabaseManager sharedAccount] getAccount];
    
    [NetworkRequest requestAddOrderWithID:self.numTF.text name:self.nameTF.text province:self.province city:self.city district:self.district address:self.addressTF.text phone:self.phoneTF.text date:self.dateTF.text item:self.items success:^{
        [SVProgressHUD showSuccessWithStatus:@"创建订单成功!"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *error){
        [SVProgressHUD showErrorWithStatus:error];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pickView = [[CityPickView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 180)];;
    self.pickView.delegate = self;
    self.dateTF.delegate = self;
    self.dateTF.inputView = [[UIView alloc] init];
    self.addressTF.delegate = self;
    self.addressTF.inputView = self.pickView;
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (!self.myTitle) {
        self.navigationItem.title = @"新增订单";
    }
    else{
        self.navigationItem.title = self.myTitle;
    }
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bg"]]];
    [self configureRegisterButton];
    [self configurePicker];
    [self.numTF becomeFirstResponder];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createButtonClicked) name:@"SaveOrder" object:nil];
    
    if (self.identify) {
        [self configureTextField];
    }
    else{
        [self configureDateToday];
        self.items = [[NSMutableArray alloc] init];
        [self.locationM startUpdatingLocation];
    }
}

- (void)configureDateToday{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    self.dateTF.text = date;
}

- (void)configurePicker{
    NSDate *curDate = [NSDate dateFromString:@"1990-01-01" withFormat:@"yyyy-MM-dd"];
    self.picker = [[ActionSheetDatePicker alloc] initWithTitle:nil datePickerMode:UIDatePickerModeDate selectedDate:curDate doneBlock:^(ActionSheetDatePicker *picker, NSDate *selectedDate, id origin) {
        // NSLog(@"%@",[selectedDate string_yyyy_MM_dd]);
        self.dateTF.text = [selectedDate string_yyyy_MM_dd];
        [self.dateTF resignFirstResponder];
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        
    } origin:self.view];
    self.picker.minimumDate = [[NSDate date] offsetYear:-120];
    self.picker.maximumDate = [NSDate date];
}

- (void)selectCity:(NSString *)city{
    self.addressTF.text = city;
}

- (void)fetchDetail:(NSString *)province city:(NSString *)city district:(NSString *)district{
    NSLog(@"fetch");
    self.province = province;
    self.city = city;
    self.district = district;
    [self.addressTF resignFirstResponder];
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

- (void)configureTextField{
    [NetworkRequest requestSearchOrder:self.identify success:^{
        self.searchOrder = [[OrderManager sharedManager] searchOrder];
        self.numTF.text = self.searchOrder.order_id;
        self.phoneTF.text = self.searchOrder.phone;
        self.nameTF.text = self.searchOrder.username;
        self.addressTF.text = self.searchOrder.delivery_address;
        self.dateTF.text = self.searchOrder.buy_date;
        self.items = self.searchOrder.items;
        self.province = self.searchOrder.delivery_province;
        self.city = self.searchOrder.delivery_city;
        self.district = self.searchOrder.delivery_district;
    } failure:^{
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
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

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

#pragma mark - 懒加载

/**
 *  位置管理者 懒加载方法
 */
- (CLLocationManager *)locationM
{
    if (!_locationM) {
        _locationM = [[CLLocationManager alloc] init];
        _locationM.delegate = self;
        
        /** ios8.0+定位适配 */
        if ([[UIDevice currentDevice].systemVersion floatValue]
            >= 8.0) {
            // 请求前台定位授权
            // 如果当前的授权状态是用户为选择状态, 那么这个方法才会有效
            // 默认情况只能在前台获取用户位置信息
            // 如果想要在后台获取用户位置, 需要勾选后台模式, 但是, 当APP推到后台时, 会出现一个蓝条, 不断提醒用户
            //            [_locationM requestWhenInUseAuthorization];
            
            // 请求前后台定位授权
            // 如果当前的授权状态是用户为选择状态, 那么这个方法才会有效
            // 无论在前台, 还是后台, 都可以获取用户的位置信息, 而且不会出现蓝条, 根是否勾选了后台模式location udpates没有关系
            [_locationM requestAlwaysAuthorization];
        }
        
        // 2中适配方案
        //        if ([_locationM respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        //            [_locationM requestAlwaysAuthorization];
        //        }
        
    }
    return _locationM;
}



#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"定位到了");
    
    CLLocation *currentLocation = [locations lastObject]; // 最后一个值为最新位置
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    // 根据经纬度反向得出位置城市信息
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            NSLog(@"定位到了%@",placeMark.locality);
            self.addressTF.text = placeMark.locality;
        }
    }];
}


/**
 *  当前的授权状态发生改变时调用
 *
 *  @param manager 位置管理者
 *  @param status  授权状态
 */
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"用户没有决定");
            break;
        }
            // 系统预留字段, 暂时没有用
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"受限制");
            break;
        }
        case kCLAuthorizationStatusDenied:
        {
            
            // 判断是否支持定位, 或者定位服务是否开启
            if ([CLLocationManager locationServicesEnabled])
            {
                NSLog(@"真正被拒绝");
                // iOS8.0- , 截图提醒用户整个操作流程
                // iO8.0+, 直接跳转到设置界面, 核心代码
                // 弹框, 让用户选择之后再跳转
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }else
            {
                NSLog(@"定位服务关闭");
                
            }
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            NSLog(@"前后台定位授权");
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            NSLog(@"前台定位授权");
            break;
        }
            
            
        default:
            break;
    }
}

@end
