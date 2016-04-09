//
//  AnwserCell.m
//  Mercurial
//
//  Created by 王霄 on 16/4/8.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "AnwserCell.h"
#import "Answer.h"

@interface AnwserCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *FloorLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *toFloorLabel;
@property (weak, nonatomic) IBOutlet UIButton *answerButton;
@end

@implementation AnwserCell

- (IBAction)answerButtonClicked {
    if (self.reply) {
        self.reply();
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setAnswer:(Answer *)answer{
    _answer = answer;
    self.nameLable.text = answer.answer_name;
    self.contentLabel.text = answer.text;
    self.FloorLabel.text = [NSString stringWithFormat:@"%@楼",answer.floor];
    self.dateLabel.text = answer.answer_time;
    if (self.answer.to_floor) {
        self.toFloorLabel.text = [NSString stringWithFormat:@"回复了%@楼",self.answer.to_floor];
    }
    else{
        self.toFloorLabel.text = @"";
    }
    [self layoutIfNeeded];
    
    if (self.answer.url.count != 0) {
        [self.myImageView sd_setImageWithURL:self.answer.url[0] placeholderImage:[UIImage imageNamed:@"answerCellPlacehold"] completed:nil];
        answer.cellHeight = CGRectGetMaxY(self.myImageView.frame) + 40;
    }
    else{
        self.myImageView.hidden = YES;
        answer.cellHeight = CGRectGetMaxY(self.contentLabel.frame) + 50;
    }
}

- (void)prepareForReuse{
    self.myImageView.hidden = NO;
}

@end
