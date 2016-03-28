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
#import "NewsManager.h"
#import "ProductManager.h"
#import "SalesManager.h"
#import "News.h"
#import "ProductKind.h"
#import "ProductType.h"
#import "Product.h"
#import "Sales.h"

#define URLPREFIX @"http://yyzwt.cn:12345"

@interface NetworkRequest : NSObject

/**
 *  注册
 *
 *  @param name
 *  @param password
 *  @param phone
 *  @param sex
 *  @param age
 *  @param email
 *  @param success  callback
 *  @param failure  callback
 */
+ (void) userRegisterWithName:(NSString *)name
                          password:(NSString *)password
                             phone:(NSString *)phone
                               sex:(NSString *)sex
                               age:(NSInteger)age
                             Email:(NSString *)email
                           success:(void(^)())success
                           failure:(void(^)())failure;

/**
 *  登陆
 *
 *  @param accountName
 *  @param password
 *  @param success
 *  @param failure
 */
+ (void) userLoginWithName:(NSString *)accountName
                  password:(NSString *)password
                   success:(void (^)())success
                   failure:(void (^)())failure;

/**
 *  注销
 *
 *  @param success
 *  @param failure
 */
+ (void) userLogoutWithSuccess:(void (^)())success
                       failure:(void (^)())failure;

/**
 *  获取新闻
 *
 *  @param success
 *  @param failure
 */
+ (void) requestNewsWithSuccess:(void (^)())success
                        failure:(void (^)())failure;

/**
 *  获取公司介绍
 *
 *  @param success
 *  @param failure
 */
+ (void) requestIntroduceWithSuccess:(void (^)(NSString *url))success
                             failure:(void (^)())failure;

/**
 *  获取用户信息
 *
 *  @param token
 *  @param success
 *  @param failure
 */
+ (void) requestUserInformationWithToken:(NSString *)token
                                 success:(void (^)())success
                                 failure:(void (^)())failure;



//+ (NSInteger) updateUserInformationWithSex:(NSString *)sex age:(NSString *)age Email:(NSString *)email phone:(NSString *)phone photo:(NSString *)photo name:(NSString *)name birth:(NSString *)birth cardID:(NSString *)cardID degree:(NSString *)degree job:(NSString *)job province:(NSString *)province city:(NSString *)city district:(NSString *)district address:(NSString *)address isBought:(BOOL)isBought brand:(NSString *)brand way:(NSString *)way experience:(NSString *)experience recommendName:(NSString *)recommendName recommendPhone:(NSString *)recommendPhone;

/**
 *  获取产品种类列表
 *
 *  @param success
 *  @param failure
 */
+ (void) requestProductKindSuccess:(void (^)()) success
                           failure:(void (^)()) failure;

/**
 *  获取产品类型列表
 *
 *  @param productKindID
 *  @param success
 *  @param failure
 */
+ (void) requestProductTypeWithKind:(NSString *)productKindID
                            success:(void (^)())success
                            failure:(void (^)())failure;

/**
 *  获取产品列表
 *
 *  @param productKindID
 *  @param productTypeID
 *  @param success
 *  @param failure
 */
+ (void) requestProductListWithKind:(NSString *)productKindID
                               type:(NSString *)productTypeID
                            success:(void (^)())success
                            failure:(void (^)())failure;

/**
 *  获取产品细节列表
 *
 *  @param productID
 *  @param success
 *  @param failure
 */
+ (void) requestProductDetailWithID:(NSString *)productID
                            success:(void (^)())success
                            failure:(void (^)())failure;

/**
 *  根据产品名搜索产品列表
 *
 *  @param name
 *  @param success
 *  @param failure
 */
+ (void) searchProductWithName:(NSString *)name
                       success:(void (^)())success
                       failure:(void (^)())failure;

/**
 *  获取平台URL
 *
 *  @param platform 平台名称
 *  @param success
 *  @param failure
 */
+ (void) requestMallWithName:(NSString *)platform
                     success:(void (^)(NSString *))success
                     failure:(void (^)())failure;

/**
 *  促销信息
 *
 *  @param type    0为轮播信息，返回三条数据；1为获取全部促销数据
 *  @param success
 *  @param failure
 */
+ (void) requestSalesType:(NSNumber *)type
                  success:(void (^)())success
                  failure:(void (^)())failure;

@end
