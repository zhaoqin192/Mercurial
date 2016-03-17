//
//  SexViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/3/14.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "SexViewController.h"
#import "RadioButton.h"

@interface SexViewController ()
@property (weak, nonatomic) IBOutlet RadioButton *radioButtonMale;
@property (weak, nonatomic) IBOutlet RadioButton *radioButtonFamale;

@end

@implementation SexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"性别";
    self.radioButtonMale.groupButtons = @[self.radioButtonMale,self.radioButtonFamale];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
