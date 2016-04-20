//
//  TypeManager.m
//  Mercurial
//
//  Created by zhaoqin on 4/1/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "TypeManager.h"
#import "Type.h"


@implementation TypeManager


- (instancetype)init{
    self = [super init];
    self.typeArray = [[NSMutableArray alloc] init];
    return self;
}

+ (TypeManager *) sharedManager{
    static TypeManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[TypeManager alloc] init];
    });
    return sharedManager;
}

@end
