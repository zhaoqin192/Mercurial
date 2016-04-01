//
//  MessageManager.h
//  Mercurial
//
//  Created by zhaoqin on 4/1/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"

@interface MessageManager : NSObject

@property (nonatomic, strong) NSMutableArray *messageArray;

+ (MessageManager *) sharedManager;

- (NSMutableArray *) fetchMessageArray;

- (void) addToMessageArray:(Message *)message;

- (void) cleanMessageArray;

@end
