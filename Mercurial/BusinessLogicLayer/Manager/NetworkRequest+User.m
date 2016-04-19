//
//  NetworkRequest+User.m
//  Mercurial
//
//  Created by zhaoqin on 4/13/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "NetworkRequest+User.h"
#import "NetworkManager.h"
#import "DatabaseManager.h"
#import "AccountDao.h"
#import "Account.h"
#import "Utility.h"

@implementation NetworkRequest (User)

//+ (void) userRegisterWithName:(NSString *)name
//                     password:(NSString *)password
//                        phone:(NSString *)phone
//                          sex:(NSString *)sex
//                          age:(NSInteger)age
//                        Email:(NSString *)email
//                      success:(void (^)())success
//                      failure:(void (^)(NSString *error))failure{
//    
//    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
//    NSURL *url = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/register"]];
//    NSDictionary *parameters = @{@"name":name, @"passwd":[Utility md5:password], @"phone":phone, @"sex":sex, @"age":[NSNumber numberWithInteger:age], @"mail":email};
//    
//    [manager POST:url.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dic = responseObject;
//        if([[dic objectForKey:@"status"] isEqualToString:@"200"]){
//            success();
//        }else{
//            failure([dic objectForKey:@"error"]);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        failure(@"Network Error");
//    }];
//    
//}

+ (void) userRegisterWithName:(NSString *)name
                     password:(NSString *)password
                        phone:(NSString *)phone
                          sex:(NSString *)sex
                          age:(NSInteger)age
                        Email:(NSString *)email
                      success:(NetworkFetcherCompletionHandler)success
                      failure:(NetworkFetcherErrorHandler)failure{
    
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *url = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/register"]];
    NSDictionary *parameters = @{@"name":name, @"passwd":[Utility md5:password], @"phone":phone, @"sex":sex, @"age":[NSNumber numberWithInteger:age], @"mail":email};
    
    [manager POST:url.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        if([[dic objectForKey:@"status"] isEqualToString:@"200"]){
            success();
        }else{
            failure([dic objectForKey:@"error"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(@"Network Error");
    }];

}

+ (void) userLoginWithName:(NSString *)accountName
                  password:(NSString *)password
                   success:(void (^)())success
                   failure:(void (^)(NSString *error))failure{
    
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *url = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/login"]];
    NSDictionary *parameters = @{@"name":accountName, @"passwd":[Utility md5:password]};
    
    [manager POST:url.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        if([[responseObject objectForKey:@"status"] isEqualToString:@"200"]){
            NSString *token = [dic objectForKey:@"sid"];
            [[DatabaseManager sharedAccount] insertWithAccountName:accountName password:password token:token success:^{
                success();
            }];
        }else{
            [[DatabaseManager sharedAccount] insertWithAccountName:accountName password:password token:nil success:^{
                failure([dic objectForKey:@"error"]);
            }];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(@"Network Error");
    }];
}

+ (void) userLogoutWithSuccess:(void (^)())success
                       failure:(void (^)(NSString *error))failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *url = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/logout"]];
    
    Account *acount = [[DatabaseManager sharedAccount] getAccount];
    
    NSString *token = acount.token;
    
    NSDictionary *parameters = @{@"sid": token};
    
    [manager POST:url.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        if([[dic objectForKey:@"status"] isEqualToString:@"200"]){
            [[DatabaseManager sharedAccount] deleteAccountSuccess:^{
                success();
            } failure:^{
                failure(@"Database Error");
            }];
        }else{
            failure([dic objectForKey:@"error"]);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(@"Network Error");
    }];
}


+ (void) requestUserInformationWithToken:(void (^)())success
                                 failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *url = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/get_user_info"]];
    
    NSDictionary *parameters = @{@"sid": [[[DatabaseManager sharedAccount] getAccount] token]};
    [manager POST:url.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSArray *array = responseObject;
        NSDictionary *dic = [array objectAtIndex:0];
        NSLog(@"%@",[dic objectForKey:@"card_number"]);
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        
        [[DatabaseManager sharedAccount] insertWithAccountName:[dic objectForKey:@"name"] phone:[dic objectForKey:@"phone"] sex:[dic objectForKey:@"sex"] age:[[dic objectForKey:@"age"] intValue] Email:[dic objectForKey:@"mail"] fixedTel:[dic objectForKey:@"fix_phone"] avatar:[dic objectForKey:@"photo"] name:[dic objectForKey:@"realname"] birth:[dic objectForKey:@"birth"] cardID:[dic objectForKey:@"card_number"] degree:[dic objectForKey:@"degree"] job:[dic objectForKey:@"job"] province:[dic objectForKey:@"province"] city:[dic objectForKey:@"city"] district:[dic objectForKey:@"district"] address:[dic objectForKey:@"address"] isBought:[[dic objectForKey:@"has_bought"] intValue] brand:[dic objectForKey:@"bought_brand"] way:[dic objectForKey:@"know_way"] experience:[dic objectForKey:@"decro_experience"] recommendName:[dic objectForKey:@"recomm_name"] recommendPhone:[dic objectForKey:@"recomm_phone"] success:success];
        success();
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        failure();
    }];
    
}

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
                              failure:(void (^)(NSString *error))failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/save_user_info"]];
    
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    
    NSString *has_bought = (isBought)? @"true":@"false";
    
    NSDictionary *parameters = @{@"sid": account.token, @"sex": sex,@"age":age,@"has_bought":isBought? @(1):@(0),@"mail": email, @"fix_phone": phone, @"photo": photo, @"realname": name, @"birth": birth, @"card_number": cardID, @"degree": degree, @"job": job, @"province": province, @"city": city, @"district": district, @"address": address, @"has_bought": has_bought, @"bought_brand": brand, @"know_way": way, @"decro_experience": experience, @"recomm_name": recommendName, @"recomm_phone": recommendPhone};
    
    [manager POST:URL.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *dic = responseObject;
        if([[dic objectForKey:@"status"] isEqualToString:@"200"]){
            success();
        }else{
            failure([dic objectForKey:@"error"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        failure(@"Network Error");
    }];
    
}

+ (void) uploadAvatar:(UIImage *)image
              success:(void (^)())success
              failure:(void (^)())failure{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.001);
    
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    NSDictionary *parameters = @{@"sid": account.token};
    
    [manager POST:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/upload"] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure();
        NSLog(@"Error: %@", error);
    }];
    
}

+ (void) revisePasswordWithName:(NSString *)name
                    oldPassword:(NSString *)oldPassword
                    newPassword:(NSString *)newPassword
                        success:(void (^)())success
                        failure:(void (^)(NSString *error))failure{
    
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *url = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/revise"]];
    NSDictionary *parameters = @{@"name":name, @"old_passwd": oldPassword, @"new_passwd": newPassword};
    
    [manager POST:url.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        if([[dic objectForKey:@"status"] isEqualToString:@"200"]){
            success();
        }else{
            failure([dic objectForKey:@"error"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(@"Network Error");
    }];
}

@end
