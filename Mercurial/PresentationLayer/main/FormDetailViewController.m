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
#import "PostTopicViewController.h"
#import "NetworkRequest+BBS.h"


@interface FormDetailViewController ()
@property (nonatomic, copy) NSArray *list;

@end

@implementation FormDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"AnwserCell" bundle:nil] forCellReuseIdentifier:@"AnwserCell"];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData];
}

- (void)loadData{
    __weak typeof(self) weakSelf = self;
    [NetworkRequest requestTopicAnswerList:self.topic_id success:^{
        weakSelf.list = [AnswerManager sharedManager].answerArray;
        [weakSelf.tableView reloadData];
    } failure:^{
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        [weakSelf performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
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
    __weak typeof(self) weakSelf = self;
    cell.reply = ^{
        PostTopicViewController *vc = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"PostTopicViewController"];
        vc.myTitle = @"回复";
        vc.topic_id = weakSelf.topic_id;
        vc.toFloor = [NSNumber numberWithInteger:indexPath.row];
        vc.answerName = answer.answer_name;
        vc.isReply = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Answer *answer = self.list[indexPath.row];
    return answer.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
