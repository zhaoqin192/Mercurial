//
//  SalesManager.m
//  Mercurial
//
//  Created by zhaoqin on 3/17/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "SalesManager.h"

@implementation SalesManager

static SalesManager *sharedManager;

- (instancetype)init{
    self = [super init];
    self.salesArray = [[NSMutableArray alloc] init];
    self.roundArray = [[NSMutableArray alloc] init];
    return self;
}

+ (SalesManager *) sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[SalesManager alloc] init];
    });
    return sharedManager;
}

@end
