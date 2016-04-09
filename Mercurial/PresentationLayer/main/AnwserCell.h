//
//  AnwserCell.h
//  Mercurial
//
//  Created by 王霄 on 16/4/8.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Answer;

@interface AnwserCell : UITableViewCell
@property (nonatomic, strong) Answer *answer;
@property (nonatomic, copy) void(^reply)();
@end
