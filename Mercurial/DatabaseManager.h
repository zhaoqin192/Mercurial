//
//  DatabaseManager.h
//  Mercurial
//
//  Created by zhaoqin on 3/16/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountDao.h"

@interface DatabaseManager : NSObject

+ (AccountDao *)sharedAccount;

@end
