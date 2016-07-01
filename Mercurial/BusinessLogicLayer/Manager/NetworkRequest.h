//
//  NetworkRequest.h
//  Mercurial
//
//  Created by zhaoqin on 3/16/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define URLPREFIX @"http://wg.gdwm.cn:12345"

typedef void(^NetworkFetcherCompletionHandler)();
typedef void(^NetworkFetcherErrorHandler)(NSString *error);

@interface NetworkRequest : NSObject

@end
