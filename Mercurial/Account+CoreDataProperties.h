//
//  Account+CoreDataProperties.h
//  Mercurial
//
//  Created by zhaoqin on 3/16/16.
//  Copyright © 2016 muggins. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Account.h"

NS_ASSUME_NONNULL_BEGIN

@interface Account (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *password;
@property (nullable, nonatomic, retain) NSString *phone;
@property (nullable, nonatomic, retain) NSString *sex;
@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *accountName;
@property (nullable, nonatomic, retain) NSString *token;
@property (nullable, nonatomic, retain) NSString *fixedTel;
@property (nullable, nonatomic, retain) NSString *birth;
@property (nullable, nonatomic, retain) NSString *cardID;
@property (nullable, nonatomic, retain) NSString *degree;
@property (nullable, nonatomic, retain) NSString *job;
@property (nullable, nonatomic, retain) NSString *province;
@property (nullable, nonatomic, retain) NSString *city;
@property (nullable, nonatomic, retain) NSString *district;
@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSNumber *isBought;
@property (nullable, nonatomic, retain) NSString *brand;
@property (nullable, nonatomic, retain) NSString *way;
@property (nullable, nonatomic, retain) NSString *experience;
@property (nullable, nonatomic, retain) NSString *recommendName;
@property (nullable, nonatomic, retain) NSString *recommendPhone;
@property (nullable, nonatomic, retain) NSString *avatar;

@end

NS_ASSUME_NONNULL_END
