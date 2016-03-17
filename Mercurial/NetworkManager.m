//
//  NetworkManager.m
//  Mercurial
//
//  Created by zhaoqin on 3/16/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

static NetworkManager *sharedManager;

+ (NetworkManager *)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (AFHTTPSessionManager *) getRequestQueue{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.manager = [AFHTTPSessionManager manager];
    });
    return self.manager;
}

@end
