//
//  DatabaseManager.m
//  Mercurial
//
//  Created by zhaoqin on 3/16/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "DatabaseManager.h"
#import "AccountDao.h"

@implementation DatabaseManager

static AccountDao *accountDao;

+ (AccountDao *)sharedAccount{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        accountDao = [[AccountDao alloc] init];
    });
    return accountDao;
}

@end
