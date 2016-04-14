//
//  ScanViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/3/14.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "ScanViewController.h"
#import "QRCodeReaderViewController.h"
#import "QRCodeReader.h"
#import "NetworkRequest+Others.h"

@interface ScanViewController () <QRCodeReaderDelegate>
@property (weak, nonatomic) IBOutlet UIButton *scanButton;
@property (weak, nonatomic) IBOutlet UITextField *productTextField;
@property (weak, nonatomic) IBOutlet UIButton *enquiryButton;
@property (strong, nonatomic) QRCodeReaderViewController *reader;
@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"防伪查询";
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bg"]]];
    [self configureButton];
} 

- (void)configureButton{
    self.scanButton.backgroundColor = [UIColor clearColor];
    self.scanButton.layer.cornerRadius = 8;
    self.scanButton.layer.masksToBounds = YES;
    self.scanButton.layer.borderWidth = 2;
    self.scanButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.enquiryButton.backgroundColor = [UIColor clearColor];
    self.enquiryButton.layer.cornerRadius = 8;
    self.enquiryButton.layer.masksToBounds = YES;
    self.enquiryButton.layer.borderWidth = 2;
    self.enquiryButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.productTextField.layer.borderColor = [UIColor blueColor].CGColor;
    self.productTextField.layer.borderWidth = 3;
}
- (IBAction)scanButtonClicked {
    if ([QRCodeReader supportsMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]]) {
        static QRCodeReaderViewController *reader = nil;
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
            reader = [QRCodeReaderViewController new];
        });
        reader.delegate = self;
        
        [reader setCompletionWithBlock:^(NSString *resultAsString) {
            NSLog(@"Completion with result: %@", resultAsString);
        }];
        
        [self presentViewController:reader animated:YES completion:NULL];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Reader not supported by the current device" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)enquryButtonClicked {
    [SVProgressHUD show];
    [NetworkRequest requestFakeSearch:self.productTextField.text success:^{
        [SVProgressHUD showSuccessWithStatus:@"已查到该产品"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
    } failure:^(NSString *error){
        [SVProgressHUD showErrorWithStatus:@"未查询到该产品"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
    }];
}

- (void)dismiss {
    [SVProgressHUD dismiss];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [self dismissViewControllerAnimated:YES completion:^{
        self.productTextField.text = result;
        [self enquryButtonClicked];
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
