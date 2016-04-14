//
//  MessageManager.h
//  Mercurial
//
//  Created by zhaoqin on 4/1/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Message;

@interface MessageManager : NSObject

@property (nonatomic, strong) NSMutableArray *messageArray;

+ (MessageManager *) sharedManager;

@end
