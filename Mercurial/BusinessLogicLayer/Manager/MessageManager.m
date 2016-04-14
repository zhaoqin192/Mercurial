//
//  MessageManager.m
//  Mercurial
//
//  Created by zhaoqin on 4/1/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "MessageManager.h"
#import "Message.h"

@implementation MessageManager

static MessageManager *sharedManager;

- (instancetype)init{
    self = [super init];
    self.messageArray = [[NSMutableArray alloc] init];
    return self;
}

+ (MessageManager *) sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[MessageManager alloc] init];
    });
    return sharedManager;
}

@end
