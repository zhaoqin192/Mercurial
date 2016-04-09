//
//  PostTopicViewController.h
//  Mercurial
//
//  Created by 王霄 on 16/4/9.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostTopicViewController : UIViewController
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *identify;
@property (nonatomic, copy) NSString *myTitle;
@property (nonatomic, assign) BOOL isReply;
@property (nonatomic, copy) NSString *topic_id;
@property (nonatomic, strong) NSNumber *toFloor;
@property (nonatomic, copy) NSString *answerName;
@end
