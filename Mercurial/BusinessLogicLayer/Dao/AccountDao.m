//
//  AccountDao.m
//  Mercurial
//
//  Created by zhaoqin on 3/16/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "AccountDao.h"

@implementation AccountDao{
    AppDelegate *appDelegate;
    NSManagedObjectContext *appContext;
}

- (id) init{
    self = [super init];
    appDelegate = [[UIApplication sharedApplication] delegate];
    appContext = [appDelegate managedObjectContext];
    return self;
}

- (void) insertWithAccountName:(NSString *)accountName
                      password:(NSString *)password
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
                      isBought:(NSNumber *)isBought
                         brand:(NSString *)brand
                           way:(NSString *)way
                    experience:(NSString *)experience
                 recommendName:(NSString *)recommendName
                recommendPhone:(NSString *)recommendPhone
                       success:(void (^)())success{
    NSArray *array = [self fetchAccount];
    Account *account = nil;
    if (array == nil) {
        account = [NSEntityDescription insertNewObjectForEntityForName:@"Account" inManagedObjectContext:appContext];
    }else{
        account = [array objectAtIndex:0];
    }
    account.accountName = accountName;
    account.password = password;
    account.phone = phone;
    account.sex = sex;
    account.age = [NSNumber numberWithInteger:age];
    account.email = email;
    account.fixedTel = fixedTel;
    account.avatar = avatar;
    account.name = name;
    account.birth = birth;
    account.degree = degree;
    account.job = job;
    account.province = province;
    account.city = city;
    account.district = district;
    account.address = address;
    account.isBought = isBought;
    account.brand = brand;
    account.way = way;
    account.experience = experience;
    account.recommendName = recommendName;
    account.recommendPhone = recommendPhone;
    [appDelegate saveContext];
    success();
}

- (void) insertWithAccountName:(NSString *)accountName
                      password:(NSString *)password
                         token:(NSString *)token
                       success:(void (^)())success{
    
    NSArray *array = [self fetchAccount];
    Account *account = nil;
    if ([array count] == 0) {
        account = [NSEntityDescription insertNewObjectForEntityForName:@"Account" inManagedObjectContext:appContext];
        
    }else{
        account = [array objectAtIndex:0];
    }
    account.accountName = accountName;
    account.password = password;
    account.token = token;
    [appDelegate saveContext];
    success();
}

- (Account *) getAccount{
    NSArray *array = [self fetchAccount];
    if (array == nil) {
        return nil;
    }else{
        return [array objectAtIndex:0];
    }
    
}

- (NSArray *) fetchAccount{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Account" inManagedObjectContext:appContext];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObjects = [appContext executeFetchRequest:fetchRequest error:&error];
    return fetchedObjects;
}

- (void) deleteAccountSuccess:(void (^)())success
                      failure:(void (^)())failure{
    NSArray *array = [self fetchAccount];

    if ([array count] != 0) {
        [appContext deleteObject:[array objectAtIndex:0]];
        [appDelegate saveContext];
        success();
    }else{
        failure();
    }
}

@end

