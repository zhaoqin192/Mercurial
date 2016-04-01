//
//  Topic.h
//  Mercurial
//
//  Created by zhaoqin on 4/1/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Topic : NSObject

@property (nonatomic, strong) NSString *topic_id;
@property (nonatomic, strong) NSString *main_title;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *last_answer;
@property (nonatomic, strong) NSNumber *answer_number;
@property (nonatomic, strong) NSString *module;

@end
