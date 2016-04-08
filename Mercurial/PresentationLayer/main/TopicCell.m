//
//  TopicCell.m
//  Mercurial
//
//  Created by 王霄 on 16/4/8.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "TopicCell.h"
#import "Topic.h"

@interface TopicCell()
@property (weak, nonatomic) IBOutlet UILabel *myTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;

@end

@implementation TopicCell

- (void)awakeFromNib {
    self.dateLabel.font = [UIFont systemFontOfSize:14.0];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)setTopic:(Topic *)topic{
    _topic = topic;
    self.myTitleLabel.text = topic.main_title;
    self.dateLabel.text = topic.last_answer;
    self.numLabel.text = [NSString stringWithFormat:@"回复数:%@",topic.answer_number];
    self.areaLabel.text = topic.module;
}

@end
