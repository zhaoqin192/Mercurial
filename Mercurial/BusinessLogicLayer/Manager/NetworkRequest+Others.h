//
//  NetworkRequest+Others.h
//  Mercurial
//
//  Created by zhaoqin on 4/14/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "NetworkRequest.h"

@interface NetworkRequest (Others)

/**
 *  获取新闻
 *
 *  @param success
 *  @param failure
 */
+ (void) requestNewsWithSuccess:(void (^)())success
                        failure:(void (^)(NSString *error))failure;

/**
 *  获取公司介绍
 *
 *  @param success
 *  @param failure
 */
+ (void) requestIntroduceWithSuccess:(void (^)(NSString *url))success
                             failure:(void (^)(NSString *error))failure;



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


/**
 *  防伪查询
 *
 *  @param productID
 *  @param success
 *  @param failure
 */
+ (void) requestFakeSearch:(NSString *)productID
                   success:(void (^)())success
                   failure:(void (^)(NSString *error))failure;


@end
