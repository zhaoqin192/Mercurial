//
//  PromoteViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/3/14.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "PromoteViewController.h"

@interface PromoteViewController ()
@property (weak, nonatomic) IBOutlet UILabel *informationLabel;
@end

@implementation PromoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"促销信息";
    // Do any additional setup after loading the view from its nib.
    self.informationLabel.text = @"会议指出，由于受煤炭市场持续疲软、煤炭价格持续走低等不利因素影响，龙煤集团出现了严重亏损，目前仍拖欠职工工资、税收和企业应上缴的各类保险，不少职工生活遇到困难。从当前的情况看，龙煤双矿部分职工群体上访是在理性、温和的范围内进行的，没有发生过激行为。龙煤集团和双矿充分发挥主体责任，积极回应群众诉求，做了很多解释和其它有效的工作；市委市政府坚决按照省委省政府的要求，采取切实可行措施做好稳控工作，一定程度上缓解了矛盾，平复了群众情绪，取得了一定效果。";
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
