//
//  NewsManager.m
//  Mercurial
//
//  Created by zhaoqin on 3/16/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "NewsManager.h"

@implementation NewsManager

static NewsManager *sharedManager;

- (instancetype)init{
    self = [super init];
    self.newsArray = [[NSMutableArray alloc] init];
    return self;
}

+ (NewsManager *) sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[NewsManager alloc] init];
    });
    return sharedManager;
}

@end
