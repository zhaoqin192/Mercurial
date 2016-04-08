//
//  Answer.h
//  Mercurial
//
//  Created by zhaoqin on 4/1/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Answer : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *answer_name;
@property (nonatomic, strong) NSString *answer_to_name;
@property (nonatomic, strong) NSNumber *floor;
@property (nonatomic, strong) NSNumber *to_floor;
@property (nonatomic, strong) NSString *answer_time;
@property (nonatomic, strong) NSString *topic_id;
@property (nonatomic, strong) NSArray *url;
@property (nonatomic, assign) CGFloat cellHeight;

@end
