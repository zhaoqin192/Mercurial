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
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
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
    
    CGFloat itemW = 100;
    CGFloat itemH = 100;
    CGFloat margin = 15;
    if (self.answer.url.count != 0) {
        for(int i = 0; i<self.answer.url.count; i++){
            UIImageView *imageView = [UIImageView new];
            [imageView sd_setImageWithURL:self.answer.url[i] placeholderImage:[UIImage imageNamed:@"answerCellPlacehold"] completed:nil];
            imageView.frame = CGRectMake(i * (itemW + margin), (self.myScrollView.frame.size.height - itemH)/2, itemW, itemH);
            [self.myScrollView addSubview:imageView];
            self.myScrollView.contentSize = CGSizeMake(CGRectGetMaxX(imageView.frame), 0);
        }
        answer.cellHeight = CGRectGetMaxY(self.myScrollView.frame) + 40;
    }
    else{
        self.myScrollView.hidden = YES;
        answer.cellHeight = CGRectGetMaxY(self.contentLabel.frame) + 50;
    }
}

- (void)prepareForReuse{
    for (UIView *view in self.myScrollView.subviews) {
        [view removeFromSuperview];
    }
    self.myScrollView.hidden = NO;
}

@end
