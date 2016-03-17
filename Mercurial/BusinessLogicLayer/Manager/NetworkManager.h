//
//  NetworkManager.h
//  Mercurial
//
//  Created by zhaoqin on 3/16/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"


@interface NetworkManager : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *manager;

+ (NetworkManager *)sharedInstance;

- (AFHTTPSessionManager *) getRequestQueue;

@end