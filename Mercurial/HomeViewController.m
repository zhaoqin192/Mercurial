//
//  HomeViewController.m
//  Mercurial
//
//  Created by zhaoqin on 3/10/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "HomeViewController.h"


@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSArray *array = @[@"roundImage0", @"roundImage1", @"roundImage2"];
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 150.0/600*ScreenHeight) imageNamesGroup:array];
    self.tableView.tableHeaderView = cycleScrollView;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 424, ScreenWidth, 182)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 182)];
    [imageView setImage:[UIImage imageNamed:@"introduce"]];
    [footView addSubview:imageView];
    self.tableView.tableFooterView = footView;
    
    
    //注册某个重用标识 对应的Cell类型
    [self.tableView registerNib:[UINib nibWithNibName:@"FuncTableViewCell" bundle:nil] forCellReuseIdentifier:@"funcCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        //1、先从缓存池中查找可循环利用的cell
        FuncTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"funcCell"];
        return cell;
    }
    
    // Configure the cell...
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 230.0 / 600 * ScreenHeight;
    }
    
    return 0;
}

@end
