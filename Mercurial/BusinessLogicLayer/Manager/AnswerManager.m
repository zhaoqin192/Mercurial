//
//  AnswerManager.m
//  Mercurial
//
//  Created by zhaoqin on 4/1/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "AnswerManager.h"
#import "Answer.h"


@implementation AnswerManager

static AnswerManager *sharedManager;

- (instancetype)init{
    self = [super init];
    self.answerArray = [[NSMutableArray alloc] init];
    return self;
}

+ (AnswerManager *) sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[AnswerManager alloc] init];
    });
    return sharedManager;
}

- (NSMutableArray *) fetchAnswerArray{
    return self.answerArray;
}

- (void) addToAnswerArray:(Answer *) answer{
    [self.answerArray addObject:answer];
}

- (void) cleanAnswerArray{
    [self.answerArray removeAllObjects];
}

@end
