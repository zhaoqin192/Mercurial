//
//  DatabaseManager.h
//  Mercurial
//
//  Created by zhaoqin on 3/16/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AccountDao;

@interface DatabaseManager : NSObject

+ (AccountDao *)sharedAccount;

@end
