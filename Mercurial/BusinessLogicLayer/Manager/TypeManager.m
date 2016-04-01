//
//  TypeManager.m
//  Mercurial
//
//  Created by zhaoqin on 4/1/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "TypeManager.h"

@implementation TypeManager

static TypeManager *sharedManager;

- (instancetype)init{
    self = [super init];
    self.typeArray = [[NSMutableArray alloc] init];
    return self;
}

+ (TypeManager *) sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[TypeManager alloc] init];
    });
    return sharedManager;
}

- (NSMutableArray *) fetchTypeArray{
    return self.typeArray;
}

- (void) addToTypeArray:(Type *) type{
    [self.typeArray addObject:type];
}

- (void) cleanTypeArray{
    [self.typeArray removeAllObjects];
}

@end
