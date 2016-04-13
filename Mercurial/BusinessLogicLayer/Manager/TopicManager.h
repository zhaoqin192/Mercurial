//
//  TopicManager.h
//  Mercurial
//
//  Created by zhaoqin on 4/1/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Topic;

@interface TopicManager : NSObject

@property (nonatomic, strong) NSMutableArray *topicArray;

+ (TopicManager *) sharedManager;

- (NSMutableArray *) fetchTopicArray;

- (void) addToTopicArray:(Topic *) topic;

- (void) cleanTopicArray;

@end
