//
//  AccountDao.h
//  Mercurial
//
//  Created by zhaoqin on 3/16/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Account.h"


@interface AccountDao : NSObject

- (void) insertWithAccountName:(NSString *)accountName
                         phone:(NSString *)phone
                           sex:(NSString *)sex
                           age:(NSInteger)age
                         Email:(NSString *)email
                      fixedTel:(NSString *)fixedTel
                        avatar:(NSString *)avatar
                          name:(NSString *)name
                         birth:(NSString *)birth
                        cardID:(NSString *)cardID
                        degree:(NSString *)degree
                           job:(NSString *)job
                      province:(NSString *)province
                          city:(NSString *)city
                      district:(NSString *)district
                       address:(NSString *)address
                      isBought:(NSInteger)isBought
                         brand:(NSString *)brand
                           way:(NSString *)way
                    experience:(NSString *)experience
                 recommendName:(NSString *)recommendName
                recommendPhone:(NSString *)recommendPhone
                       success:(void (^)())success;

- (void) insertWithAccountName:(NSString *)accountName
                      password:(NSString *)password
                         token:(NSString *)token
                       success:(void (^)())success;

- (Account *) getAccount;

- (void) deleteAccountSuccess:(void (^)())success
                      failure:(void (^)())failure;

- (BOOL) isLogin;

@end