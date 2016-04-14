//
//  NetworkRequest+Order.h
//  Mercurial
//
//  Created by zhaoqin on 4/14/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "NetworkRequest.h"

@interface NetworkRequest (Order)

/**
 *  查询订单列表
 *
 *  @param success
 *  @param failure
 */
+ (void) requestOrderListWithSuccess:(void (^)())success
                             failure:(void (^)())failure;

/**
 *  添加、修改订单信息，如果订单号已经存在则是修改订单信息
 *
 *  @param orderID
 *  @param name
 *  @param province
 *  @param city
 *  @param district
 *  @param address
 *  @param phone
 *  @param date
 *  @param success
 *  @param failure
 */
+ (void) requestAddOrderWithID:(NSString *)order_id
                          name:(NSString *)username
                      province:(NSString *)delivery_province
                          city:(NSString *)delivery_city
                      district:(NSString *)delivery_district
                       address:(NSString *)delivery_address
                         phone:(NSString *)phone
                          date:(NSString *)buy_date
                          item:(NSMutableArray *)items
                       success:(void (^)())success
                       failure:(void (^)(NSString *error))failure;

/**
 *  根据id查询订单
 *
 *  @param orderID
 *  @param success
 *  @param failure
 */
+ (void) requestSearchOrder:(NSString *)orderID
                    success:(void (^)())success
                    failure:(void (^)())failure;


/**
 *  删除当前用户创建的订单
 *
 *  @param orderID
 *  @param success
 *  @param failure
 */
+ (void) requestDeleteOrder:(NSString *)orderID
                    success:(void (^)())success
                    failure:(void (^)())failure;

/**
 *  添加客户推荐
 *
 *  @param recomm_name
 *  @param recomm_phone
 *  @param province
 *  @param city
 *  @param district
 *  @param address
 *  @param recomm_product_name
 *  @param date
 *  @param recomm_reason
 */
+ (void) requestAddCommend:(NSString *)recomm_name
                     phone:(NSString *)recomm_phone
                  province:(NSString *)province
                      city:(NSString *)city
                  district:(NSString *)district
                   address:(NSString *)address
               commendName:(NSString *)recomm_product_name
                      date:(NSString *)date
                    reason:(NSString *)recomm_reason
                   success:(void (^)())success
                   failure:(void (^)(NSString *error))failure;

/**
 *  修改用户推荐
 *
 *  @param recomm_name
 *  @param recomm_phone
 *  @param province
 *  @param city
 *  @param district
 *  @param address
 *  @param recomm_product_name
 *  @param date
 *  @param recomm_reason
 *  @param recommentID
 *  @param success
 *  @param failure
 */
+ (void) requestUpdateCommend:(NSString *)recomm_name
                        phone:(NSString *)recomm_phone
                     province:(NSString *)province
                         city:(NSString *)city
                     district:(NSString *)district
                      address:(NSString *)address
                  commendName:(NSString *)recomm_product_name
                         date:(NSString *)date
                       reason:(NSString *)recomm_reason
                  recommentID:(NSString *)recommentID
                      success:(void (^)())success
                      failure:(void (^)(NSString *error))failure;

/**
 *  获取客户推荐列表
 *
 *  @param success
 *  @param failure
 */
+ (void) requestCommendList:(void (^)())success
                    failure:(void (^)())failure;

/**
 *  查看特定的推荐列表信息
 *
 *  @param commendID
 *  @param success
 *  @param failure
 */
+ (void) requestCommendItem:(NSString *)commendID
                    success:(void (^)())success
                    failure:(void (^)())failure;

@end
