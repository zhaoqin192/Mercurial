//
//  TopicManager.m
//  Mercurial
//
//  Created by zhaoqin on 4/1/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "TopicManager.h"

@implementation TopicManager

static TopicManager *sharedMananger;

- (instancetype)init{
    self = [super init];
    self.topicArray = [[NSMutableArray alloc] init];
    return self;
}

+ (TopicManager *) sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMananger = [[TopicManager alloc] init];
    });
    return sharedMananger;
}

- (NSMutableArray *) fetchTopicArray{
    return self.topicArray;
}

- (void) addToTopicArray:(Topic *) topic{
    [self.topicArray addObject:topic];
}

- (void) cleanTopicArray{
    [self.topicArray removeAllObjects];
}

@end
