//
//  FormDetailViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/4/8.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "FormDetailViewController.h"
#import "AnswerManager.h"
#import "AnwserCell.h"
#import "Answer.h"

@interface FormDetailViewController ()
@property (nonatomic, copy) NSArray *list;
@end

@implementation FormDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"AnwserCell" bundle:nil] forCellReuseIdentifier:@"AnwserCell"];
    [self loadData];
}

- (void)loadData{
    [NetworkRequest requestTopicAnswerList:self.topic_id success:^{
        self.list = [[AnswerManager sharedManager] fetchAnswerArray];
        [self.tableView reloadData];
    } failure:^{
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
    }];
}

- (void)dismiss {
    [SVProgressHUD dismiss];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnwserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnwserCell"];
    Answer *answer = self.list[indexPath.row];
    cell.answer = answer;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Answer *answer = self.list[indexPath.row];
    return answer.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

@end
