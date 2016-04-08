//
//  FormViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/4/8.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "FormViewController.h"
#import "TopicCell.h"
#import "Topic.h"
#import "TopicManager.h"

@interface FormViewController ()
@property (nonatomic, copy) NSArray *list;
@end

@implementation FormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"TopicCell" bundle:nil] forCellReuseIdentifier:@"TopicCell"];
    self.tableView.rowHeight = 90;
    [self loadData];
}

- (void)loadData{
    [NetworkRequest requestTopicList:nil identify:nil success:^{
        self.list = [[TopicManager sharedManager] fetchTopicArray];
        [self.tableView reloadData];
    } failure:^{
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
    }];
}

- (void)dismiss {
    [SVProgressHUD dismiss];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopicCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TopicCell"];
    Topic *topic = self.list[indexPath.row];
    cell.topic = topic;
    return cell;
}




@end
