//
//  HomeLeftViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/3/31.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "HomeLeftViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "AccountDao.h"
#import "Account.h"
#import "DatabaseManager.h"
#import "WeChatManager.h"

@interface HomeLeftViewController ()
@property (weak, nonatomic) IBOutlet UIView *MiddleView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation HomeLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.MiddleView.backgroundColor = [UIColor clearColor];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bg"]]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self configureButton];
}

- (void)configureButton{
    if ([[DatabaseManager sharedAccount] isLogin]) {
        [self.loginButton setTitle:@"退出" forState:UIControlStateNormal];
    }
    else{
        [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    //NSLog(@"touch");
}

- (IBAction)loginButtonClicked {
    if ([self.loginButton.titleLabel.text isEqualToString:@"登录"]) {
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginButtonClicked" object:nil];
        }];
    }
    else{
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginOutButtonClicked" object:nil];
        }];
    }
}

- (IBAction)registerButtonClicked {
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"registerButtonClicked" object:nil];
    }];
}

- (IBAction)shareButton:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *shareTimeAction = [UIAlertAction actionWithTitle:@"分享到朋友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            WeChatManager *manager = [[WeChatManager alloc] init];
        
            [manager onSelectTimelineScene];
        
            if ([manager sendLinkContent]) {
                NSLog(@"send success");
            }
            else {
                NSLog(@"send failure");
            }
    }];
    
    UIAlertAction *shareSessionAction = [UIAlertAction actionWithTitle:@"分享给好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            WeChatManager *manager = [[WeChatManager alloc] init];
        
            [manager onSelectSessionScene];
        
            [manager sendLinkContent];
        
            if ([manager sendLinkContent]) {
                NSLog(@"send success");
            }
            else {
                NSLog(@"send failure");
            }
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:shareTimeAction];
    [alertController addAction:shareSessionAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

@end
