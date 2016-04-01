//
//  AnswerManager.h
//  Mercurial
//
//  Created by zhaoqin on 4/1/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Answer.h"

@interface AnswerManager : NSObject

@property (nonatomic, strong) NSMutableArray *answerArray;

+ (AnswerManager *) sharedManager;

- (NSMutableArray *) fetchAnswerArray;

- (void) addToAnswerArray:(Answer *) answer;

- (void) cleanAnswerArray;

@end
