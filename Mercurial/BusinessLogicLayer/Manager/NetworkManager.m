//
//  NetworkManager.m
//  Mercurial
//
//  Created by zhaoqin on 3/16/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "NetworkManager.h"
#import "AFNetworking.h"


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
    [[self.manager requestSerializer] setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];

    return self.manager;
}

@end
