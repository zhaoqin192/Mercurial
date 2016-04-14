//
//  NetworkRequest+Order.m
//  Mercurial
//
//  Created by zhaoqin on 4/14/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "NetworkRequest+Order.h"
#import "NetworkManager.h"
#import "DatabaseManager.h"
#import "AccountDao.h"
#import "Account.h"
#import "OrderManager.h"
#import "AddOrder.h"
#import "MJExtension.h"
#import "SearchOrder.h"
#import "RecommendManager.h"
#import "Recommend.h"
#import "Order.h"


@implementation NetworkRequest (Order)

+ (void) requestOrderListWithSuccess:(void (^)())success
                             failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Product/Index/search_order_list"]];
    
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    
    
    NSDictionary *parameters = @{@"sid": account.token};
    
    [manager POST:URL.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSArray *array = responseObject;
        OrderManager *manager = [OrderManager sharedManager];
        [manager.orderArray removeAllObjects];
        for(NSDictionary *dic in array){
            [manager.orderArray addObject:[dic objectForKey:@"order_id"]];
        }
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        failure();
    }];
}

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
                       failure:(void (^)(NSString *error))failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Product/Index/add_order"]];
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    
    AddOrder *addOrder = [[AddOrder alloc] init];
    addOrder.order_id = order_id;
    addOrder.username = username;
    addOrder.delivery_province = delivery_province;
    addOrder.delivery_city = delivery_city;
    addOrder.delivery_district = delivery_district;
    addOrder.delivery_address = delivery_address;
    addOrder.phone = phone;
    addOrder.buy_date = buy_date;
    addOrder.items = items;
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:addOrder.mj_keyValues options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *parames = @{@"sid": account.token, @"json": jsonString};
    
    [manager POST:URL.absoluteString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSDictionary *dic = responseObject;
        if([[dic objectForKey:@"status"] isEqualToString:@"200"]){
            success();
        }else{
            failure([dic objectForKey:@"error"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure(@"Network Error");
    }];
    
}

+ (void) requestSearchOrder:(NSString *)orderID
                    success:(void (^)())success
                    failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Product/Index/search_order"]];
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    
    NSDictionary *parames = @{@"sid": account.token, @"order_id": orderID};
    [manager POST:URL.absoluteString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSDictionary *dic = responseObject;
        OrderManager *orderManager = [OrderManager sharedManager];
        orderManager.searchOrder = [SearchOrder mj_objectWithKeyValues:dic];
        orderManager.searchOrder.items = [Order mj_objectArrayWithKeyValuesArray:dic[@"items"]];
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure();
    }];
    
    
}

+ (void) requestDeleteOrder:(NSString *)orderID
                    success:(void (^)())success
                    failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Product/Index/delete_order"]];
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    
    NSDictionary *parames = @{@"sid": account.token, @"order_id": orderID};
    [manager POST:URL.absoluteString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure();
    }];
    
}

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
                   failure:(void (^)(NSString *error))failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/add_user_recomm"]];
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    
    NSDictionary *parames = @{@"sid": account.token, @"recomm_name": recomm_name, @"recomm_phone": recomm_phone, @"province": province, @"city": city, @"district": district, @"address": address, @"recomm_product_name": recomm_product_name, @"date": date, @"recomm_reason": recomm_reason};
    
    [manager POST:URL.absoluteString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSDictionary *dic = responseObject;
        if([[dic objectForKey:@"status"] isEqualToString:@"200"]){
            success();
        }else{
            failure([dic objectForKey:@"error"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure(@"Network Error");
    }];
    
}

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
                      failure:(void (^)(NSString *error))failure{
    
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/add_user_recomm"]];
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    
    NSDictionary *parames = @{@"sid": account.token, @"recomm_name": recomm_name, @"recomm_phone": recomm_phone, @"province": province, @"city": city, @"district": district, @"address": address, @"recomm_product_name": recomm_product_name, @"date": date, @"recomm_reason": recomm_reason, @"user_recomm_id": recommentID};
    
    [manager POST:URL.absoluteString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSDictionary *dic = responseObject;
        if([[dic objectForKey:@"status"] isEqualToString:@"200"]){
            success();
        }else{
            failure([dic objectForKey:@"error"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure(@"Network Error");
    }];
    
    
}



+ (void) requestCommendList:(void (^)())success
                    failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/get_user_recomm_list"]];
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    
    NSDictionary *parames = @{@"sid": account.token};
    
    [manager POST:URL.absoluteString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        RecommendManager *manager = [RecommendManager sharedManager];
        manager.commendArray = [Recommend mj_objectArrayWithKeyValuesArray:responseObject];
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure();
    }];
    
}

+ (void) requestCommendItem:(NSString *)commendID
                    success:(void (^)())success
                    failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/get_user_recomm_item"]];
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    
    NSDictionary *parames = @{@"sid": account.token, @"user_recomm_id": commendID};
    
    [manager POST:URL.absoluteString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        RecommendManager *manager = [RecommendManager sharedManager];
        manager.recommend = [Recommend mj_objectWithKeyValues:responseObject];
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure();
    }];
    
}


@end
