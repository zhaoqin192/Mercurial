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
#import "MJExtension.h"
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
#import "Order.h"
#import "OrderManager.h"
#import "AddOrder.h"
#import "RecommendManager.h"
#import "TopicManager.h"
#import "AnswerManager.h"
#import "TypeManager.h"
#import "MessageManager.h"

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

/**
 *
 *  更新用户信息
 *
 */
+ (void) updateUserInformationWithSex:(NSString *)sex
                                  age:(NSString *)age
                                Email:(NSString *)email
                                phone:(NSString *)phone
                                photo:(NSString *)photo
                                 name:(NSString *)name
                                birth:(NSString *)birth
                               cardID:(NSString *)cardID
                               degree:(NSString *)degree
                                  job:(NSString *)job
                             province:(NSString *)province
                                 city:(NSString *)city
                             district:(NSString *)district
                              address:(NSString *)address
                             isBought:(BOOL)isBought
                                brand:(NSString *)brand
                                  way:(NSString *)way
                           experience:(NSString *)experience
                        recommendName:(NSString *)recommendName
                       recommendPhone:(NSString *)recommendPhone
                              success:(void (^)())success
                              failure:(void (^)())failure;

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

/**
 *
 *  产品推荐
 *
 */
//+ (void) requestProductCommend;

/**
 *  上传头像
 *
 *  @param path 头像路径
 */
+ (void) uploadAvatar:(UIImage *)image
              success:(void (^)())success
              failure:(void (^)())failure;

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
                       failure:(void (^)())failure;

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
                   failure:(void (^)())failure;

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

/**
 *  防伪查询
 *
 *  @param productID
 *  @param success
 *  @param failure
 */
+ (void) requestFakeSearch:(NSString *)productID
                   success:(void (^)())success
                   failure:(void (^)())failure;

/**
 *  帖子列表
 *
 *  @param type    type为nil，则返回所有帖子；参数为:区域id（type = product_area_id）、系列id（type = product_type_id）、价位id（type = product_price_id）、装修经验id（type = product_decro_experience_id）、其他id（type = product_other_id）；
 *  @param typeID  具体的id
 *  @param success
 *  @param failure
 */
+ (void) requestTopicList:(NSString *)type
                       id:(NSString *)typeID
                  success:(void (^)())success
                  failure:(void (^)())failure;

/**
 *  帖子对应的楼层列表
 *
 *  @param topicID
 *  @param success
 *  @param failure
 */
+ (void) requestTopicAnswerList:(NSString *)topicID
                        success:(void (^)())success
                        failure:(void (^)())failure;

/**
 *  筛选选项
 *
 *  @param type    筛选条件包括区域（type = product_area）、系列（type = product_type）、价位（type = product_price）、装修经验（type = product_decro_experience）、其他（type = product_other）
 *  @param success
 *  @param failure
 */
+ (void) requestTopicCondition:(NSString *)type
                       success:(void (^)())success
                       failure:(void (^)())failure;

/**
 *  发帖（帖子中带有图片，方法是先上传文字内容，然后返回topic_id和forum_answer_id,再上传图片，上述过程完成后，显示发帖成功）
 *
 *  @param title
 *  @param text
 *  @param type
 *  @param typeID
 *  @param success
 *  @param failure
 */
+ (void) requestSendTopic:(NSString *)title
                     text:(NSString *)text
                     type:(NSString *)type
                   typeID:(NSString *)typeID
                  success:(void (^)(NSString *, NSString *))success
                  failure:(void (^)())failure;

/**
 *  发帖中的图片
 *
 *  @param topicID
 *  @param formID
 *  @param success
 *  @param failure
 */
+ (void) uploadTopicPic:(NSString *)topicID
          forumAnswerID:(NSString *)forumAnswerID
                success:(void (^)())success
                failure:(void (^)())failure;

/**
 *  楼层回复
 *
 *  @param topicID
 *  @param text
 *  @param name
 *  @param floor
 *  @param success
 *  @param failure
 */
+ (void) requestReplyTopic:(NSString *)topicID
                      text:(NSString *)text
          answerToUsername:(NSString *)name
                   toFloor:(NSNumber *)floor
                   success:(void (^)(NSString *))success
                   failure:(void (^)())failure;

/**
 *  获得消息列表
 *
 *  @param success
 *  @param failure
 */
+ (void) requestMessageList:(void (^)())success
                    failure:(void (^)())failure;

/**
 *  阅读消息，调用该接口，即表示阅读完这条消息
 *
 *  @param topicID
 *  @param success
 *  @param failure
 */
+ (void) requestReadMessage:(NSString *)topicID
                    success:(void (^)())success
                    failure:(void (^)())failure;
@end























