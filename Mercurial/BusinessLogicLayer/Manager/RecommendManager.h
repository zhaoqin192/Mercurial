//
//  RecommendManager.h
//  Mercurial
//
//  Created by zhaoqin on 4/1/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Recommend;

@interface RecommendManager : NSObject

@property (nonatomic, strong) NSMutableArray *commendArray;
@property (nonatomic, strong) Recommend *recommend;

+ (RecommendManager *) sharedManager;

- (NSMutableArray *) fetchCommendArray;

- (void) addToCommendArray:(Recommend *)commend;

- (void) cleanCommendArray;

- (Recommend *) fetchRecommend;

@end
