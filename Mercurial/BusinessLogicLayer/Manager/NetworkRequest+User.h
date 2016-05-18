//
//  NetworkRequest+User.h
//  Mercurial
//
//  Created by zhaoqin on 4/13/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "NetworkRequest.h"

@interface NetworkRequest (User)

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
                      success:(NetworkFetcherCompletionHandler)success
                      failure:(NetworkFetcherErrorHandler)failure;

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
                   failure:(void (^)(NSString *error))failure;

/**
 *  注销
 *
 *  @param success
 *  @param failure
 */
+ (void) userLogoutWithSuccess:(void (^)())success
                       failure:(void (^)(NSString *error))failure;

/**
 *  获取用户信息
 *
 *  @param token
 *  @param success
 *  @param failure
 */
+ (void) requestUserInformationWithToken:(void (^)())success
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
                              failure:(void (^)(NSString *error))failure;

/**
 *  上传头像
 *
 *  @param path 头像路径
 */
+ (void) uploadAvatar:(UIImage *)image
              success:(void (^)())success
              failure:(void (^)())failure;

/**
 *  修改密码
 *
 *  @param name
 *  @param oldPassword
 *  @param newPassword
 *  @param success
 *  @param failure
 */
+ (void) revisePasswordWithName:(NSString *)name
                    oldPassword:(NSString *)oldPassword
                    newPassword:(NSString *)newPassword
                        success:(void (^)())success
                        failure:(void (^)(NSString *error))failure;

/**
 *  修改密码验证码
 *
 *  @param phone   手机号
 *  @param success
 *  @param failure 
 */
+ (void) fetchSmsCode:(NSString *)phone
              success:(void (^)(NSString *sid))success
              failure:(void (^)(NSString *error))failure;



+ (void) forgetPasswordWithSid:(NSString *)sid
                      password:(NSString *)password
                          code:(NSString *)code
                       success:(void (^)())success
                       failure:(void (^)(NSString *error))failure;
@end
