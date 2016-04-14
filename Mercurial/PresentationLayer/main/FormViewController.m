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
#import "FormDetailViewController.h"
#import "SelectionViewController.h"
#import "PostTopicViewController.h"
#import "NetworkRequest+BBS.h"


@interface FormViewController ()
@property (nonatomic, copy) NSArray *list;
@end

@implementation FormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureNavigationItem];
    [self.tableView registerNib:[UINib nibWithNibName:@"TopicCell" bundle:nil] forCellReuseIdentifier:@"TopicCell"];
    self.tableView.rowHeight = 90;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData];
}

- (void)configureNavigationItem{
    self.navigationItem.title = @"用户互动";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBarButtonClicked)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonSystemItemAdd target:self action:@selector(rightBarButtonClicked)];
}

- (void)rightBarButtonClicked{
    if (self.isPost) {
        [self postActionSheetShow];
    }
    else{
        [self selectActionSheetShow];
    }
}

- (void)postActionSheetShow{
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *post = [UIAlertAction actionWithTitle:@"发帖" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        PostTopicViewController *vc = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"PostTopicViewController"];
        vc.identify = self.identify;
        vc.type = self.type;
        vc.myTitle = @"发帖";
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [vc addAction:cancel];
    [vc addAction:post];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)selectActionSheetShow{
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *area = [UIAlertAction actionWithTitle:@"产品区域" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SelectionViewController *vc = [[SelectionViewController alloc] init];
        vc.type = @"product_area";
        vc.myTitle = @"产品区域";
        [self.navigationController pushViewController:vc animated:YES];
    }];
    UIAlertAction *serial = [UIAlertAction actionWithTitle:@"产品系列" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SelectionViewController *vc = [[SelectionViewController alloc] init];
        vc.type = @"product_type";
        vc.myTitle = @"产品系列";
        [self.navigationController pushViewController:vc animated:YES];
    }];
    UIAlertAction *price = [UIAlertAction actionWithTitle:@"产品价位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SelectionViewController *vc = [[SelectionViewController alloc] init];
        vc.type = @"product_price";
        vc.myTitle = @"产品价位";
        [self.navigationController pushViewController:vc animated:YES];
    }];
    UIAlertAction *exprience = [UIAlertAction actionWithTitle:@"装修经验" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SelectionViewController *vc = [[SelectionViewController alloc] init];
        vc.type = @"product_decro_experience";
        vc.myTitle = @"装修经验";
        [self.navigationController pushViewController:vc animated:YES];
    }];
    UIAlertAction *other = [UIAlertAction actionWithTitle:@"其他版块" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SelectionViewController *vc = [[SelectionViewController alloc] init];
        vc.type = @"product_other";
        vc.myTitle = @"其他版块";
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [vc addAction:cancel];
    [vc addAction:area];
    [vc addAction:serial];
    [vc addAction:price];
    [vc addAction:exprience];
    [vc addAction:other];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)loadData{
    [NetworkRequest requestTopicList:self.type identify:self.identify success:^{
        self.list = [TopicManager sharedManager].topicArray;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Topic *topic = self.list[indexPath.row];
    FormDetailViewController *vc = [[FormDetailViewController alloc] init];
    vc.topic_id = topic.topic_id;
    [self.navigationController pushViewController:vc animated:YES];
}




@end
