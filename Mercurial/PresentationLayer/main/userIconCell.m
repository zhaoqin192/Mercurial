//
//  userIconCell.m
//  Mercurial
//
//  Created by 王霄 on 16/4/5.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "userIconCell.h"

@interface userIconCell ()
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@end

@implementation userIconCell

- (void)awakeFromNib{
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)setIconUrl:(NSString *)iconUrl{
    _iconUrl = iconUrl;
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:self.iconUrl] placeholderImage:[UIImage imageNamed:@"iconholder"] completed:nil];
}
@end
