//
//  NewsCell.m
//  Mercurial
//
//  Created by 王霄 on 16/3/28.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "NewsCell.h"
#import "News.h"

@interface NewsCell()
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *myTextLabel;

@end

@implementation NewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMynews:(News *)mynews{
    _mynews = mynews;
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:_mynews.imageURL] placeholderImage:[UIImage imageNamed:@"placehold"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    self.myTextLabel.text = mynews.title;
}

@end
