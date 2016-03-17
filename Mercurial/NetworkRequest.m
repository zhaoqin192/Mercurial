//
//  NetworkRequest.m
//  Mercurial
//
//  Created by zhaoqin on 3/16/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "NetworkRequest.h"

@implementation NetworkRequest


+ (void) userRegisterWithName:(NSString *)name
                     password:(NSString *)password
                        phone:(NSString *)phone
                          sex:(NSString *)sex
                          age:(NSInteger)age
                        Email:(NSString *)email
                      success:(void (^)())success
                      failure:(void (^)())failure{
    
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *url = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/register"]];
    NSDictionary *parameters = @{@"name":name, @"passwd":[Utility md5:password], @"phone":phone, @"sex":sex, @"age":[NSNumber numberWithInteger:age], @"mail":email};
    
    [manager POST:url.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        failure();
    }];
    
}

+ (void) userLoginWithName:(NSString *)accountName
                  password:(NSString *)password
                   success:(void (^)())success
                   failure:(void (^)())failure{
    
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *url = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/login"]];
    NSDictionary *parameters = @{@"name":accountName, @"passwd":[Utility md5:password]};
    
    [manager POST:url.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
//        [[DatabaseManager sharedAccount] insertWithAccountName:accountName password:password token:token success: success:^{
//             success();
//        }];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        failure();
    }];
}

+ (void) userLogoutWithSuccess:(void (^)())success
                       failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *url = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/logout"]];
    NSString *token = [[[DatabaseManager sharedAccount] getAccount] token];
    NSDictionary *parameters = @{@"sid": token};
    
    [manager POST:url.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure();
    }];
}

+ (void) requestNewsWithSuccess:(void (^)())success
                        failure:(void (^)())failure{
    
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *url = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Company/Index/news"]];
    
    [manager POST:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure();
    }];
}

+ (void) requestIntroduceWithSuccess:(void (^)(NSString *))success
                             failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *url = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Company/Index/companyAbout"]];
    
    [manager POST:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(@"");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure();
    }];
}

+ (void) requestUserInformationWithToken:(NSString *)token
                                 success:(void (^)())success
                                 failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *url = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/get_user_info"]];
    
    NSDictionary *parameters = @{@"sid": [[[DatabaseManager sharedAccount] getAccount] token]};
    [manager POST:url.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure();
    }];

}

//
//+ (NSInteger) requestSalesWithType:(NSInteger) type;
//
//+ (NSInteger) requestUserInformation;
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
