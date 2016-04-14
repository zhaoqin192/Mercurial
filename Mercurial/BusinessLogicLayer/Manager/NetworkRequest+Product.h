//
//  NetworkRequest+Product.h
//  Mercurial
//
//  Created by zhaoqin on 4/14/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "NetworkRequest.h"

@interface NetworkRequest (Product)

/**
 *  获取产品种类列表
 *
 *  @param success
 *  @param failure
 */
+ (void) requestProductKindSuccess:(BOOL)isCommand
                           success:(void (^)()) success
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


@end
