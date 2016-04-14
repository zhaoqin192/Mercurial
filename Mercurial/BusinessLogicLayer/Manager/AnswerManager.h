//
//  AnswerManager.h
//  Mercurial
//
//  Created by zhaoqin on 4/1/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Answer;

@interface AnswerManager : NSObject

@property (nonatomic, strong) NSMutableArray *answerArray;

+ (AnswerManager *) sharedManager;

@end
