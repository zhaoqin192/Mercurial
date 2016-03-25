//
//  ScanViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/3/14.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "ScanViewController.h"

@interface ScanViewController ()
@property (weak, nonatomic) IBOutlet UIButton *scanButton;

@property (weak, nonatomic) IBOutlet UITextField *productTextField;
@property (weak, nonatomic) IBOutlet UIButton *enquiryButton;
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
