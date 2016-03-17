//
//  NetworkRequest.h
//  Mercurial
//
//  Created by zhaoqin on 3/16/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkManager.h"
#import "AFNetworking.h"
#import "Utility.h"
#import "DatabaseManager.h"

#define URLPREFIX @"http://yyzwt.cn:12345"

@interface NetworkRequest : NSObject

/**
*  The interface for user registration
*
*  @param name
*  @param password
*  @param phone
*  @param sex      男/女
*  @param email
*
*  @return
*/
+ (void) userRegisterWithName:(NSString *)name
                          password:(NSString *)password
                             phone:(NSString *)phone
                               sex:(NSString *)sex
                               age:(NSInteger)age
                             Email:(NSString *)email
                           success:(void(^)())success
                           failure:(void(^)())failure;

+ (void) userLoginWithName:(NSString *)accountName
                  password:(NSString *)password
                   success:(void (^)())success
                   failure:(void (^)())failure;

+ (void) userLogoutWithSuccess:(void (^)())success
                       failure:(void (^)())failure;

+ (void) requestNewsWithSuccess:(void (^)())success
                        failure:(void (^)())failure;

+ (void) requestIntroduceWithSuccess:(void (^)(NSString *))success
                             failure:(void (^)())failure;

+ (void) requestUserInformationWithToken:(NSString *)token
                                 success:(void (^)())success
                                 failure:(void (^)())failure;


///**
// *  促销信息
// *
// *  @param type 促销信息，0返回三条信息（用于首页轮播），1返回全部信息
// *
// *  @return
// */
//+ (NSInteger) requestSalesWithType:(NSInteger) type;
//
//
//+ (NSInteger) updateUserInformationWithSex:(NSString *)sex age:(NSString *)age Email:(NSString *)email phone:(NSString *)phone photo:(NSString *)photo name:(NSString *)name birth:(NSString *)birth cardID:(NSString *)cardID degree:(NSString *)degree job:(NSString *)job province:(NSString *)province city:(NSString *)city district:(NSString *)district address:(NSString *)address isBought:(BOOL)isBought brand:(NSString *)brand way:(NSString *)way experience:(NSString *)experience recommendName:(NSString *)recommendName recommendPhone:(NSString *)recommendPhone;
//
//+ (NSInteger) requestProductKind;
//
//+ (NSInteger) requestProductTypeWithKind:(NSString *)productKind;
//
//+ (NSInteger) requestProductListWithKind:(NSString *)productKind type:(NSString *)productType;
//
//+ (NSInteger) requestProductDetailWithID:(NSString *)productID;
//
//+ (NSInteger) searchProductWithName:(NSString *)name;
//
//+ (NSInteger) requestMallWithName:(NSString *)name;

@end
